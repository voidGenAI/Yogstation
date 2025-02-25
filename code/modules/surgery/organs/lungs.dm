/obj/item/organ/lungs
	var/failed = FALSE
	var/operated = FALSE	//whether we can still have our damages fixed through surgery
	name = "lungs"
	icon_state = "lungs"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LUNGS
	gender = PLURAL
	w_class = WEIGHT_CLASS_SMALL

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY * 0.9 // fails around 16.5 minutes, lungs are one of the last organs to die (of the ones we have)

	high_threshold_passed = span_warning("You feel some sort of constriction around your chest as your breathing becomes shallow and rapid.")
	now_fixed = span_warning("Your lungs seem to once again be able to hold air.")
	high_threshold_cleared = span_info("The constriction around your chest loosens as your breathing calms down.")

	//Breath damage

	var/safe_oxygen_min = 16 // Minimum safe partial pressure of O2, in kPa
	var/safe_oxygen_max = 0
	var/safe_nitro_min = 0
	var/safe_nitro_max = 0
	var/safe_co2_min = 0
	var/safe_co2_max = 10 // Yes it's an arbitrary value who cares?
	var/safe_toxins_min = 0
	var/safe_toxins_max = 0.05
	var/SA_para_min = 1 //Sleeping agent
	var/SA_sleep_min = 5 //Sleeping agent
	var/BZ_trip_balls_min = 1 //BZ gas
	var/gas_stimulation_min = 0.002 //Nitryl and Stimulum
	///list of gasses that can be used in place of oxygen and the amount they are multiplied by, i.e. 1 pp pluox = 8 pp oxygen
	var/list/oxygen_substitutes = list(/datum/gas/pluoxium = 8)

	var/oxy_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/oxy_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/oxy_damage_type = OXY
	var/nitro_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/nitro_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/nitro_damage_type = OXY
	var/co2_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/co2_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/co2_damage_type = OXY
	var/tox_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/tox_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/tox_damage_type = TOX

	var/cold_message = "your face freezing and an icicle forming"
	var/cold_level_1_threshold = 260
	var/cold_level_2_threshold = 200
	var/cold_level_3_threshold = 120
	var/cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	var/cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	var/cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	var/cold_damage_type = BURN

	var/hot_message = "your face burning and a searing heat"
	var/heat_level_1_threshold = 360
	var/heat_level_2_threshold = 400
	var/heat_level_3_threshold = 1000
	var/heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	var/heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	var/heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	var/heat_damage_type = BURN

	var/crit_stabilizing_reagent = /datum/reagent/medicine/epinephrine


/obj/item/organ/lungs/proc/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	if(H.status_flags & GODMODE)
		return
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		return

	if(!breath || (breath.total_moles() == 0))
		if(H.reagents.has_reagent(crit_stabilizing_reagent, needs_metabolizing = TRUE))
			return
		if(H.health >= H.crit_threshold)
			H.adjustOxyLoss(HUMAN_MAX_OXYLOSS)
		else if(!HAS_TRAIT(H, TRAIT_NOCRITDAMAGE))
			H.adjustOxyLoss(HUMAN_CRIT_MAX_OXYLOSS)

		H.failed_last_breath = TRUE
		if(safe_oxygen_min)
			H.throw_alert("not_enough_oxy", /obj/screen/alert/not_enough_oxy)
		else if(safe_toxins_min)
			H.throw_alert("not_enough_tox", /obj/screen/alert/not_enough_tox)
		else if(safe_co2_min)
			H.throw_alert("not_enough_co2", /obj/screen/alert/not_enough_co2)
		else if(safe_nitro_min)
			H.throw_alert("not_enough_nitro", /obj/screen/alert/not_enough_nitro)
		return FALSE

	var/gas_breathed = 0
	var/eff = get_organ_efficiency()

	//Partial pressures in our breath
	var/O2_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/oxygen))
	for(var/i in oxygen_substitutes)
		O2_pp += oxygen_substitutes[i] * breath.get_breath_partial_pressure(breath.get_moles(i))
	var/N2_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/nitrogen))
	var/Toxins_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/plasma))
	var/CO2_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/carbon_dioxide))


	//-- OXY --//

	//Too much oxygen! //Yes, some species may not like it.
	if(safe_oxygen_max)
		if(O2_pp > safe_oxygen_max)
			var/ratio = (breath.get_moles(/datum/gas/oxygen)/safe_oxygen_max) * 10
			H.apply_damage_type(clamp(ratio, oxy_breath_dam_min, oxy_breath_dam_max), oxy_damage_type)
			H.throw_alert("too_much_oxy", /obj/screen/alert/too_much_oxy)
		else
			H.clear_alert("too_much_oxy")

	//Too little oxygen!
	if(safe_oxygen_min)
		if(O2_pp < safe_oxygen_min)
			gas_breathed = handle_too_little_breath(H, O2_pp, safe_oxygen_min, breath.get_moles(/datum/gas/oxygen))
			H.throw_alert("not_enough_oxy", /obj/screen/alert/not_enough_oxy)
		else
			H.failed_last_breath = FALSE
			if(H.health >= H.crit_threshold)
				H.adjustOxyLoss(-5 * eff)
			gas_breathed = breath.get_moles(/datum/gas/oxygen)
			H.clear_alert("not_enough_oxy")

	//Exhale
	breath.adjust_moles(/datum/gas/oxygen, -gas_breathed)
	breath.adjust_moles(/datum/gas/carbon_dioxide, gas_breathed)
	gas_breathed = 0

	//-- Nitrogen --//

	//Too much nitrogen!
	if(safe_nitro_max)
		if(N2_pp > safe_nitro_max)
			var/ratio = (breath.get_moles(/datum/gas/nitrogen)/safe_nitro_max) * 10
			H.apply_damage_type(clamp(ratio, nitro_breath_dam_min, nitro_breath_dam_max), nitro_damage_type)
			H.throw_alert("too_much_nitro", /obj/screen/alert/too_much_nitro)
		else
			H.clear_alert("too_much_nitro")

	//Too little nitrogen!
	if(safe_nitro_min)
		if(N2_pp < safe_nitro_min)
			gas_breathed = handle_too_little_breath(H, N2_pp, safe_nitro_min, breath.get_moles(/datum/gas/nitrogen))
			H.throw_alert("nitro", /obj/screen/alert/not_enough_nitro)
		else
			H.failed_last_breath = FALSE
			if(H.health >= H.crit_threshold)
				H.adjustOxyLoss(-5 * eff)
			gas_breathed = breath.get_moles(/datum/gas/nitrogen)
			H.clear_alert("nitro")

	//Exhale
	breath.adjust_moles(/datum/gas/nitrogen, -gas_breathed)
	breath.adjust_moles(/datum/gas/carbon_dioxide, gas_breathed)
	gas_breathed = 0

	//-- CO2 --//

	//CO2 does not affect failed_last_breath. So if there was enough oxygen in the air but too much co2, this will hurt you, but only once per 4 ticks, instead of once per tick.
	if(safe_co2_max)
		if(CO2_pp > safe_co2_max)
			if(!H.co2overloadtime) // If it's the first breath with too much CO2 in it, lets start a counter, then have them pass out after 12s or so.
				H.co2overloadtime = world.time
			else if(world.time - H.co2overloadtime > 120)
				H.Unconscious(60)
				H.apply_damage_type(3, co2_damage_type) // Lets hurt em a little, let them know we mean business
				if(world.time - H.co2overloadtime > 300) // They've been in here 30s now, lets start to kill them for their own good!
					H.apply_damage_type(8, co2_damage_type)
				H.throw_alert("too_much_co2", /obj/screen/alert/too_much_co2)
			if(prob(20)) // Lets give them some chance to know somethings not right though I guess.
				H.emote("cough")

		else
			H.co2overloadtime = 0
			H.clear_alert("too_much_co2")

	//Too little CO2!
	if(safe_co2_min)
		if(CO2_pp < safe_co2_min)
			gas_breathed = handle_too_little_breath(H, CO2_pp, safe_co2_min, breath.get_moles(/datum/gas/carbon_dioxide))
			H.throw_alert("not_enough_co2", /obj/screen/alert/not_enough_co2)
		else
			H.failed_last_breath = FALSE
			if(H.health >= H.crit_threshold)
				H.adjustOxyLoss(-5 * organ_efficiency)
			gas_breathed = breath.get_moles(/datum/gas/carbon_dioxide)
			H.clear_alert("not_enough_co2")

	//Exhale
	breath.adjust_moles(/datum/gas/carbon_dioxide, -gas_breathed)
	breath.adjust_moles(/datum/gas/oxygen, gas_breathed)
	gas_breathed = 0


	//-- TOX --//

	//Too much toxins!
	if(safe_toxins_max)
		if(Toxins_pp > safe_toxins_max)
			var/ratio = (breath.get_moles(/datum/gas/plasma)/safe_toxins_max) * 10
			H.apply_damage_type(clamp(ratio, tox_breath_dam_min, tox_breath_dam_max), tox_damage_type)
			H.throw_alert("too_much_tox", /obj/screen/alert/too_much_tox)
		else
			H.clear_alert("too_much_tox")


	//Too little toxins!
	if(safe_toxins_min)
		if(Toxins_pp < safe_toxins_min)
			gas_breathed = handle_too_little_breath(H, Toxins_pp, safe_toxins_min, breath.get_moles(/datum/gas/plasma))
			H.throw_alert("not_enough_tox", /obj/screen/alert/not_enough_tox)
		else
			H.failed_last_breath = FALSE
			if(H.health >= H.crit_threshold)
				H.adjustOxyLoss(-5 * eff)
			gas_breathed = breath.get_moles(/datum/gas/plasma)
			H.clear_alert("not_enough_tox")

	//Exhale
	breath.adjust_moles(/datum/gas/plasma, -gas_breathed)
	breath.adjust_moles(/datum/gas/carbon_dioxide, gas_breathed)
	gas_breathed = 0


	//-- TRACES --//

	if(breath)	// If there's some other shit in the air lets deal with it here.

	// N2O
		REMOVE_TRAIT(H, TRAIT_SURGERY_PREPARED, "N2O")
		var/SA_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/nitrous_oxide))
		if(SA_pp > SA_para_min) // Enough to make us stunned for a bit
			H.Unconscious(60) // 60 gives them one second to wake up and run away a bit!
			if(SA_pp > SA_sleep_min) // Enough to make us sleep as well
				H.Sleeping(max(H.AmountSleeping() + 40, 200))
				ADD_TRAIT(H, TRAIT_SURGERY_PREPARED, "N2O")
		else if(SA_pp > 0.01)	// There is sleeping gas in their lungs, but only a little, so give them a bit of a warning
			if(prob(20))
				H.emote(pick("giggle", "laugh"))
				SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "chemical_euphoria", /datum/mood_event/chemical_euphoria)
		else
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")


	// BZ

		var/bz_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/bz))
		if(bz_pp > BZ_trip_balls_min)
			H.hallucination += 10
			H.reagents.add_reagent(/datum/reagent/bz_metabolites,5)
			if(prob(33))
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)

		else if(bz_pp > 0.01)
			H.hallucination += 5
			H.reagents.add_reagent(/datum/reagent/bz_metabolites,1)


	// Tritium
		var/trit_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/tritium))
		if (trit_pp > 50)
			H.radiation += trit_pp/2 //If you're breathing in half an atmosphere of radioactive gas, you fucked up.
		else
			H.radiation += trit_pp/10

	// Nitryl
		var/nitryl_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/nitryl))
		if (prob(nitryl_pp))
			to_chat(H, span_alert("Your mouth feels like it's burning!"))
		if (nitryl_pp >40)
			H.emote("gasp")
			H.adjustFireLoss(10)
			if (prob(nitryl_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustFireLoss(nitryl_pp/4)
		gas_breathed = breath.get_moles(/datum/gas/nitryl)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/nitryl,1*eff)

		breath.adjust_moles(/datum/gas/nitryl, -gas_breathed)

// Freon
		var/freon_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/freon))
		if (prob(freon_pp))
			to_chat(H, span_alert("Your mouth feels like it's burning!"))
		if (freon_pp >40)
			H.emote("gasp")
			H.adjustFireLoss(15)
			if (prob(freon_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustFireLoss(freon_pp/4)
		gas_breathed = breath.get_moles(/datum/gas/freon)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/freon,1*eff)

		breath.adjust_moles(/datum/gas/freon, -gas_breathed)

	// Healium
		REMOVE_TRAIT(H, TRAIT_SURGERY_PREPARED, "healium")
		var/healium_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/healium))
		if(healium_pp > SA_sleep_min)
			var/existing = H.reagents.get_reagent_amount(/datum/reagent/healium)
			ADD_TRAIT(H, TRAIT_SURGERY_PREPARED, "healium")
			H.reagents.add_reagent(/datum/reagent/healium,max(0, 1*eff - existing))
			H.adjustFireLoss(-7)
			H.adjustToxLoss(-5)
			H.adjustBruteLoss(-5)
		gas_breathed = breath.get_moles(/datum/gas/healium)
		breath.adjust_moles(/datum/gas/healium, -gas_breathed)

	// Pluonium
		// Inert

	// Zauker
		var/zauker_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/zauker))
		if(zauker_pp > safe_toxins_max)
			H.adjustBruteLoss(25)
			H.adjustOxyLoss(5)
			H.adjustFireLoss(8)
			H.adjustToxLoss(8)
		gas_breathed = breath.get_moles(/datum/gas/zauker)
		breath.adjust_moles(/datum/gas/zauker, -gas_breathed)

	// Halon
		gas_breathed = breath.get_moles(/datum/gas/halon)
		if(gas_breathed > gas_stimulation_min)
			H.adjustOxyLoss(5)
			var/existing = H.reagents.get_reagent_amount(/datum/reagent/halon)
			H.reagents.add_reagent(/datum/reagent/halon,max(0, 1 - existing))
		gas_breathed = breath.get_moles(/datum/gas/halon)
		breath.adjust_moles(/datum/gas/halon, -gas_breathed)

	// Hexane
		gas_breathed = breath.get_moles(/datum/gas/hexane)
		if(gas_breathed > gas_stimulation_min)
			H.hallucination += 50
			H.reagents.add_reagent(/datum/reagent/hexane,5)
			if(prob(33))
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)

	// Stimulum
		gas_breathed = breath.get_moles(/datum/gas/stimulum)
		if (gas_breathed > gas_stimulation_min)
			var/existing = H.reagents.get_reagent_amount(/datum/reagent/stimulum)
			H.reagents.add_reagent(/datum/reagent/stimulum,max(0, 1*eff - existing))
		breath.adjust_moles(/datum/gas/stimulum, -gas_breathed)

	// Miasma
		if (breath.get_moles(/datum/gas/miasma))
			var/miasma_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/miasma))

			//Miasma sickness
			if(prob(0.5 * miasma_pp))
				var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(min(round(max(miasma_pp/2, 1), 1), 6), min(round(max(miasma_pp, 1), 1), 8))
				if(owner.CanContractDisease(miasma_disease))
					//tl;dr the first argument chooses the smaller of miasma_pp/2 or 6(typical max virus symptoms), the second chooses the smaller of miasma_pp or 8(max virus symptom level) //
					miasma_disease.name = "Unknown"//^each argument has a minimum of 1 and rounds to the nearest value. Feel free to change the pp scaling I couldn't decide on good numbers for it.
					miasma_disease.try_infect(owner)

			// Miasma side effects
			switch(miasma_pp)
				if(0.25 to 5)
					// At lower pp, give out a little warning
					SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "smell")
					if(prob(5))
						to_chat(owner, span_notice("There is an unpleasant smell in the air."))
				if(5 to 15)
					//At somewhat higher pp, warning becomes more obvious
					if(prob(15))
						to_chat(owner, span_warning("You smell something horribly decayed inside this room."))
						SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/bad_smell)
				if(15 to 30)
					//Small chance to vomit. By now, people have internals on anyway
					if(prob(5))
						to_chat(owner, span_warning("The stench of rotting carcasses is unbearable!"))
						SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/nauseating_stench)
						owner.vomit()
				if(30 to INFINITY)
					//Higher chance to vomit. Let the horror start
					if(prob(15))
						to_chat(owner, span_warning("The stench of rotting carcasses is unbearable!"))
						SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/nauseating_stench)
						owner.vomit()
				else
					SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "smell")

			// In a full miasma atmosphere with 101.34 pKa, about 10 disgust per breath, is pretty low compared to threshholds
			// Then again, this is a purely hypothetical scenario and hardly reachable
			owner.adjust_disgust(0.1 * miasma_pp)

			breath.adjust_moles(/datum/gas/miasma, -gas_breathed)

		// Clear out moods when no miasma at all
		else
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "smell")

		handle_breath_temperature(breath, H)
	return TRUE


/obj/item/organ/lungs/proc/handle_too_little_breath(mob/living/carbon/human/H = null, breath_pp = 0, safe_breath_min = 0, true_pp = 0)
	. = 0
	if(!H || !safe_breath_min) //the other args are either: Ok being 0 or Specifically handled.
		return FALSE

	if(prob(20))
		H.emote("gasp")
	if(breath_pp > 0)
		var/ratio = safe_breath_min/breath_pp
		H.adjustOxyLoss(min(5*ratio, HUMAN_MAX_OXYLOSS)) // Don't fuck them up too fast (space only does HUMAN_MAX_OXYLOSS after all!
		H.failed_last_breath = TRUE
		. = true_pp*ratio/6
	else
		H.adjustOxyLoss(HUMAN_MAX_OXYLOSS)
		H.failed_last_breath = TRUE


/obj/item/organ/lungs/proc/handle_breath_temperature(datum/gas_mixture/breath, mob/living/carbon/human/H) // called by human/life, handles temperatures
	var/breath_temperature = breath.return_temperature()

	if(!HAS_TRAIT(H, TRAIT_RESISTCOLD)) // COLD DAMAGE
		var/cold_modifier = H.dna.species.coldmod
		if(breath_temperature < cold_level_3_threshold)
			H.apply_damage_type(cold_level_3_damage*cold_modifier, cold_damage_type)
		if(breath_temperature > cold_level_3_threshold && breath_temperature < cold_level_2_threshold)
			H.apply_damage_type(cold_level_2_damage*cold_modifier, cold_damage_type)
		if(breath_temperature > cold_level_2_threshold && breath_temperature < cold_level_1_threshold)
			H.apply_damage_type(cold_level_1_damage*cold_modifier, cold_damage_type)
		if(breath_temperature < cold_level_1_threshold)
			if(prob(20))
				to_chat(H, span_warning("You feel [cold_message] in your [name]!"))

	if(!HAS_TRAIT(H, TRAIT_RESISTHEAT)) // HEAT DAMAGE
		var/heat_modifier = H.dna.species.heatmod
		if(breath_temperature > heat_level_1_threshold && breath_temperature < heat_level_2_threshold)
			H.apply_damage_type(heat_level_1_damage*heat_modifier, heat_damage_type)
		if(breath_temperature > heat_level_2_threshold && breath_temperature < heat_level_3_threshold)
			H.apply_damage_type(heat_level_2_damage*heat_modifier, heat_damage_type)
		if(breath_temperature > heat_level_3_threshold)
			H.apply_damage_type(heat_level_3_damage*heat_modifier, heat_damage_type)
		if(breath_temperature > heat_level_1_threshold)
			if(prob(20))
				to_chat(H, span_warning("You feel [hot_message] in your [name]!"))

/obj/item/organ/lungs/on_life()
	..()
	if((!failed) && ((organ_flags & ORGAN_FAILING)))
		if(owner.stat == CONSCIOUS)
			owner.visible_message(span_userdanger("[owner] grabs [owner.p_their()] throat, struggling for breath!"))
		failed = TRUE
	else if(!(organ_flags & ORGAN_FAILING))
		failed = FALSE
	return

/obj/item/organ/lungs/attackby(obj/item/W, mob/user, params)
	if(!(organ_flags & ORGAN_SYNTHETIC) && organ_efficiency == 1 && W.tool_behaviour == TOOL_CROWBAR)
		user.visible_message(span_notice("[user] extends [src] with [W]!"), span_notice("You use [W] to extend [src]!"), "You hear something stretching.")
		name = "extended [name]"
		icon_state += "-crobar" //shh! don't tell anyone i handed you this card
		safe_oxygen_min *= 2 //SCREAM LOUDER i dont know maybe eventually
		safe_toxins_min *= 2
		safe_nitro_min *= 2 //BREATHE HARDER
		safe_co2_min *= 2
		organ_efficiency = 2 //HOLD YOUR BREATH FOR REALLY LONG
		maxHealth *= 0.5 //This procedure is not legal but i will do it for you

/obj/item/organ/lungs/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 5)
	return S

/obj/item/organ/lungs/plasmaman
	name = "plasma filter"
	desc = "A spongy rib-shaped mass for filtering plasma from the air."
	icon_state = "lungs-plasma"

	safe_oxygen_min = 0 //We don't breath this
	safe_toxins_min = 16 //We breath THIS!
	safe_toxins_max = 0

/obj/item/organ/lungs/xeno
	name = "devolved plasma vessel"
	desc = "A lung-shaped organ vaguely similar to a plasma vessel, restructured from a storage system to a respiratory one."
	icon_state = "lungs-x"

	safe_toxins_max = 0 //lmoa~
	oxygen_substitutes = list(/datum/gas/pluoxium = 8, /datum/gas/plasma = 1)
	heat_level_1_threshold = 313
	heat_level_2_threshold = 353
	heat_level_3_threshold = 600

/obj/item/organ/lungs/xeno/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H) //handling this externally so I don't have to nerf pluoxium, can't handle it internally without removing perpetual pluox or requiring plasma for breathing
	. = ..()
	if(breath)
		var/breath_amt = breath.get_moles(/datum/gas/plasma)
		breath.adjust_moles(/datum/gas/plasma, -breath_amt)
		breath.adjust_moles(/datum/gas/oxygen, breath_amt)

/obj/item/organ/lungs/slime
	name = "vacuole"
	desc = "A large organelle designed to store oxygen and other important gasses."

	safe_toxins_max = 0 //We breathe this to gain POWER.

/obj/item/organ/lungs/slime/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	. = ..()
	if (breath)
		var/plasma_pp = breath.get_breath_partial_pressure(breath.get_moles(/datum/gas/plasma))
		owner.blood_volume += (0.2 * plasma_pp) // 10/s when breathing literally nothing but plasma, which will suffocate you.

/obj/item/organ/lungs/ghetto
	name = "oxygen tanks welded to a modular reciever"
	desc = "A pair of oxygen tanks which have been attached to a modular (oxygen) receiver. They are incapable of supplying air, but can work as a replacement for lungs."
	icon_state = "lungs_g"
	organ_efficiency = 0.5
	organ_flags = ORGAN_SYNTHETIC //the moment i understood the weakness of flesh, it disgusted me, and i yearned for the certainty, of steel

/obj/item/organ/lungs/cybernetic
	name = "cybernetic lungs"
	desc = "A cybernetic version of the lungs found in traditional humanoid entities. Slightly more effecient than organic lungs."
	icon_state = "lungs-c"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = 1.1 * STANDARD_ORGAN_THRESHOLD
	safe_oxygen_min = 13

/obj/item/organ/lungs/cybernetic/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	owner.losebreath = 20

/obj/item/organ/lungs/cybernetic/upgraded
	name = "upgraded cybernetic lungs"
	desc = "A more advanced version of the stock cybernetic lungs, more efficient at, well, breathing. Features higher temperature tolerances and the ability to filter out most potentially harmful gases."
	icon_state = "lungs-c-u"
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	organ_efficiency = 1.5
	safe_oxygen_min = 10
	safe_co2_max = 20
	safe_toxins_max = 20 //Higher resistance to most harmful gasses
	SA_para_min = 3
	SA_sleep_min = 6
	BZ_trip_balls_min = 2

	cold_level_1_threshold = 200
	cold_level_2_threshold = 140
	cold_level_3_threshold = 80

	heat_level_1_threshold = 500
	heat_level_2_threshold = 800
	heat_level_3_threshold = 1400
