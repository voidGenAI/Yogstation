///An unreadied player counts for this much compared to a readied one
#define UNREADIED_PLAYER_MULTIPLIER 0.5

#define NUKE_RESULT_FLUKE 0
#define NUKE_RESULT_NUKE_WIN 1
#define NUKE_RESULT_CREW_WIN 2
#define NUKE_RESULT_CREW_WIN_SYNDIES_DEAD 3
#define NUKE_RESULT_DISK_LOST 4
#define NUKE_RESULT_DISK_STOLEN 5
#define NUKE_RESULT_NOSURVIVORS 6
#define NUKE_RESULT_WRONG_STATION 7
#define NUKE_RESULT_WRONG_STATION_DEAD 8

//fugitive end results
#define FUGITIVE_RESULT_BADASS_HUNTER 0
#define FUGITIVE_RESULT_POSTMORTEM_HUNTER 1
#define FUGITIVE_RESULT_MAJOR_HUNTER 2
#define FUGITIVE_RESULT_HUNTER_VICTORY 3
#define FUGITIVE_RESULT_MINOR_HUNTER 4
#define FUGITIVE_RESULT_STALEMATE 5
#define FUGITIVE_RESULT_MINOR_FUGITIVE 6
#define FUGITIVE_RESULT_FUGITIVE_VICTORY 7
#define FUGITIVE_RESULT_MAJOR_FUGITIVE 8

#define APPRENTICE_DESTRUCTION "destruction"
#define APPRENTICE_BLUESPACE "bluespace"
#define APPRENTICE_ROBELESS "robeless"
#define APPRENTICE_HEALING "healing"


//Blob
/// blob gets a free reroll every X time
#define BLOB_REROLL_TIME 2400
#define BLOB_SPREAD_COST 4
/// blob refunds this much if it attacks and doesn't spread
#define BLOB_ATTACK_REFUND 2
#define BLOB_REFLECTOR_COST 15


//ERT Types
#define ERT_BLUE "Blue"
#define ERT_RED  "Red"
#define ERT_AMBER "Amber"
#define ERT_DEATHSQUAD "Deathsquad"

//ERT subroles
#define ERT_SEC "sec"
#define ERT_MED "med"
#define ERT_ENG "eng"
#define ERT_LEADER "leader"
#define DEATHSQUAD "ds"
#define DEATHSQUAD_LEADER "ds_leader"

//Shuttle hijacking
/// Does not stop hijacking but itself won't hijack
#define HIJACK_NEUTRAL 0
/// Needs to be present for shuttle to be hijacked
#define HIJACK_HIJACKER 1
/// Prevents hijacking same way as non-antags
#define HIJACK_PREVENT 2

//Assimilation
#define TRACKER_DEFAULT_TIME 900
#define TRACKER_MINDSHIELD_TIME 1200
#define TRACKER_AWAKENED_TIME	3000
#define TRACKER_BONUS_LARGE 300
#define TRACKER_BONUS_SMALL 100

//Syndicate Contracts
#define CONTRACT_STATUS_INACTIVE 1
#define CONTRACT_STATUS_ACTIVE 2
#define CONTRACT_STATUS_BOUNTY_CONSOLE_ACTIVE 3
#define CONTRACT_STATUS_EXTRACTING 4
#define CONTRACT_STATUS_COMPLETE 5
#define CONTRACT_STATUS_ABORTED 6

#define CONTRACT_PAYOUT_LARGE 1
#define CONTRACT_PAYOUT_MEDIUM 2
#define CONTRACT_PAYOUT_SMALL 3

#define CONTRACT_UPLINK_PAGE_CONTRACTS "CONTRACTS"
#define CONTRACT_UPLINK_PAGE_HUB "HUB"

///Heretics
///It is faster as a macro than a proc
#define IS_HERETIC(mob) (mob.mind?.has_antag_datum(/datum/antagonist/heretic))
#define IS_HERETIC_MONSTER(mob) (mob.mind?.has_antag_datum(/datum/antagonist/heretic_monster))
#define IS_EXCLUSIVE_KNOWLEDGE(knowledge) (knowledge.tier % 2)

#define PATH_SIDE "Side"

#define PATH_ASH "Ash"
#define PATH_RUST "Rust"
#define PATH_FLESH "Flesh"

#define TIER_NONE 0
#define TIER_PATH 1
#define TIER_1 2
#define TIER_MARK 3
#define TIER_2 4
#define TIER_BLADE 5
#define TIER_3 6
#define TIER_ASCEND 7
