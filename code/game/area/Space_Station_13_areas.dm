/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = 'ICON FILENAME' 			(defaults to 'icons/turf/areas.dmi')
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = FALSE 				(defaults to true)
	ambientsounds = list()				(defaults to GENERIC from sound.dm. override it as "ambientsounds = list('sound/ambience/signal.ogg')" or using another define.

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/*-----------------------------------------------------------------------------*/

/area/ai_monitored	//stub defined ai_monitored.dm

/area/space
	icon_state = "space"
	requires_power = TRUE
	always_unpowered = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	valid_territory = FALSE
	outdoors = TRUE
	ambientsounds = SPACE
	blob_allowed = FALSE //Eating up space doesn't count for victory as a blob.

/area/space/nearstation
	icon_state = "space_near"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT

/area/start
	name = "start area"
	icon_state = "start"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	has_gravity = STANDARD_GRAVITY


/area/testroom
	requires_power = FALSE
	name = "Test Room"
	icon_state = "storage"

//EXTRA

/area/asteroid
	name = "Asteroid"
	icon_state = "asteroid"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	blob_allowed = FALSE //Nope, no winning on the asteroid as a blob. Gotta eat the station.
	valid_territory = FALSE
	ambientsounds = MINING

/area/asteroid/nearstation
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = RUINS
	always_unpowered = FALSE
	requires_power = TRUE
	blob_allowed = TRUE

/area/asteroid/nearstation/bomb_site
	name = "Bomb Testing Asteroid"

//STATION13

//Maintenance

/area/maintenance
	ambientsounds = MAINTENANCE
	valid_territory = FALSE
	minimap_color = "#4f4e3a"

	airlock_wires = /datum/wires/airlock/maint


//Departments

/area/maintenance/department/chapel
	name = "Chapel Maintenance"
	icon_state = "maint_chapel"

/area/maintenance/department/chapel/monastery
	name = "Monastery Maintenance"
	icon_state = "maint_monastery"

/area/maintenance/department/crew_quarters/bar
	name = "Bar Maintenance"
	icon_state = "maint_bar"

/area/maintenance/department/crew_quarters/dorms
	name = "Dormitory Maintenance"
	icon_state = "maint_dorms"

/area/maintenance/department/eva
	name = "EVA Maintenance"
	icon_state = "maint_eva"

/area/maintenance/department/electrical
	name = "Electrical Maintenance"
	icon_state = "maint_electrical"

/area/maintenance/department/tcoms
	name = "Telecommunications Maintenance"
	icon_state = "tcomsatmaint"

/area/maintenance/department/engine/atmos
	name = "Atmospherics Maintenance"
	icon_state = "maint_atmos"

/area/maintenance/department/security
	name = "Security Maintenance"
	icon_state = "maint_sec"

/area/maintenance/department/security/brig
	name = "Brig Maintenance"
	icon_state = "maint_brig"

/area/maintenance/department/medical
	name = "Medbay Maintenance"
	icon_state = "medbay_maint"

/area/maintenance/department/medical/central
	name = "Central Medbay Maintenance"
	icon_state = "medbay_maint_central"

/area/maintenance/department/medical/morgue
	name = "Morgue Maintenance"
	icon_state = "morgue_maint"

/area/maintenance/department/science
	name = "Science Maintenance"
	icon_state = "maint_sci"

/area/maintenance/department/science/central
	name = "Central Science Maintenance"
	icon_state = "maint_sci_central"

/area/maintenance/department/cargo
	name = "Cargo Maintenance"
	icon_state = "maint_cargo"

/area/maintenance/department/bridge
	name = "Bridge Maintenance"
	icon_state = "maint_bridge"

/area/maintenance/department/engine
	name = "Engineering Maintenance"
	icon_state = "maint_engi"

/area/maintenance/department/science/xenobiology
	name = "Xenobiology Maintenance"
	icon_state = "xenomaint"
	xenobiology_compatible = TRUE


//Maintenance - Generic

/area/maintenance/aft
	name = "Aft Maintenance"
	icon_state = "amaint"

/area/maintenance/aft/secondary
	name = "Aft Maintenance"
	icon_state = "amaint_2"

/area/maintenance/central
	name = "Central Maintenance"
	icon_state = "maintcentral"

/area/maintenance/central/secondary
	name = "Central Maintenance"
	icon_state = "maintcentral"
	clockwork_warp_allowed = FALSE

/area/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "fmaint"

/area/maintenance/fore/secondary
	name = "Fore Maintenance"
	icon_state = "fmaint_2"

/area/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "smaint"

/area/maintenance/starboard/central
	name = "Central Starboard Maintenance"
	icon_state = "smaint"

/area/maintenance/starboard/secondary
	name = "Secondary Starboard Maintenance"
	icon_state = "smaint_2"

/area/maintenance/starboard/aft
	name = "Starboard Quarter Maintenance"
	icon_state = "asmaint"

/area/maintenance/starboard/aft/secondary
	name = "Secondary Starboard Quarter Maintenance"
	icon_state = "asmaint_2"

/area/maintenance/starboard/fore
	name = "Starboard Bow Maintenance"
	icon_state = "fsmaint"

/area/maintenance/port
	name = "Port Maintenance"
	icon_state = "pmaint"

/area/maintenance/port/central
	name = "Central Port Maintenance"
	icon_state = "maintcentral"

/area/maintenance/port/aft
	name = "Port Quarter Maintenance"
	icon_state = "apmaint"

/area/maintenance/port/fore
	name = "Port Bow Maintenance"
	icon_state = "fpmaint"

/area/maintenance/disposal
	name = "Waste Disposal"
	icon_state = "disposal"

/area/maintenance/disposal/incinerator
	name = "Incinerator"
	icon_state = "disposal"


//Hallway

/area/hallway
	minimap_color = "#8d8c68"

/area/hallway/primary/aft
	name = "Aft Primary Hallway"
	icon_state = "hallA"

/area/hallway/primary/fore
	name = "Fore Primary Hallway"
	icon_state = "hallF"

/area/hallway/primary/starboard
	name = "Starboard Primary Hallway"
	icon_state = "hallS"

/area/hallway/primary/port
	name = "Port Primary Hallway"
	icon_state = "hallP"

/area/hallway/primary/central
	name = "Central Primary Hallway"
	icon_state = "hallC"

/area/hallway/secondary/command
	name = "Command Hallway"
	icon_state = "bridge_hallway"

/area/hallway/secondary/construction
	name = "Construction Area"
	icon_state = "construction"

/area/hallway/secondary/exit
	name = "Escape Shuttle Hallway"
	icon_state = "escape"

/area/hallway/secondary/exit/departure_lounge
	name = "Departure Lounge"
	icon_state = "escape_lounge"

/area/hallway/secondary/entry
	name = "Arrival Shuttle Hallway"
	icon_state = "entry"

/area/hallway/secondary/service
	name = "Service Hallway"
	icon_state = "hall_service"

//Command

/area/bridge
	name = "Bridge"
	icon_state = "bridge"
	ambientsounds = list('sound/ambience/signal.ogg')
	minimap_color = "#0400a2"
	airlock_wires = /datum/wires/airlock/command

/area/bridge/meeting_room
	name = "Heads of Staff Meeting Room"
	icon_state = "meeting"

/area/bridge/meeting_room/council
	name = "Council Chamber"
	icon_state = "meeting"

/area/bridge/showroom/corporate
	name = "Corporate Showroom"
	icon_state = "showroom"

/area/crew_quarters/heads
	airlock_wires = /datum/wires/airlock/command
	clockwork_warp_allowed = FALSE

/area/crew_quarters/heads/captain
	name = "Captain's Office"
	icon_state = "captain"
	minimap_color = "#2900d8"

/area/crew_quarters/heads/captain/private
	name = "Captain's Quarters"
	icon_state = "captain"

/area/crew_quarters/heads/chief
	name = "Chief Engineer's Office"
	icon_state = "ce_office"
	minimap_color = "#a5a000"

/area/crew_quarters/heads/cmo
	name = "Chief Medical Officer's Office"
	icon_state = "cmo_office"
	minimap_color = "#00fff0"

/area/crew_quarters/heads/hop
	name = "Head of Personnel's Office"
	icon_state = "hop_office"
	minimap_color = "#070094"

/area/crew_quarters/heads/hos
	name = "Head of Security's Office"
	icon_state = "hos_office"
	minimap_color = "#ff6868"

/area/crew_quarters/heads/hor
	name = "Research Director's Office"
	icon_state = "rd_office"
	minimap_color = "#9257a6"

/area/comms
	name = "Communications Relay"
	icon_state = "tcomsatcham"

/area/server
	name = "Messaging Server Room"
	icon_state = "server"

//Crew

/area/crew_quarters
	minimap_color = "#b0e1ff"

/area/crew_quarters/dorms
	name = "Dormitories"
	icon_state = "Sleep"
	safe = TRUE
	minimap_color = "#b0e1ff"

/area/crew_quarters/cryopods
	name = "Cryopod Room"
	safe = TRUE
	icon_state = "cryopod"

//Minsky Specific Areas

/area/crew_quarters/dorms/a
	name = "Dormitories"
	icon_state = "Sleep"
	safe = TRUE
	minimap_color = "#b0e1ff"

/area/crew_quarters/dorms/b
	name = "Dormitories"
	icon_state = "Sleep"
	safe = TRUE
	minimap_color = "#b0e1ff"

//End Minsky Specific Areas

/area/crew_quarters/toilet
	name = "Dormitory Toilets"
	icon_state = "toilet"
	minimap_color = "#b0e1ff"

/area/crew_quarters/toilet/auxiliary
	name = "Auxiliary Restrooms"
	icon_state = "toilet"

/area/crew_quarters/toilet/locker
	name = "Locker Toilets"
	icon_state = "toilet"
	minimap_color = "#766e97"

/area/crew_quarters/toilet/restrooms
	name = "Restrooms"
	icon_state = "toilet"

/area/crew_quarters/locker
	name = "Locker Room"
	icon_state = "locker"
	minimap_color = "#766e97"

/area/crew_quarters/lounge
	name = "Lounge"
	icon_state = "yellow"

/area/crew_quarters/fitness
	name = "Fitness Room"
	icon_state = "fitness"

/area/crew_quarters/fitness/locker_room
	name = "Unisex Locker Room"
	icon_state = "fitness"

/area/crew_quarters/fitness/recreation
	name = "Recreation Area"
	icon_state = "fitness"

/area/crew_quarters/cafeteria
	name = "Cafeteria"
	icon_state = "cafeteria"
	minimap_color = "#5ac866"

/area/crew_quarters/kitchen
	name = "Kitchen"
	icon_state = "kitchen"
	minimap_color = "#5ac866"
	airlock_wires = /datum/wires/airlock/service

/area/crew_quarters/kitchen/coldroom
	name = "Kitchen Cold Room"
	icon_state = "kitchen_cold"

/area/crew_quarters/bar
	name = "Bar"
	icon_state = "bar"
	minimap_color = "#5ac866"
	mood_bonus = 5
	mood_message = span_nicegreen("I love being in the bar!\n")
	airlock_wires = /datum/wires/airlock/service

/area/crew_quarters/bar/Initialize(mapload)
	. = ..()
	GLOB.bar_areas += src

/area/crew_quarters/bar/atrium
	name = "Atrium"
	icon_state = "bar"

/area/crew_quarters/electronic_marketing_den
	name = "Electronic Marketing Den"
	icon_state = "bar"

/area/crew_quarters/abandoned_gambling_den
	name = "Abandoned Gambling Den"
	icon_state = "abandoned_g_den"

/area/crew_quarters/abandoned_gambling_den/secondary
	icon_state = "abandoned_g_den_2"

/area/crew_quarters/theatre
	name = "Theatre"
	icon_state = "Theatre"
	minimap_color = "#5ac866"

/area/crew_quarters/theatre/abandoned
	name = "Abandoned Theatre"
	icon_state = "Theatre"

/area/library
	name = "Library"
	icon_state = "library"
	flags_1 = NONE
	minimap_color = "#5ac866"

/area/library/lounge
	name = "Library Lounge"
	icon_state = "library"

/area/library/abandoned
	name = "Abandoned Library"
	icon_state = "library"
	flags_1 = NONE

/area/chapel
	icon_state = "chapel"
	ambientsounds = HOLY
	flags_1 = NONE
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "The consecration here prevents you from warping in."
	minimap_color = "#5ac866"

/area/chapel/main
	name = "Chapel"

/area/chapel/main/monastery
	name = "Monastery"

/area/chapel/office
	name = "Chapel Office"
	icon_state = "chapeloffice"

/area/chapel/asteroid
	name = "Chapel Asteroid"
	icon_state = "explored"

/area/chapel/asteroid/monastery
	name = "Monastery Asteroid"

/area/chapel/dock
	name = "Chapel Dock"
	icon_state = "construction"

/area/lawoffice
	name = "Law Office"
	icon_state = "law"
	minimap_color = "#b12527"


//Engineering

/area/engine
	ambientsounds = ENGINEERING
	minimap_color = "#edea00"
	airlock_wires = /datum/wires/airlock/engineering

/area/engine/engine_smes
	name = "Engineering SMES"
	icon_state = "engine_smes"

/area/engine/engineering
	name = "Engineering"
	icon_state = "engine"

/area/engine/atmos
	name = "Atmospherics"
	icon_state = "atmos"
	flags_1 = NONE
	minimap_color = "#85ff02"

/area/engine/atmos_distro //yogstation specific
	name = "Atmospherics Distribution"
	icon_state = "atmos"
	flags_1 = NONE
	minimap_color = "#85ff02"

/area/engine/atmospherics_engine
	name = "Atmospherics Engine"
	icon_state = "atmos_engine"
	minimap_color = "#85ff02"

/area/engine/engine_room //donut station specific
	name = "Engine Room"
	icon_state = "atmos_engine"

/area/engine/engine_room/external
	name = "Supermatter External Access"
	icon_state = "engine_foyer"

/area/engine/supermatter
	name = "Supermatter Engine"
	icon_state = "engine_sm"

/area/engine/foyer
	name = "Engineering Foyer"
	icon_state = "engine_foyer"

/area/engine/break_room
	name = "Engineering Break Room"
	icon_state = "engine_foyer"

/area/engine/gravity_generator
	name = "Gravity Generator Room"
	icon_state = "grav_gen"
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "The gravitons generated here could throw off your warp's destination and possibly throw you into deep space."

/area/engine/storage
	name = "Engineering Storage"
	icon_state = "engi_storage"

/area/engine/storage_shared
	name = "Shared Engineering Storage"
	icon_state = "engi_storage"

/area/engine/transit_tube
	name = "Transit Tube"
	icon_state = "transit_tube"


//Solars

/area/solar
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	valid_territory = FALSE
	blob_allowed = FALSE
	flags_1 = NONE
	ambientsounds = ENGINEERING
	minimap_color = "#6b6b6b"
	airlock_wires = /datum/wires/airlock/engineering

/area/solar/fore
	name = "Fore Solar Array"
	icon_state = "yellow"

/area/solar/aft
	name = "Aft Solar Array"
	icon_state = "yellow"

/area/solar/aux/port
	name = "Port Bow Auxiliary Solar Array"
	icon_state = "panelsA"

/area/solar/aux/starboard
	name = "Starboard Bow Auxiliary Solar Array"
	icon_state = "panelsA"

/area/solar/starboard
	name = "Starboard Solar Array"
	icon_state = "panelsS"

/area/solar/starboard/aft
	name = "Starboard Quarter Solar Array"
	icon_state = "panelsAS"

/area/solar/starboard/fore
	name = "Starboard Bow Solar Array"
	icon_state = "panelsFS"

/area/solar/port
	name = "Port Solar Array"
	icon_state = "panelsP"

/area/solar/port/aft
	name = "Port Quarter Solar Array"
	icon_state = "panelsAP"

/area/solar/port/fore
	name = "Port Bow Solar Array"
	icon_state = "panelsFP"


//Solar Maint

/area/maintenance/solars
	name = "Solar Maintenance"
	icon_state = "yellow"

/area/maintenance/solars/port
	name = "Port Solar Maintenance"
	icon_state = "SolarcontrolP"

/area/maintenance/solars/port/aft
	name = "Port Quarter Solar Maintenance"
	icon_state = "SolarcontrolAP"

/area/maintenance/solars/port/fore
	name = "Port Bow Solar Maintenance"
	icon_state = "SolarcontrolFP"

/area/maintenance/solars/starboard
	name = "Starboard Solar Maintenance"
	icon_state = "SolarcontrolS"

/area/maintenance/solars/starboard/aft
	name = "Starboard Quarter Solar Maintenance"
	icon_state = "SolarcontrolAS"

/area/maintenance/solars/starboard/fore
	name = "Starboard Bow Solar Maintenance"
	icon_state = "SolarcontrolFS"

//Teleporter

/area/teleporter
	name = "Teleporter Room"
	icon_state = "teleporter"
	ambientsounds = ENGINEERING
	minimap_color = "#6b6b6b"
	airlock_wires = /datum/wires/airlock/command

//Minsky Specific Teleporters

/area/teleporter/hub
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "For safety reasons, warping here is disallowed; The quantum flux generated here could throw off your warp's destination and possibly throw you into deep space."
	ambientsounds = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg', 'sound/ambience/ambitech.ogg',\
											'sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg', 'sound/ambience/ambimystery.ogg')

/area/teleporter/hub/bridge
	name = "Bridge Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"

/area/teleporter/hub/engineering
	name = "Engineering Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"

/area/teleporter/hub/medical
	name = "Medical Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"

/area/teleporter/hub/science
	name = "R&D Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"

/area/teleporter/hub/security
	name = "Security Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"

/area/teleporter/hub/evac
	name = "Evac Quantum Hub"
	icon_state = "teleporter"
	minimap_color = "#6b6b6b"


//End Minsky specific teleporters

/area/gateway
	name = "Gateway"
	icon_state = "gateway"
	ambientsounds = ENGINEERING
	minimap_color = "#5d57a5"
	airlock_wires = /datum/wires/airlock/command

//MedBay

/area/medical
	name = "Medical"
	icon_state = "medbay3"
	ambientsounds = MEDICAL
	minimap_color = "#5d57a5"
	airlock_wires = /datum/wires/airlock/medbay

/area/medical/abandoned
	name = "Abandoned Medbay"
	icon_state = "medbay3"
	ambientsounds = list('sound/ambience/signal.ogg')

/area/medical/medbay/central
	name = "Medbay Central"
	icon_state = "medbay"

/area/medical/medbay/lobby
	name = "Medbay Lobby"
	icon_state = "medbay"

	//Medbay is a large area, these additional areas help level out APC load.

/area/medical/medbay/zone2
	name = "Medbay"
	icon_state = "medbay2"

/area/medical/medbay/aft
	name = "Medbay Aft"
	icon_state = "medbay3"

/area/medical/storage
	name = "Medbay Storage"
	icon_state = "medbay2"

/area/medical/storage/locker
	name = "Medbay Locker Room"
	icon_state = "medbay2"

/area/medical/storage/backroom
	name = "Medbay Backroom"
	icon_state = "medbay2"

/area/medical/patients_rooms
	name = "Patients' Rooms"
	icon_state = "patients"

/area/medical/patients_rooms/room_a
	name = "Patient Room A"
	icon_state = "patients"

/area/medical/patients_rooms/room_b
	name = "Patient Room B"
	icon_state = "patients"

/area/medical/patients_rooms/room_c
	name = "Patient Room C"
	icon_state = "patients"

/area/medical/virology
	name = "Virology"
	icon_state = "virology"
	flags_1 = NONE
	minimap_color = "#01f5b3"

/area/medical/morgue
	name = "Morgue"
	icon_state = "morgue"
	ambientsounds = SPOOKY

/area/medical/chemistry
	name = "Chemistry"
	icon_state = "chem"

/area/medical/surgery
	name = "Surgery"
	icon_state = "surgery"

/area/medical/cryo
	name = "Cryogenics"
	icon_state = "cryo"

/area/medical/exam_room
	name = "Exam Room"
	icon_state = "exam_room"

/area/medical/genetics
	name = "Genetics Lab"
	icon_state = "genetics"
	minimap_color = "#006384"

/area/medical/genetics/cloning
	name = "Cloning Lab"
	icon_state = "cloning"

/area/medical/sleeper
	name = "Medbay Treatment Center"
	icon_state = "exam_room"


//Security

/area/security
	name = "Security"
	icon_state = "security"
	ambientsounds = HIGHSEC
	minimap_color = "#b12527"
	airlock_wires = /datum/wires/airlock/security

/area/security/main
	name = "Security Office"
	icon_state = "security"

/area/security/brig
	name = "Brig"
	icon_state = "brig"

/area/security/courtroom
	name = "Courtroom"
	icon_state = "courtroom"

/area/security/prison
	name = "Prison Wing"
	icon_state = "sec_prison"
	minimap_color = "#530505"

/area/security/processing
	name = "Labor Shuttle Dock"
	icon_state = "sec_prison"

/area/security/processing/cremation
	name = "Security Crematorium"
	icon_state = "sec_prison"

/area/security/warden
	name = "Brig Control"
	icon_state = "Warden"

/area/security/detectives_office
	name = "Detective's Office"
	icon_state = "detective"
	ambientsounds = list('sound/ambience/ambidet1.ogg','sound/ambience/ambidet2.ogg')

/area/security/detectives_office/private_investigators_office
	name = "Private Investigator's Office"
	icon_state = "detective"

/area/security/range
	name = "Firing Range"
	icon_state = "firingrange"

/area/security/execution
	icon_state = "execution_room"
	minimap_color = "#530505"

/area/security/execution/transfer
	name = "Transfer Centre"

/area/security/execution/education
	name = "Prisoner Education Chamber"

/area/security/nuke_storage
	name = "Vault"
	icon_state = "nuke_storage"
	minimap_color = "#a2a2a2"
	airlock_wires = /datum/wires/airlock/command

/area/ai_monitored/nuke_storage
	name = "Vault"
	icon_state = "nuke_storage"
	minimap_color = "#a2a2a2"
	airlock_wires = /datum/wires/airlock/command

/area/security/checkpoint
	name = "Security Checkpoint"
	icon_state = "checkpoint1"

/area/security/checkpoint/auxiliary
	icon_state = "checkpoint_aux"

/area/security/checkpoint/escape
	name = "Security Post - Escape"
	icon_state = "checkpoint_esc"

/area/security/checkpoint/supply
	name = "Security Post - Cargo Bay"
	icon_state = "checkpoint_supp"

/area/security/checkpoint/engineering
	name = "Security Post - Engineering"
	icon_state = "checkpoint_engi"

/area/security/checkpoint/medical
	name = "Security Post - Medbay"
	icon_state = "checkpoint_med"

/area/security/checkpoint/science
	name = "Security Post - Science"
	icon_state = "checkpoint_sci"

/area/security/checkpoint/science/research
	name = "Security Post - Research Division"
	icon_state = "checkpoint_res"

/area/security/checkpoint/service
	name = "Security Post - Service"
	icon_state = "checkpoint_srv"

/area/security/checkpoint/customs
	name = "Customs"
	icon_state = "customs_point"

/area/security/checkpoint/customs/auxiliary
	icon_state = "customs_point_aux"


//Service

/area/quartermaster
	name = "Quartermasters"
	icon_state = "quart"
	minimap_color = "#936f3c"
	airlock_wires = /datum/wires/airlock/service

/area/quartermaster/sorting
	name = "Delivery Office"
	icon_state = "cargo_delivery"

/area/quartermaster/warehouse
	name = "Warehouse"
	icon_state = "cargo_warehouse"

/area/quartermaster/office
	name = "Cargo Office"
	icon_state = "quartoffice"
	minimap_color = "#936f3c"

/area/quartermaster/storage
	name = "Cargo Bay"
	icon_state = "cargo_bay"

/area/quartermaster/qm
	name = "Quartermaster's Office"
	icon_state = "quart"

/area/quartermaster/miningdock
	name = "Mining Dock"
	icon_state = "mining"

/area/quartermaster/miningoffice
	name = "Mining Office"
	icon_state = "mining"

/area/janitor
	name = "Custodial Closet"
	icon_state = "janitor"
	flags_1 = NONE
	minimap_color = "#cc00ff"
	airlock_wires = /datum/wires/airlock/service

/area/janitor/a //yogs start added two new areas
	name = "Custodial Closet A"
	icon_state = "janitor"
	flags_1 = NONE

/area/janitor/b
	name = "Custodial Closet B"
	icon_state = "janitor"
	flags_1 = NONE //yogs end added two new areas

/area/hydroponics
	name = "Hydroponics"
	icon_state = "hydro"
	minimap_color = "#5ac866"
	airlock_wires = /datum/wires/airlock/service

/area/hydroponics/upper
	name = "Upper Hydroponics"
	icon_state = "hydro"

/area/hydroponics/garden
	name = "Garden"
	icon_state = "garden"
	minimap_color = "#70ff38"

/area/hydroponics/garden/abandoned
	name = "Abandoned Garden"
	icon_state = "abandoned_garden"

/area/hydroponics/garden/monastery
	name = "Monastery Garden"
	icon_state = "hydro"


//Science

/area/science
	name = "Science Division"
	icon_state = "toxlab"
	minimap_color = "#75009b"
	airlock_wires = /datum/wires/airlock/science

/area/science/lab
	name = "Research and Development"
	icon_state = "toxlab"

/area/science/xenobiology
	name = "Xenobiology Lab"
	icon_state = "toxlab"

/area/science/storage
	name = "Toxins Storage"
	icon_state = "toxstorage"

/area/science/test_area
	valid_territory = FALSE
	name = "Toxins Test Area"
	icon_state = "toxtest"

/area/science/mixing
	name = "Toxins Mixing Lab"
	icon_state = "toxmix"

/area/science/mixing/chamber
	name = "Toxins Mixing Chamber"
	icon_state = "toxmix"
	valid_territory = FALSE

/area/science/misc_lab
	name = "Testing Lab"
	icon_state = "toxmisc"

/area/science/misc_lab/range
	name = "Research Testing Range"
	icon_state = "toxmisc"

/area/science/server
	name = "Research Division Server Room"
	icon_state = "server"

/area/science/explab
	name = "Experimentation Lab"
	icon_state = "toxmisc"

/area/science/robotics
	name = "Robotics"
	icon_state = "medresearch"

/area/science/robotics/mechbay
	name = "Mech Bay"
	icon_state = "mechbay"

/area/science/robotics/lab
	name = "Robotics Lab"
	icon_state = "ass_line"

/area/science/research
	name = "Research Division"
	icon_state = "research_development" //yogs

/area/science/research/abandoned
	name = "Abandoned Research Lab"
	icon_state = "medresearch"

/area/science/nanite
	name = "Nanite Lab"
	icon_state = "toxmisc"

//Storage

/area/storage
	minimap_color = "#f8ff83"

/area/storage/tools
	name = "Auxiliary Tool Storage"
	icon_state = "storage"

/area/storage/primary
	name = "Primary Tool Storage"
	icon_state = "primarystorage"

/area/storage/art
	name = "Artist's Coven"
	icon_state = "storage"

/area/storage/tcom
	name = "Telecomms Storage"
	icon_state = "green"
	valid_territory = FALSE

/area/storage/eva
	name = "EVA Storage"
	icon_state = "eva"
	clockwork_warp_allowed = FALSE
	minimap_color = "#c8c0ff"

/area/storage/emergency/starboard
	name = "Starboard Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/emergency/port
	name = "Port Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/tech
	name = "Technical Storage"
	icon_state = "auxstorage"
	minimap_color = "#9ccf00"

//Construction

/area/construction
	name = "Construction Area"
	icon_state = "yellow"
	ambientsounds = ENGINEERING
	minimap_color = "#4f4e3a"

/area/construction/mining/aux_base
	name = "Auxiliary Base Construction"
	icon_state = "aux_base_construction"

/area/construction/storage_wing
	name = "Storage Wing"
	icon_state = "storage_wing"

// Vacant Rooms
/area/vacant_room
	name = "Vacant Room"
	icon_state = "yellow"
	ambientsounds = MAINTENANCE
	icon_state = "vacant_room"
	minimap_color = "#4f4e3a"

/area/vacant_room/office
	name = "Vacant Office"
	icon_state = "vacant_office"

/area/vacant_room/commissary
	name = "Vacant Commissary"
	icon_state = "vacant_commissary"

//AI

/area/ai_monitored/security/armory
	name = "Armory"
	icon_state = "armory"
	ambientsounds = HIGHSEC
	minimap_color = "#b12527"
	airlock_wires = /datum/wires/airlock/security

/area/ai_monitored/security/armory/upper
	name = "Upper Armory"

/area/ai_monitored/storage/eva
	name = "EVA Storage"
	icon_state = "eva"
	ambientsounds = HIGHSEC
	minimap_color = "#c8c0ff"

/area/ai_monitored/storage/satellite
	name = "AI Satellite Maint"
	icon_state = "storage"
	ambientsounds = HIGHSEC
	minimap_color = "#4f4e3a"
	airlock_wires = /datum/wires/airlock/ai
/area/ai_monitored/secondarydatacore
	name= "AI Secondary Datacore"
	icon_state =  "ai"
	minimap_color = "#00fff6"
	//Turret_protected

/area/ai_monitored/turret_protected
	ambientsounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg')
	minimap_color = "#00fff6"
	airlock_wires = /datum/wires/airlock/ai

/area/ai_monitored/turret_protected/ai_upload
	name = "AI Upload Chamber"
	icon_state = "ai_upload"
	minimap_color = "#4f4e3a"

/area/ai_monitored/turret_protected/ai_upload_foyer
	name = "AI Upload Access"
	icon_state = "ai_foyer"

/area/ai_monitored/turret_protected/ai
	name = "AI Chamber"
	icon_state = "ai_chamber"

/area/ai_monitored/turret_protected/aisat
	name = "AI Satellite"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/atmos
	name = "AI Satellite Atmos"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/foyer
	name = "AI Satellite Foyer"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/service
	name = "AI Satellite Service"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/hallway
	name = "AI Satellite Hallway"
	icon_state = "ai"

/area/aisat
	name = "AI Satellite Exterior"
	icon_state = "yellow"
	minimap_color = "#00fff6"
	airlock_wires = /datum/wires/airlock/ai

/area/ai_monitored/turret_protected/aisat_interior
	name = "AI Satellite Antechamber"
	icon_state = "ai"

/area/ai_monitored/turret_protected/AIsatextAS
	name = "AI Sat Ext"
	icon_state = "storage"

/area/ai_monitored/turret_protected/AIsatextAP
	name = "AI Sat Ext"
	icon_state = "storage"


// Telecommunications Satellite

/area/tcommsat
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "For safety reasons, warping here is disallowed; the radio and bluespace noise could cause catastrophic results."
	ambientsounds = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg', 'sound/ambience/ambitech.ogg',\
											'sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg', 'sound/ambience/ambimystery.ogg')
	minimap_color = "#00fff6"
	airlock_wires = /datum/wires/airlock/engineering

/area/tcommsat/computer
	name = "Telecomms Control Room"
	icon_state = "tcomsatcomp"

/area/tcommsat/server
	name = "Telecomms Server Room"
	icon_state = "tcomsatcham"
