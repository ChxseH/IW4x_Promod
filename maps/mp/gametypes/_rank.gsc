#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.scoreInfo =[];
    level.rankTable =[];
    level.xpScale = 1;
    precacheShader("white");
    precacheString(&"MP_PLUS");
    registerScoreInfo("kill", 5);
    registerScoreInfo("headshot", 0);
    registerScoreInfo("assist", 3);
    registerScoreInfo("suicide", 0);
    registerScoreInfo("teamkill", -5);
    registerScoreInfo("win", 2);
    registerScoreInfo("loss", 1);
    registerScoreInfo("tie", 1.5);
    registerScoreInfo("capture", 300);
    registerScoreInfo("defend", 300);
    level thread onPlayerConnect();
}

isRegisteredEvent(type)
{
    if (isDefined(level.scoreInfo[type])) return true;
    else return false;
}

registerScoreInfo(type, value)
{
    level.scoreInfo[type]["value"] = value;
}

getScoreInfoValue(type)
{
    overrideDvar = "scr_" + level.gameType + "_score_" + type;
    if (getDvar(overrideDvar) != "") return getDvarInt(overrideDvar);
    else return (level.scoreInfo[type]["value"]);
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player.xpUpdateTotal = 0;
        player setRank(9, 13);
        player.hud_scorePopup = newClientHudElem(player);
        player.hud_scorePopup.horzAlign = "center";
        player.hud_scorePopup.vertAlign = "middle";
        player.hud_scorePopup.alignX = "center";
        player.hud_scorePopup.alignY = "middle";
        player.hud_scorePopup.x = 0;
        player.hud_scorePopup.y = -60;
        player.hud_scorePopup.font = "hudbig";
        player.hud_scorePopup.fontscale = 0.75;
        player.hud_scorePopup.archived = false;
        player.hud_scorePopup.color = (0.5, 0.5, 0.5);
        player.hud_scorePopup.sort = 10000;
        player.hud_scorePopup maps\mp\gametypes\_hud::fontPulseInit(3.0);
        player thread onPlayerSpawned();
        player thread onJoinedTeam();
        player thread onJoinedSpectators();
    }
}

onJoinedTeam()
{
    self endon("disconnect");
    for (;;)
    {
        self waittill("joined_team");
        self thread removeRankHUD();
    }
}

onJoinedSpectators()
{
    self endon("disconnect");
    for (;;)
    {
        self waittill("joined_spectators");
        self thread removeRankHUD();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    for (;;)
    {
	    self setClientDvar("com_maxfps", "250");
        self setClientDvar("cl_maxpackets", "100");
        self setClientDvar("dynent_active", "0");
        self setClientDvar("cg_nopredict", "0");
        self setClientDvar("developer", "0");
        self setClientDvar("r_zfeather", "0");
        self setClientDvar("phys_gravity", "-800");
        self setClientDvar("sm_enable", "0");
        self setClientDvar("r_fullbright", "0");
        self setClientDvar("cg_newcolors", "0");
		self setClientDvar( "cg_objectiveText", "^1Promod\n^2chse.xyz/donate" );
        self waittill("spawned_player");
    }
}

giveRankXP(type, value)
{
    self endon("disconnect");
    if (level.teamBased && (level.teamCount["allies"] + level.teamCount["axis"] < 1)) return;
    else if (!level.teamBased && (level.teamCount["allies"] + level.teamCount["axis"] < 2)) return;
    if (!isDefined(value)) value = getScoreInfoValue(type);
    if (type == "teamkill") self thread scorePopup(0 - getScoreInfoValue("kill"));
    else self thread scorePopup(value);
}

scorePopup(amount)
{
    self endon("disconnect");
    self endon("joined_team");
    self endon("joined_spectators");
    if (amount == 0) return;
    self notify("scorePopup");
    self endon("scorePopup");
    self.xpUpdateTotal += amount;
    wait(0.05);
    if (self.xpUpdateTotal < 0)
    {
        self.hud_scorePopup.label = &"";
        self.hud_scorePopup.color = (1, 0, 0);
    }
    else
    {
        self.hud_scorePopup.label = &"MP_PLUS";
        self.hud_scorePopup.color = (1, 1, 0.5);
    }

    self.hud_scorePopup.glowAlpha = 0;
    self.hud_scorePopup setValue(self.xpUpdateTotal);
    self.hud_scorePopup.alpha = 0.85;
    self.hud_scorePopup thread maps\mp\gametypes\_hud::fontPulse(self);
    wait(1.0);
    self.hud_scorePopup fadeOverTime(0.75);
    self.hud_scorePopup.alpha = 0;
    self.xpUpdateTotal = 0;
}

removeRankHUD()
{
    self.hud_scorePopup.alpha = 0;
}