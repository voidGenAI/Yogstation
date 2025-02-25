GLOBAL_LIST_EMPTY(data_cores)
GLOBAL_VAR_INIT(primary_data_core, null)

/obj/machinery/ai/data_core
	name = "AI Data Core"
	desc = "A complicated computer system capable of emulating the neural functions of an organic being at near-instantanous speeds."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "hub"

	circuit = /obj/item/circuitboard/machine/ai_data_core
	
	active_power_usage = AI_DATA_CORE_POWER_USAGE
	idle_power_usage = 1000
	use_power = IDLE_POWER_USE

	var/primary = FALSE

	var/valid_ticks = MAX_AI_DATA_CORE_TICKS //Limited to MAX_AI_DATA_CORE_TICKS. Decrement by 1 every time we have an invalid tick, opposite when valid 

	var/warning_sent = FALSE

/obj/machinery/ai/data_core/Initialize()
	. = ..()
	GLOB.data_cores += src
	if(primary && !GLOB.primary_data_core)
		GLOB.primary_data_core = src
	update_icon()

/obj/machinery/ai/data_core/process()
	calculate_validity()


/obj/machinery/ai/data_core/Destroy()
	GLOB.data_cores -= src
	if(GLOB.primary_data_core == src)
		GLOB.primary_data_core = null

	var/list/all_ais = GLOB.ai_list.Copy()

	for(var/mob/living/silicon/ai/AI in contents)
		all_ais -= AI
		if(!AI.is_dying)
			AI.relocate()
    
	for(var/mob/living/silicon/ai/AI in all_ais)
		if(!AI.mind && AI.deployed_shell.mind)
			all_ais += AI.deployed_shell
		

	to_chat(all_ais, span_userdanger("Warning! Data Core brought offline in [get_area(src)]! Please verify that no malicious actions were taken."))
	
	..()

/obj/machinery/ai/data_core/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_screwdriver(user, "hub_o", "hub", O))
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE
	return ..()

/obj/machinery/ai/data_core/examine(mob/user)
	. = ..()
	if(!isobserver(user))
		return
	. += "<b>Networked AI Laws:</b>"
	for(var/mob/living/silicon/ai/AI in GLOB.ai_list)
		var/active_status = ""
		if(!AI.mind && AI.deployed_shell)
			active_status = "(Controlling [FOLLOW_LINK(user, AI.deployed_shell)][AI.deployed_shell.name])"
		else if(!AI.mind)
			active_status = "([span_warning("OFFLINE")])"
			
		. += "<b>[AI] [active_status] has the following laws: </b>"
		for(var/law in AI.laws.get_law_list(include_zeroth = TRUE))
			. += law

/obj/machinery/ai/data_core/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	for(var/mob/living/silicon/ai/AI in contents)
		AI.disconnect_shell()

/obj/machinery/ai/data_core/proc/valid_data_core()
	if(!is_reebe(z) && !is_station_level(z))
		return FALSE
	if(valid_ticks > 0)
		return TRUE
	return FALSE

/obj/machinery/ai/data_core/proc/calculate_validity()
	valid_ticks = clamp(valid_ticks, 0, MAX_AI_DATA_CORE_TICKS)
	
	if(valid_holder())
		if(valid_ticks <= 0)
			update_icon()
		valid_ticks++
		use_power = ACTIVE_POWER_USE
		warning_sent = FALSE
	else
		valid_ticks--
		if(valid_ticks <= 0)
			use_power = IDLE_POWER_USE
			update_icon()
			for(var/mob/living/silicon/ai/AI in contents)
				if(!AI.is_dying)
					AI.relocate()
		if(!warning_sent)
			warning_sent = TRUE
			var/list/send_to = GLOB.ai_list.Copy()
			for(var/mob/living/silicon/ai/AI in send_to)
				if(!AI.mind && AI.deployed_shell.mind)
					send_to += AI.deployed_shell
			to_chat(send_to, span_userdanger("Data core in [get_area(src)] is on the verge of failing! Immediate action required to prevent failure."))
			for(var/mob/living/silicon/ai/AI in send_to)
				AI.playsound_local(AI, 'sound/machines/engine_alert2.ogg', 30)

	if(!(stat & (BROKEN|NOPOWER|EMPED)))
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/env = T.return_air()
		if(env.heat_capacity())
			var/temperature_increase = active_power_usage / env.heat_capacity() //1 CPU = 1000W. Heat capacity = somewhere around 3000-4000. Aka we generate 0.25 - 0.33 K per second, per CPU. 
			env.set_temperature(env.return_temperature() + temperature_increase * AI_TEMPERATURE_MULTIPLIER) //assume all input power is dissipated
			T.air_update_turf()
	
/obj/machinery/ai/data_core/proc/can_transfer_ai()
	if(stat & (BROKEN|NOPOWER|EMPED))
		return FALSE
	if(!valid_data_core())
		return FALSE
	return TRUE
	
/obj/machinery/ai/data_core/proc/transfer_AI(mob/living/silicon/ai/AI)
	AI.forceMove(src)
	if(AI.eyeobj)
		AI.eyeobj.forceMove(get_turf(src))

/obj/machinery/ai/data_core/update_icon()
	cut_overlays()
	
	if(!(stat & (BROKEN|NOPOWER|EMPED)))
		if(!valid_data_core())
			return
		var/mutable_appearance/on_overlay = mutable_appearance(icon, "[initial(icon_state)]_on")
		add_overlay(on_overlay)


/obj/machinery/ai/data_core/primary
	name = "primary AI Data Core"
	desc = "A complicated computer system capable of emulating the neural functions of a human at near-instantanous speeds. This one has a scrawny and faded note saying: 'Primary AI Data Core'"
	primary = TRUE
