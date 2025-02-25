/datum/guardian_ability/major/assassin
	name = "Assassin"
	desc = "The guardian can sneak up on people and do a powerful attack."
	cost = 3
	has_mode = TRUE
	recall_mode = TRUE
	mode_on_msg = "<span class='danger'><B>You enter stealth, empowering your next attack.</span></B>"
	mode_off_msg = "<span class='danger'><B>You exit stealth.</span></B>"
	arrow_weight = 0.9
	var/next_stealth = 0
	var/stealthcooldown = 0
	var/obj/screen/alert/canstealthalert
	var/obj/screen/alert/instealthalert


/datum/guardian_ability/major/assassin/Apply()
	. = ..()
	guardian.do_temp_anchor = FALSE
	stealthcooldown = 75 / master_stats.potential

/datum/guardian_ability/major/assassin/Remove()
	. = ..()
	guardian.do_temp_anchor = initial(guardian.do_temp_anchor)

/datum/guardian_ability/major/assassin/Health(amount)
	if(amount > 0)
		mode = FALSE
		Mode(TRUE)

/datum/guardian_ability/major/assassin/Recall()
	mode = FALSE
	Mode(TRUE)

/datum/guardian_ability/major/assassin/AfterAttack(atom/target)
	if(mode && (isliving(target) || istype(target, /obj/structure/window) || istype(target, /obj/structure/grille)))
		mode = FALSE
		Mode()

/datum/guardian_ability/major/assassin/Mode(forced = FALSE)
	if(mode)
		if(next_stealth >= world.time)
			to_chat(guardian, span_bolddanger("You cannot yet enter stealth, wait another [DisplayTimeText(next_stealth - world.time)]!"))
			mode = FALSE
			Mode()
			return
		guardian.melee_damage_lower = 50
		guardian.melee_damage_upper = 50
		guardian.armour_penetration = 100
		guardian.obj_damage = 0
		guardian.environment_smash = ENVIRONMENT_SMASH_NONE
		new /obj/effect/temp_visual/guardian/phase/out(get_turf(guardian))
		guardian.alpha = 15
		updatestealthalert()
	else
		guardian.melee_damage_lower = initial(guardian.melee_damage_lower)
		guardian.melee_damage_upper = initial(guardian.melee_damage_upper)
		guardian.armour_penetration = initial(guardian.armour_penetration)
		guardian.obj_damage = initial(guardian.obj_damage)
		guardian.environment_smash = initial(guardian.environment_smash)
		guardian.alpha = initial(guardian.alpha)
		master_stats.Apply(guardian)
		if(!forced)
			guardian.visible_message(span_danger("[guardian] suddenly appears!"))
			next_stealth = world.time + stealthcooldown
			guardian.cooldown = world.time + 40
		updatestealthalert()

/datum/guardian_ability/major/assassin/proc/updatestealthalert()
	if(next_stealth <= world.time)
		if(mode)
			if(!instealthalert)
				instealthalert = guardian.throw_alert("instealth", /obj/screen/alert/instealth)
				guardian.clear_alert("canstealth")
				canstealthalert = null
		else
			if(!canstealthalert)
				canstealthalert = guardian.throw_alert("canstealth", /obj/screen/alert/canstealth)
				guardian.clear_alert("instealth")
				instealthalert = null
	else
		guardian.clear_alert("instealth")
		instealthalert = null
		guardian.clear_alert("canstealth")
		canstealthalert = null
