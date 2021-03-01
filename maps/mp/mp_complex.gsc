#include maps\mp\_utility;
#include common_scripts\utility;
main(){maps\mp\mp_complex_precache::main();maps\mp\_destructible_dlc::main();maps\mp\_load::main();maps\mp\_compass::setupMiniMap("compass_map_mp_complex");level.airstrikeHeightScale=2;game["attackers"]="allies";game["defenders"]="axis";setdvar("compassmaxrange","1500");}