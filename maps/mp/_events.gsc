#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
init(){level.numKills=0;level thread onPlayerConnect();}onPlayerConnect(){for(;;){level waittill("connected",player);player.killedPlayers=[];player.killedPlayersCurrent=[];player.killedBy=[];player.lastKilledBy=undefined;player.greatestUniquePlayerKills=0;player.recentKillCount=0;player.lastKillTime=0;player.damagedPlayers=[];player.adrenaline=0;player setAdrenaline(0);}}disconnected(){myGuid=self.guid;for(entry=0;entry<level.players.size;entry++){if(isDefined(level.players[entry].killedPlayers[myGuid]))level.players[entry].killedPlayers[myGuid]=undefined;if(isDefined(level.players[entry].killedPlayersCurrent[myGuid]))level.players[entry].killedPlayersCurrent[myGuid]=undefined;if(isDefined(level.players[entry].killedBy[myGuid]))level.players[entry].killedBy[myGuid]=undefined;}}