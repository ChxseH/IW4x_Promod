main(){maps\mp\mp_favela_precache::main();maps\mp\_load::main();maps\mp\_compass::setupMiniMap("compass_map_mp_favela");level.airstrikeHeightScale=1.5;switch(level.gameType){case"oneflag":game["attackers"]="allies";game["defenders"]="axis";break;default:game["attackers"]="axis";game["defenders"]="allies";break;}setdvar("r_specularcolorscale","2.8");setdvar("compassmaxrange","1500");setdvar("r_lightGridEnableTweaks",1);setdvar("r_lightGridIntensity",1.25);setdvar("r_lightGridContrast",.45);}