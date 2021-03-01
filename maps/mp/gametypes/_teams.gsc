#include maps\mp\_utility;
FACTION_REF_COL=0;FACTION_NAME_COL=1;FACTION_SHORT_NAME_COL=2;FACTION_ELIMINATED_COL=3;FACTION_FORFEITED_COL=4;FACTION_ICON_COL=5;FACTION_HUD_ICON_COL=6;FACTION_VOICE_PREFIX_COL=7;FACTION_SPAWN_MUSIC_COL=8;FACTION_WIN_MUSIC_COL=9;FACTION_FLAG_MODEL_COL=10;FACTION_FLAG_CARRY_MODEL_COL=11;FACTION_FLAG_ICON_COL=12;FACTION_FLAG_FX_COL=13;FACTION_COLOR_R_COL=14;FACTION_COLOR_G_COL=15;FACTION_COLOR_B_COL=16;FACTION_HEAD_ICON_COL=17;FACTION_CRATE_MODEL_COL=18;init(){initScoreBoard();level.teamBalance=getDvarInt("scr_teambalance");level.maxClients=getDvarInt("sv_maxclients");setPlayerModels();level.freeplayers=[];if(level.teamBased){level thread onPlayerConnect();level thread updateTeamBalance();}else{level thread onFreePlayerConnect();}}initScoreBoard(){setDvar("g_TeamIcon_Allies",getTeamIcon("allies"));setDvar("g_TeamIcon_MyAllies",getTeamIcon("allies"));setDvar("g_TeamIcon_EnemyAllies",getTeamIcon("allies"));scoreColor=getTeamColor("allies");setDvar("g_TeamIcon_Axis",getTeamIcon("axis"));setDvar("g_TeamIcon_MyAxis",getTeamIcon("axis"));setDvar("g_TeamIcon_EnemyAxis",getTeamIcon("axis"));scoreColor=getTeamColor("axis");if(game["attackers"]=="allies"&&game["defenders"]=="axis"){setDvar("g_ScoresColor_Allies","0.8 0 0 1");setDvar("g_ScoresColor_Axis","0 0.5 1 1");setDvar("g_TeamColor_Allies","0.8 0 0 1");setDvar("g_TeamColor_Axis","0 0.5 1 1");setDvar("g_TeamName_Allies","Attack");setDvar("g_TeamName_Axis","Defence");}else{setDvar("g_ScoresColor_Allies","0 0.5 1 1");setDvar("g_ScoresColor_Axis","0.8 0 0 1");setDvar("g_TeamColor_Allies","0 0.5 1 1");setDvar("g_TeamColor_Axis","0.8 0 0 1");setDvar("g_TeamName_Allies","Defence");setDvar("g_TeamName_Axis","Attack");}setdvar("g_ScoresColor_Spectator",".25 .25 .25");setdvar("g_ScoresColor_Free",".76 .78 .10");setdvar("g_teamColor_MyTeam",".6 .8 .6");setdvar("g_teamColor_EnemyTeam","1 .45 .5");setdvar("g_teamTitleColor_MyTeam",".6 .8 .6");setdvar("g_teamTitleColor_EnemyTeam","1 .45 .5");}onPlayerConnect(){for(;;){level waittill("connected",player);player thread onJoinedTeam();player thread onJoinedSpectators();player thread trackPlayedTime();}}onFreePlayerConnect(){for(;;){level waittill("connected",player);player thread trackFreePlayedTime();}}onJoinedTeam(){self endon("disconnect");for(;;){self waittill("joined_team");self updateTeamTime();}}onJoinedSpectators(){self endon("disconnect");for(;;){self waittill("joined_spectators");self.pers["teamTime"]=undefined;}}trackPlayedTime(){self endon("disconnect");self.timePlayed["allies"]=0;self.timePlayed["axis"]=0;self.timePlayed["free"]=0;self.timePlayed["other"]=0;self.timePlayed["total"]=0;gameFlagWait("prematch_done");for(;;){if(game["state"]=="playing"){if(self.sessionteam=="allies"){self.timePlayed["allies"]++;self.timePlayed["total"]++;}else if(self.sessionteam=="axis"){self.timePlayed["axis"]++;self.timePlayed["total"]++;}else if(self.sessionteam=="spectator"){self.timePlayed["other"]++;}}wait(1.0);}}updateTeamTime(){if(game["state"]!="playing")return;self.pers["teamTime"]=getTime();}updateTeamBalanceDvar(){for(;;){teambalance=getdvarInt("scr_teambalance");if(level.teambalance!=teambalance)level.teambalance=getdvarInt("scr_teambalance");wait 7;}}updateTeamBalance(){level.teamLimit=level.maxclients/2;level thread updateTeamBalanceDvar();wait.15;if(level.teamBalance&&isRoundBased()){if(isDefined(game["BalanceTeamsNextRound"]))iPrintLnbold(&"MP_AUTOBALANCE_NEXT_ROUND");level waittill("restarting");if(isDefined(game["BalanceTeamsNextRound"])){level balanceTeams();game["BalanceTeamsNextRound"]=undefined;}else if(!getTeamBalance()){game["BalanceTeamsNextRound"]=true;}}else{level endon("game_ended");for(;;){if(level.teamBalance){if(!getTeamBalance()){iPrintLnBold(&"MP_AUTOBALANCE_SECONDS",15);wait 15.0;if(!getTeamBalance())level balanceTeams();}wait 59.0;}wait 1.0;}}}getTeamBalance(){level.team["allies"]=0;level.team["axis"]=0;players=level.players;for(i=0;i<players.size;i++){if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="allies"))level.team["allies"]++;else if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="axis"))level.team["axis"]++;}if((level.team["allies"]>(level.team["axis"]+level.teamBalance))||(level.team["axis"]>(level.team["allies"]+level.teamBalance)))return false;else return true;}balanceTeams(){iPrintLnBold(game["strings"]["autobalance"]);AlliedPlayers=[];AxisPlayers=[];players=level.players;for(i=0;i<players.size;i++){if(!isdefined(players[i].pers["teamTime"]))continue;if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="allies"))AlliedPlayers[AlliedPlayers.size]=players[i];else if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="axis"))AxisPlayers[AxisPlayers.size]=players[i];}MostRecent=undefined;while((AlliedPlayers.size>(AxisPlayers.size+1))||(AxisPlayers.size>(AlliedPlayers.size+1))){if(AlliedPlayers.size>(AxisPlayers.size+1)){for(j=0;j<AlliedPlayers.size;j++){if(isdefined(AlliedPlayers[j].dont_auto_balance))continue;if(!isdefined(MostRecent))MostRecent=AlliedPlayers[j];else if(AlliedPlayers[j].pers["teamTime"]>MostRecent.pers["teamTime"])MostRecent=AlliedPlayers[j];}MostRecent[[level.axis]]();}else if(AxisPlayers.size>(AlliedPlayers.size+1)){for(j=0;j<AxisPlayers.size;j++){if(isdefined(AxisPlayers[j].dont_auto_balance))continue;if(!isdefined(MostRecent))MostRecent=AxisPlayers[j];else if(AxisPlayers[j].pers["teamTime"]>MostRecent.pers["teamTime"])MostRecent=AxisPlayers[j];}MostRecent[[level.allies]]();}MostRecent=undefined;AlliedPlayers=[];AxisPlayers=[];players=level.players;for(i=0;i<players.size;i++){if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="allies"))AlliedPlayers[AlliedPlayers.size]=players[i];else if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="axis"))AxisPlayers[AxisPlayers.size]=players[i];}}}setTeamModels(team,charSet){switch(charSet){case"seals_udt":mptype\mptype_seal_udt_sniper::precache();mptype\mptype_seal_udt_assault::precache();mptype\mptype_seal_udt_shotgun::precache();mptype\mptype_seal_udt_smg::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_seal_udt_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_seal_udt_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_seal_udt_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_seal_udt_smg::main;break;case"us_army":mptype\mptype_us_army_sniper::precache();mptype\mptype_us_army_assault::precache();mptype\mptype_us_army_shotgun::precache();mptype\mptype_us_army_smg::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_us_army_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_us_army_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_us_army_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_us_army_smg::main;break;case"opforce_composite":mptype\mptype_opforce_comp_assault::precache();mptype\mptype_opforce_comp_shotgun::precache();mptype\mptype_opforce_comp_smg::precache();mptype\mptype_opforce_comp_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_opforce_comp_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_opforce_comp_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_opforce_comp_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_opforce_comp_smg::main;break;case"opforce_arctic":mptype\mptype_opforce_arctic_assault::precache();mptype\mptype_opforce_arctic_shotgun::precache();mptype\mptype_opforce_arctic_smg::precache();mptype\mptype_opforce_arctic_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_opforce_arctic_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_opforce_arctic_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_opforce_arctic_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_opforce_arctic_smg::main;break;case"opforce_airborne":mptype\mptype_opforce_airborne_assault::precache();mptype\mptype_opforce_airborne_shotgun::precache();mptype\mptype_opforce_airborne_smg::precache();mptype\mptype_opforce_airborne_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_opforce_airborne_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_opforce_airborne_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_opforce_airborne_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_opforce_airborne_smg::main;break;case"militia":mptype\mptype_opforce_militia_assault::precache();mptype\mptype_opforce_militia_shotgun::precache();mptype\mptype_opforce_militia_smg::precache();mptype\mptype_opforce_militia_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_opforce_militia_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_opforce_militia_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_opforce_militia_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_opforce_militia_smg::main;break;case"socom_141":mptype\mptype_socom_assault::precache();mptype\mptype_socom_shotgun::precache();mptype\mptype_socom_smg::precache();mptype\mptype_socom_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_socom_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_socom_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_socom_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_socom_smg::main;break;case"socom_141_desert":mptype\mptype_tf141_desert_assault::precache();mptype\mptype_tf141_desert_smg::precache();mptype\mptype_tf141_desert_shotgun::precache();mptype\mptype_tf141_desert_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_tf141_desert_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_tf141_desert_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_tf141_desert_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_tf141_desert_smg::main;break;case"socom_141_forest":mptype\mptype_tf141_forest_assault::precache();mptype\mptype_tf141_forest_smg::precache();mptype\mptype_tf141_forest_shotgun::precache();mptype\mptype_tf141_forest_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_tf141_forest_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_tf141_forest_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_tf141_forest_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_tf141_forest_smg::main;break;case"socom_141_arctic":mptype\mptype_tf141_arctic_assault::precache();mptype\mptype_tf141_arctic_smg::precache();mptype\mptype_tf141_arctic_shotgun::precache();mptype\mptype_tf141_arctic_sniper::precache();game[team+"_model"]["SNIPER"]=mptype\mptype_tf141_arctic_sniper::main;game[team+"_model"]["ASSAULT"]=mptype\mptype_tf141_arctic_assault::main;game[team+"_model"]["SHOTGUN"]=mptype\mptype_tf141_arctic_shotgun::main;game[team+"_model"]["SMG"]=mptype\mptype_tf141_arctic_smg::main;break;}}setPlayerModels(){setTeamModels("allies",game["allies"]);setTeamModels("axis",game["axis"]);}playerModelForWeapon(weapon){team=self.team;self detachAll();if(isDefined(game[team+"_model"][weapon])){[[game[team+"_model"][weapon]]]();return;}weaponClass=tablelookup("mp/statstable.csv",4,weapon,2);switch(weaponClass){case"weapon_smg":[[game[team+"_model"]["SMG"]]]();break;case"weapon_assault":[[game[team+"_model"]["ASSAULT"]]]();break;case"weapon_shotgun":[[game[team+"_model"]["SHOTGUN"]]]();break;case"weapon_sniper":[[game[team+"_model"]["SNIPER"]]]();break;default:[[game[team+"_model"]["ASSAULT"]]]();break;}}CountPlayers(){players=level.players;allies=0;axis=0;for(i=0;i<players.size;i++){if(players[i]==self)continue;if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="allies"))allies++;else if((isdefined(players[i].pers["team"]))&&(players[i].pers["team"]=="axis"))axis++;}players["allies"]=allies;players["axis"]=axis;return players;}trackFreePlayedTime(){self endon("disconnect");self.timePlayed["allies"]=0;self.timePlayed["axis"]=0;self.timePlayed["other"]=0;self.timePlayed["total"]=0;for(;;){if(game["state"]=="playing"){if(isDefined(self.pers["team"])&&self.pers["team"]=="allies"&&self.sessionteam!="spectator"){self.timePlayed["allies"]++;self.timePlayed["total"]++;}else if(isDefined(self.pers["team"])&&self.pers["team"]=="axis"&&self.sessionteam!="spectator"){self.timePlayed["axis"]++;self.timePlayed["total"]++;}else{self.timePlayed["other"]++;}}wait(1.0);}}getJoinTeamPermissions(team){if(game["CUSTOM_MODE"]&&getDvarInt("promod_adv_balance")){playerCounts=self CountPlayers();return((playerCounts["allies"]==playerCounts["axis"])||(playerCounts[team]<playerCounts["axis"])||(playerCounts[team]<playerCounts["allies"]));}else{teamcount=0;players=level.players;for(i=0;i<players.size;i++){player=players[i];if((isdefined(player.pers["team"]))&&(player.pers["team"]==team))teamcount++;}if(teamCount<level.teamLimit)return true;else return false;}}getTeamName(teamRef){return(tableLookupIString("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_NAME_COL));}getTeamShortName(teamRef){return(tableLookupIString("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_SHORT_NAME_COL));}getTeamForfeitedString(teamRef){return(tableLookupIString("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_FORFEITED_COL));}getTeamEliminatedString(teamRef){return(tableLookupIString("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_ELIMINATED_COL));}getTeamIcon(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_ICON_COL));}getTeamHudIcon(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_HUD_ICON_COL));}getTeamHeadIcon(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_HEAD_ICON_COL));}getTeamVoicePrefix(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_VOICE_PREFIX_COL));}getTeamSpawnMusic(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_SPAWN_MUSIC_COL));}getTeamWinMusic(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_WIN_MUSIC_COL));}getTeamFlagModel(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_FLAG_MODEL_COL));}getTeamFlagCarryModel(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_FLAG_CARRY_MODEL_COL));}getTeamFlagIcon(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_FLAG_ICON_COL));}getTeamFlagFX(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_FLAG_FX_COL));}getTeamColor(teamRef){return((stringToFloat(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_COLOR_R_COL)),stringToFloat(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_COLOR_G_COL)),stringToFloat(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_COLOR_B_COL))));}getTeamCrateModel(teamRef){return(tableLookup("mp/factionTable.csv",FACTION_REF_COL,game[teamRef],FACTION_CRATE_MODEL_COL));}