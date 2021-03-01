#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
init(){level thread onPlayerConnect();}onPlayerConnect(){for(;;){level waittill("connected",player);player thread onPlayerSpawned();}}onPlayerSpawned(){self endon("disconnect");for(;;){self waittill("spawned_player");wait 0.05;self notify("weapon_change",self getCurrentWeapon());while(!gameFlag("prematch_done")||(isDefined(level.strat_over)&&!level.strat_over))wait.1;wait.1;self notify("weapon_change",self getCurrentWeapon());}}