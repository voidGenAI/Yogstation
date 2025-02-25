/datum/guardianbuilder
	var/datum/guardian_stats/saved_stats = new
	var/mob/living/target
	var/guardian_name
	var/max_points = 20
	var/points = 20
	var/mob_name = "Guardian"
	var/theme = "magic"
	var/failure_message = "<span class='holoparasite bold'>..And draw a card! It's...blank? Maybe you should try again later.</span>"
	var/used = FALSE
	var/allow_special = FALSE
	var/debug_mode = FALSE

/datum/guardianbuilder/New(mob_name, theme, failure_message, max_points, allow_special, debug_mode)
	..()
	if(mob_name)
		src.mob_name = mob_name
	if(theme)
		src.theme = theme
	if(failure_message)
		src.failure_message = failure_message
	if(max_points)
		src.max_points = max_points
	src.allow_special = allow_special
	src.debug_mode = debug_mode

/datum/guardianbuilder/ui_state(mob/user)
	return GLOB.always_state

/datum/guardianbuilder/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Guardian", "Build-A-Guardian")
		ui.open()

/datum/guardianbuilder/ui_data(mob/user)
	. = list()
	.["guardian_name"] = guardian_name
	.["name"] = mob_name
	.["points"] = calc_points()
	.["ratedskills"] = list()
	.["ratedskills"] += list(list(
						name = "Damage",
						level = saved_stats.damage,
					))
	.["ratedskills"] += list(list(
						name = "Defense",
						level = saved_stats.defense
					))
	.["ratedskills"] += list(list(
						name = "Speed",
						level = saved_stats.speed
					))
	.["ratedskills"] += list(list(
						name = "Potential",
						level = saved_stats.potential
					))
	.["ratedskills"] += list(list(
						name = "Range",
						level = saved_stats.range
					))
	.["melee"] = !saved_stats.ranged
	.["abilities_major"] = list()
	var/list/types = allow_special ? (subtypesof(/datum/guardian_ability/major) - /datum/guardian_ability/major/special) : ((subtypesof(/datum/guardian_ability/major)-/datum/guardian_ability/major/healing) - typesof(/datum/guardian_ability/major/special))
	for(var/ability in types)
		var/datum/guardian_ability/major/GA = new ability
		GA.master_stats = saved_stats
		.["abilities_major"] += list(list(
			name = GA.name,
			desc = GA.desc,
			cost = GA.cost,
			selected = istype(saved_stats.ability, ability),
			available = (points >= GA.cost) && GA.CanBuy(),
			path = "[ability]",
			requiem = istype(GA, /datum/guardian_ability/major/special)
		))
	.["abilities_minor"] = list()
	for(var/ability in subtypesof(/datum/guardian_ability/minor))
		var/datum/guardian_ability/minor/GA = new ability
		GA.master_stats = saved_stats
		.["abilities_minor"] += list(list(
			name = GA.name,
			desc = GA.desc,
			cost = GA.cost,
			selected = saved_stats.HasMinorAbility(ability),
			available = (points >= GA.cost) && GA.CanBuy(),
			path = "[ability]"
		))

/datum/guardianbuilder/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..() || used)
		return
	calc_points()
	switch(action)
		if("name")
			guardian_name = stripped_input(usr, "Name your Guardian", ,"", MAX_NAME_LEN)
		if("set")
			switch(params["name"])
				if("Damage")
					var/lvl = clamp(text2num(params["level"]), 1, 5)
					if((points + (saved_stats.damage > 1 ? saved_stats.damage - 1 : 0)) >= lvl - 1 || lvl == 1)
						saved_stats.damage = lvl
					. = TRUE
				if("Defense")
					var/lvl = clamp(text2num(params["level"]), 1, 5)
					if((points + (saved_stats.defense > 1 ? saved_stats.defense - 1 : 0)) >= lvl - 1 || lvl == 1)
						saved_stats.defense = lvl
					. = TRUE
				if("Speed")
					var/lvl = clamp(text2num(params["level"]), 1, 5)
					if((points + (saved_stats.speed > 1 ? saved_stats.speed - 1 : 0)) >= lvl - 1 || lvl == 1)
						saved_stats.speed = lvl
					. = TRUE
				if("Potential")
					var/lvl = clamp(text2num(params["level"]), 1, 5)
					if((points + (saved_stats.potential > 1 ? saved_stats.potential - 1 : 0)) >= lvl - 1 || lvl == 1)
						saved_stats.potential = lvl
					. = TRUE
				if("Range")
					var/lvl = clamp(text2num(params["level"]), 1, 5)
					if((points + (saved_stats.range > 1 ? saved_stats.range - 1 : 0)) >= lvl - 1 || lvl == 1)
						saved_stats.range = lvl
					. = TRUE
		if("clear_ability_major")
			QDEL_NULL(saved_stats.ability)
		if("ability_major")
			var/ability = text2path(params["path"])
			var/list/types = allow_special ? (subtypesof(/datum/guardian_ability/major) - /datum/guardian_ability/major/special) : ((subtypesof(/datum/guardian_ability/major) - /datum/guardian_ability/major/healing) - typesof(/datum/guardian_ability/major/special))
			if(ispath(ability))
				if(saved_stats.ability && saved_stats.ability.type == ability)
					QDEL_NULL(saved_stats.ability)
				else if(ability in types) // no nullspace narsie for you!
					QDEL_NULL(saved_stats.ability)
					saved_stats.ability = new ability
					saved_stats.ability.master_stats = saved_stats
		if("ability_minor")
			var/ability = text2path(params["path"])
			if(ispath(ability) && (ability in subtypesof(/datum/guardian_ability/minor))) // no nullspace narsie for you!
				if(saved_stats.HasMinorAbility(ability))
					saved_stats.TakeMinorAbility(ability)
				else
					saved_stats.AddMinorAbility(ability)
		if("spawn")
			. = spawn_guardian(usr)
		if("reset")
			QDEL_NULL(saved_stats)
			saved_stats = new
			. = TRUE
		if("ranged")
			if(points >= 3)
				saved_stats.ranged = TRUE
		if("melee")
			saved_stats.ranged = FALSE

/datum/guardianbuilder/proc/calc_points()
	points = max_points
	if(saved_stats.damage > 1)
		points -= saved_stats.damage - 1
	if(saved_stats.defense > 1)
		points -= saved_stats.defense - 1
	if(saved_stats.potential > 1)
		points -= saved_stats.potential - 1
	if(saved_stats.speed > 1)
		points -= saved_stats.speed - 1
	if(saved_stats.range > 1)
		points -= saved_stats.range - 1
	if(saved_stats.ranged)
		points -= 3
	if(saved_stats.ability)
		points -= saved_stats.ability.cost
	for(var/datum/guardian_ability/minor/minor in saved_stats.minor_abilities)
		points -= minor.cost
	return points

/datum/guardianbuilder/proc/spawn_guardian(mob/living/user)
	if(!user || !iscarbon(user) || !user.mind)
		return FALSE
	used = TRUE
	calc_points()
	if(points < 0)
		to_chat(user, span_danger("You don't have enough points for a Guardian like that!"))
		used = FALSE
		return FALSE
	//alerts user in case they didn't know
	var/list/all_items = user.GetAllContents()
	for(var/obj/I in all_items) //Check for mori
		if(istype(I, /obj/item/clothing/neck/necklace/memento_mori))
			to_chat(user, span_danger("The [I] revolts at the sight of the [src]!"))
			used = FALSE
			return FALSE
	// IMPORTANT - if we're debugging, the user gets thrown into the stand
	var/list/mob/dead/observer/candidates = debug_mode ? list(user) : pollGhostCandidates("Do you want to play as the [mob_name] of [user.real_name]? ([saved_stats.short_info()])", ROLE_HOLOPARASITE, null, FALSE, 100, POLL_IGNORE_HOLOPARASITE)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		var/mob/living/simple_animal/hostile/guardian/G = new(user, theme)
		if(guardian_name)
			G.real_name = guardian_name
			G.name = guardian_name
			G.custom_name = TRUE
		G.summoner = user.mind
		G.key = C.key
		G.mind.enslave_mind_to_creator(user)
		G.RegisterSignal(user, COMSIG_MOVABLE_MOVED, /mob/living/simple_animal/hostile/guardian.proc/OnMoved)
		var/datum/antagonist/guardian/S = new
		S.stats = saved_stats
		S.summoner = user.mind
		G.mind.add_antag_datum(S)
		G.stats = saved_stats
		G.stats.Apply(G)
		G.show_detail()
		log_game("[key_name(user)] has summoned [key_name(G)], a holoparasite.")
		switch(theme)
			if("tech")
				to_chat(user, span_holoparasite("<font color=\"[G.namedatum.colour]\"><b>[G.real_name]</b></font> is now online!"))
			if("magic")
				to_chat(user, span_holoparasite("<font color=\"[G.namedatum.colour]\"><b>[G.real_name]</b></font> has been summoned!"))
			if("carp")
				to_chat(user, span_holoparasite("<font color=\"[G.namedatum.colour]\"><b>[G.real_name]</b></font> has been caught!"))
		add_verb(user, list(/mob/living/proc/guardian_comm, /mob/living/proc/guardian_recall, /mob/living/proc/guardian_reset))
		//surprise another check in case you tried to get around the first one and now you have no holoparasite :)
		for(var/obj/H in all_items)
			if(istype(H, /obj/item/clothing/neck/necklace/memento_mori))
				to_chat(user, span_danger("The power of the [H] overtakes the [src]!"))
				used = TRUE
				G.Destroy()
				return FALSE
		return TRUE
	else
		to_chat(user, "[failure_message]")
		used = FALSE
		return FALSE

// the item
/obj/item/guardiancreator
	name = "deck of tarot cards"
	desc = "An enchanted deck of tarot cards, rumored to be a source of unimaginable power."
	icon = 'icons/obj/toy.dmi'
	icon_state = "deck_syndicate_full"
	var/datum/guardianbuilder/builder
	var/use_message = span_holoparasite("You shuffle the deck...")
	var/used_message = span_holoparasite("All the cards seem to be blank now.")
	var/failure_message = "<span class='holoparasite bold'>..And draw a card! It's...blank? Maybe you should try again later.</span>"
	var/ling_failure = "<span class='holoparasite bold'>The deck refuses to respond to a souless creature such as you.</span>"
	var/random = FALSE
	var/allowmultiple = FALSE
	var/allowling = TRUE
	var/allowguardian = FALSE
	var/mob_name = "Guardian Spirit"
	var/theme = "magic"
	var/max_points = 15
	var/allowspecial = FALSE
	var/debug_mode = FALSE

/obj/item/guardiancreator/Initialize()
	. = ..()
	builder = new(mob_name, theme, failure_message, max_points, allowspecial, debug_mode)

/obj/item/guardiancreator/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_REFUND, .proc/refund_check)
	
/obj/item/guardiancreator/proc/refund_check()
	return !builder.used

/obj/item/guardiancreator/attack_self(mob/living/user)
	if(isguardian(user) && !allowguardian)
		to_chat(user, span_holoparasite("[mob_name] chains are not allowed."))
		return
	var/list/guardians = user.hasparasites()
	if(LAZYLEN(guardians) && !allowmultiple)
		to_chat(user, span_holoparasite("You already have a [mob_name]!"))
		return
	if(user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling) && !allowling)
		to_chat(user, "[ling_failure]")
		return
	if(builder.used)
		to_chat(user, "[used_message]")
		return
	if(!random)
		builder.ui_interact(user)
	else
		builder.saved_stats = generate_stand()
		builder.spawn_guardian(user)

/obj/item/guardiancreator/proc/generate_stand()
	var/points = 15
	var/list/categories = list("Damage", "Defense", "Speed", "Potential", "Range") // will be shuffled every iteration
	var/list/majors = subtypesof(/datum/guardian_ability/major) - typesof(/datum/guardian_ability/major/special)
	var/list/major_weighted = list()
	for(var/M in majors)
		var/datum/guardian_ability/major/major = new M
		major_weighted[major] = major.arrow_weight
	var/datum/guardian_ability/major/major_ability = pickweight(major_weighted)
	var/datum/guardian_stats/stats = new
	stats.ability = major_ability
	stats.ability.master_stats = stats
	points -= major_ability.cost
	while(points > 0)
		if(!categories.len)
			break
		shuffle_inplace(categories)
		var/cat = pick(categories)
		points--
		switch(cat)
			if("Damage")
				stats.damage++
				if(stats.damage >= 5)
					categories -= "Damage"
			if("Defense")
				stats.defense++
				if(stats.defense >= 5)
					categories -= "Defense"
			if("Speed")
				stats.speed++
				if(stats.speed >= 5)
					categories -= "Speed"
			if("Potential")
				stats.potential++
				if(stats.potential >= 5)
					categories -= "Potential"
			if("Range")
				stats.range++
				if(stats.range >= 5)
					categories -= "Range"
	return stats

/////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/guardiancreator/debug
	desc = "If you're seeing this and you're not debugging, something is probably very wrong."
	debug_mode = TRUE
	allowspecial = TRUE

/////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/guardiancreator/rare
	allowspecial = TRUE

/obj/item/guardiancreator/tech
	name = "holoparasite injector"
	desc = "It contains an alien nanoswarm of unknown origin. Though capable of near sorcerous feats via use of hardlight holograms and nanomachines, it requires an organic host as a home base and source of fuel."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "combat_hypo"
	theme = "tech"
	mob_name = "Holoparasite"
	use_message = span_holoparasite("You start to power on the injector...")
	used_message = span_holoparasite("The injector has already been used.")
	failure_message = "<span class='holoparasite bold'>...ERROR. BOOT SEQUENCE ABORTED. AI FAILED TO INTIALIZE. PLEASE CONTACT SUPPORT OR TRY AGAIN LATER.</span>"
	ling_failure = "<span class='holoparasite bold'>The holoparasites recoil in horror. They want nothing to do with a creature like you.</span>"

/obj/item/guardiancreator/tech/rare
	allowspecial = TRUE

/obj/item/guardiancreator/carp
	name = "holocarp fishsticks"
	desc = "Using the power of Carp'sie, you can catch a carp from byond the veil of Carpthulu, and bind it to your fleshy flesh form."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "fishfingers"
	theme = "carp"
	mob_name = "Holocarp"
	use_message = span_holoparasite("You put the fishsticks in your mouth...")
	used_message = span_holoparasite("Someone's already taken a bite out of these fishsticks! Ew.")
	failure_message = "<span class='holoparasite bold'>You couldn't catch any carp spirits from the seas of Lake Carp. Maybe there are none, maybe you fucked up.</span>"
	ling_failure = "<span class='holoparasite bold'>Carp'sie is fine with changelings, so you shouldn't be seeing this message.</span>"
	allowmultiple = TRUE
	allowling = TRUE

/obj/item/guardiancreator/carp/rare
	allowspecial = TRUE

/obj/item/guardiancreator/wizard
	allowmultiple = TRUE

/obj/item/guardiancreator/wizard/rare
	allowspecial = TRUE

/obj/item/guardiancreator/random
	random = TRUE

/obj/item/guardiancreator/carp/random
	random = TRUE

/obj/item/guardiancreator/wizard/random
	random = TRUE

/obj/item/guardiancreator/tech/random
	random = TRUE
