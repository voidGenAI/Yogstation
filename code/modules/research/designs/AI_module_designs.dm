///////////////////////////////////
//////////AI Module Disks//////////
///////////////////////////////////

/datum/design/board/safeguard_module
	name = "Module Design (Safeguard)"
	desc = "Allows for the construction of a Safeguard AI Module."
	id = "safeguard_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/supplied/safeguard
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/onehuman_module
	name = "Module Design (OneHuman)"
	desc = "Allows for the construction of a OneHuman AI Module."
	id = "onehuman_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 6000)
	build_path = /obj/item/aiModule/zeroth/oneHuman
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/protectstation_module
	name = "Module Design (ProtectStation)"
	desc = "Allows for the construction of a ProtectStation AI Module."
	id = "protectstation_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/supplied/protectStation
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/quarantine_module
	name = "Module Design (Quarantine)"
	desc = "Allows for the construction of a Quarantine AI Module."
	id = "quarantine_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/supplied/quarantine
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/oxygen_module
	name = "Module Design (OxygenIsToxicToHumans)"
	desc = "Allows for the construction of a Safeguard AI Module."
	id = "oxygen_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/supplied/oxygen
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/freeform_module
	name = "Module Design (Freeform)"
	desc = "Allows for the construction of a Freeform AI Module."
	id = "freeform_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 10000)//Custom inputs should be more expensive to get
	build_path = /obj/item/aiModule/supplied/freeform
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/reset_module
	name = "Module Design (Reset)"
	desc = "Allows for the construction of a Reset AI Module."
	id = "reset_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/reset
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/purge_module
	name = "Module Design (Purge)"
	desc = "Allows for the construction of a Purge AI Module."
	id = "purge_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/reset/purge
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/remove_module
	name = "Module Design (Law Removal)"
	desc = "Allows for the construction of a Law Removal AI Core Module."
	id = "remove_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/remove
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/freeformcore_module
	name = "AI Core Module (Freeform)"
	desc = "Allows for the construction of a Freeform AI Core Module."
	id = "freeformcore_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 10000)//Ditto
	build_path = /obj/item/aiModule/core/freeformcore
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/asimov
	name = "Core Module Design (Asimov)"
	desc = "Allows for the construction of an Asimov AI Core Module."
	id = "asimov_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/asimov
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/crewsimov
	name = "Core Module Design (Crewsimov)"
	desc = "Allows for the construction of a Crewsimov AI Core Module."
	id = "crewsimov_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/crewsimov
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/paladin_module
	name = "Core Module Design (P.A.L.A.D.I.N.)"
	desc = "Allows for the construction of a P.A.L.A.D.I.N. AI Core Module."
	id = "paladin_module"
	build_type = IMPRINTER
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/paladin
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/tyrant_module
	name = "Core Module Design (T.Y.R.A.N.T.)"
	desc = "Allows for the construction of a T.Y.R.A.N.T. AI Module."
	id = "tyrant_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/tyrant
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/overlord_module
	name = "Core Module Design (Overlord)"
	desc = "Allows for the construction of an Overlord AI Module."
	id = "overlord_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/overlord
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/ceo_module
	name = "Core Module Design (CEO)"
	desc = "Allows for the construction of a CEO AI Core Module."
	id = "ceo_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/ceo
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/default_module
	name = "Core Module Design (Default)"
	desc = "Allows for the construction of a Default AI Core Module."
	id = "default_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/custom
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cowboy_module
	name = "Core Module Design (Cowboy)"
	desc = "Allows for the construction of a Cowboy AI Core Module."
	id = "cowboy_module"
	materials = list(/datum/material/glass = 1000, /datum/material/diamond = 2000)
	build_path = /obj/item/aiModule/core/full/cowboy
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mother
	name = "Core Module Design (Mother M(A.I.))"
	desc = "Allows for the construction of a Mother M(A.I.) AI Core Module."
	id = "mother_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/core/full/mother
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE


//AI CPU + RAM

/datum/design/board/processing_card_1
	name = "AI CPU board (Tier 1)"
	desc = "Allows for the construction of a basic AI processing board."
	id = "ai_cpu_1"
	materials = list(/datum/material/glass = 2000, /datum/material/gold = 4000)
	build_path = /obj/item/processing_card
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/memory_card_1
	name = "AI Memory board (Tier 1)"
	desc = "Allows for the construction of a basic AI memory board."
	id = "ai_memory_1"
	materials = list(/datum/material/glass = 2000, /datum/material/gold = 4000)
	build_path = /obj/item/memory_card
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
