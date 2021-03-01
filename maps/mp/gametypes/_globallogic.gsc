#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
init(){level.splitscreen=false;level.ps3=false;level.xenon=false;level.console=false;level.onlineGame=getDvarInt("onlinegame");level.rankedMatch=true;level.script=toLower(getDvar("mapname"));level.gametype=toLower(getDvar("g_gametype"));level.otherTeam["allies"]="axis";level.otherTeam["axis"]="allies";level.teamBased=false;level.objectiveBased=false;level.endGameOnTimeLimit=true;level.showingFinalKillcam=false;if(!isDefined(level.tweakablesInitialized))maps\mp\gametypes\_tweakables::init();precacheString(&"MP_HALFTIME");precacheString(&"MP_OVERTIME");precacheString(&"MP_ROUNDEND");precacheString(&"MP_INTERMISSION");precacheString(&"MP_SWITCHING_SIDES");precacheString(&"MP_FRIENDLY_FIRE_WILL_NOT");precacheString(&"PLATFORM_REVIVE");precacheString(&"MP_OBITUARY_NEUTRAL");precacheString(&"MP_OBITUARY_FRIENDLY");precacheString(&"MP_OBITUARY_ENEMY");precacheString(&"MP_HOST_ENDED_GAME");level.halftimeType="halftime";level.halftimeSubCaption=&"MP_SWITCHING_SIDES";level.lastStatusTime=0;level.wasWinning="none";level.lastSlowProcessFrame=0;level.placement["allies"]=[];level.placement["axis"]=[];level.placement["all"]=[];level.postRoundTime=5.0;level.playersLookingForSafeSpawn=[];registerDvars();precacheModel("vehicle_mig29_desert");precacheModel("projectile_cbu97_clusterbomb");precacheModel("tag_origin");setDvar("promod_version","");if(!isDefined(game["PROMOD_VERSION"]))game["PROMOD_VERSION"]="^7";if(!isDefined(game["gamestarted"]))promod\modes::main();level.teamCount["allies"]=0;level.teamCount["axis"]=0;level.teamCount["spectator"]=0;level.aliveCount["allies"]=0;level.aliveCount["axis"]=0;level.aliveCount["spectator"]=0;level.livesCount["allies"]=0;level.livesCount["axis"]=0;level.oneLeftTime=[];level.hasSpawned["allies"]=0;level.hasSpawned["axis"]=0;}registerDvars(){makeDvarServerInfo("ui_bomb_timer",0);makeDvarServerInfo("ui_danger_team","");makeDvarServerInfo("camera_thirdPerson",getDvarInt("scr_thirdPerson"));}SetupCallbacks(){level.onXPEvent=::onXPEvent;level.getSpawnPoint=::blank;level.onSpawnPlayer=::blank;level.onRespawnDelay=::blank;level.onTimeLimit=maps\mp\gametypes\_gamelogic::default_onTimeLimit;level.onHalfTime=maps\mp\gametypes\_gamelogic::default_onHalfTime;level.onDeadEvent=maps\mp\gametypes\_gamelogic::default_onDeadEvent;level.onOneLeftEvent=maps\mp\gametypes\_gamelogic::default_onOneLeftEvent;level.onPrecacheGametype=::blank;level.onStartGameType=::blank;level.onPlayerKilled=::blank;level.autoassign=maps\mp\gametypes\_menus::menuAutoAssign;level.spectator=maps\mp\gametypes\_menus::menuSpectator;level.class=maps\mp\gametypes\_menus::menuClass;level.allies=maps\mp\gametypes\_menus::menuAllies;level.axis=maps\mp\gametypes\_menus::menuAxis;level.killspec=::menuKillspec;}menuKillspec(){if(self.pers["team"]!="axis"&&self.pers["team"]!="allies")return;self closepopupMenu();self closemenus();self closeInGameMenu();if(self.sessionstate=="playing")self suicide();self.pers["class"]=undefined;self.class=undefined;self iprintln("Choose a class to respawn");self setClientDvar("loadout_curclass","");self thread maps\mp\gametypes\_playerlogic::spawnSpectator();thread maps\mp\gametypes\_promod::updateClassAvailability(self.pers["team"]);self notify("killspec");for(i=0;i<level.players.size;i++){if(level.players[i].pers["team"]=="spectator")level.players[i]thread promod\shoutcast::resetShoutcast();}}blank(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10){}onXPEvent(event){self thread maps\mp\gametypes\_rank::giveRankXP(event);}