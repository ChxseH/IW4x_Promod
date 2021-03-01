#include maps\mp\_utility;

init()
{
    if (!isDefined(game["gamestarted"]))
    {
        game["menu_team"] = "team_marinesopfor";
        if (game["attackers"] == "axis" && game["defenders"] == "allies") game["menu_team"] += "_flipped";
        game["menu_class_allies"] = "class_marines";
        game["menu_changeclass_allies"] = "changeclass_marines_mw";
        game["menu_class_axis"] = "class_opfor";
        game["menu_changeclass_axis"] = "changeclass_opfor_mw";
        game["menu_initteam_axis"] = "initteam_opfor";
        game["menu_initteam_allies"] = "initteam_marines";
        game["menu_class"] = "class";
        game["menu_changeclass"] = "changeclass_mw";
        game["menu_controls"] = "ingame_controls";
        game["menu_muteplayer"] = "muteplayer";
        game["menu_quickcommands"] = "quickcommands";
        game["menu_quickstatements"] = "quickstatements";
        game["menu_quickresponses"] = "quickresponses";
        game["menu_quickmessage"] = "quickmessage";
        game["menu_quickpromod"] = "quickpromod";
        game["menu_quickpromodgfx"] = "quickpromodgfx";
        game["menu_demo"] = "demo";
        game["menu_shoutcast"] = "shoutcast";
        game["menu_shoutcast_map"] = "shoutcast_map";
        game["menu_shoutcast_setup"] = "shoutcast_setup";
        game["menu_clientcmd"] = "clientcmd";
        precacheMenu(game["menu_quickmessage"]);
        precacheMenu(game["menu_quickcommands"]);
        precacheMenu(game["menu_quickstatements"]);
        precacheMenu(game["menu_quickresponses"]);
        precacheMenu(game["menu_quickpromodgfx"]);
        precacheMenu(game["menu_quickpromod"]);
        precacheMenu(game["menu_muteplayer"]);
        precacheMenu(game["menu_controls"]);
        precacheMenu(game["menu_leavegame"]);
        precacheMenu("scoreboard");
        precacheMenu(game["menu_team"]);
        precacheMenu(game["menu_class_allies"]);
        precacheMenu(game["menu_changeclass_allies"]);
        precacheMenu(game["menu_initteam_allies"]);
        precacheMenu(game["menu_class_axis"]);
        precacheMenu(game["menu_changeclass_axis"]);
        precacheMenu(game["menu_class"]);
        precacheMenu(game["menu_changeclass"]);
        precacheMenu(game["menu_initteam_axis"]);
        precacheMenu(game["menu_clientcmd"]);
        precacheMenu("demo");
        precacheMenu("shoutcast");
        precacheMenu("shoutcast_map");
        precacheMenu("shoutcast_setup");
        precacheMenu("shoutcast_setup_binds");
        precacheString(&"MP_HOST_ENDED_GAME");
        precacheString(&"MP_HOST_ENDGAME_RESPONSE");
    }

    if (game["switchedsides"])
    {
        game["menu_team"] = "team_marinesopfor";
        if (game["attackers"] == "axis" && game["defenders"] == "allies") game["menu_team"] += "_flipped";
        precacheMenu(game["menu_team"]);
    }

    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread onMenuResponse();
        player thread maps\mp\gametypes\_quickmessages::classBinds();
    }
}

isOptionsMenu( menu )
{
	if ( menu == game["menu_changeclass"] )
		return true;
	if ( menu == game["menu_team"] )
		return true;
	if ( menu == game["menu_controls"] )
		return true;
	if ( isSubStr( menu, "pc_options" ) )
		return true;
	return false;
}

onMenuResponse()
{
    self endon("disconnect");
    for (;;)
    {
        self waittill("menuresponse", menu, response);
        if (getSubStr(response, 0, 7) == "loadout")
        {
            self maps\mp\gametypes\_promod::processLoadoutResponse(response);
            continue;
        }

        switch (response)
        {
            case "back":
                {
                    if (self.pers["team"] == "none") continue;self closepopupMenu();self closeInGameMenu();
                    if (menu == game["menu_changeclass"] && (self.pers["team"] == "axis" || self.pers["team"] == "allies"))
                    {
                        if (isDefined(self.pers["class"]))
                        {
                            self maps\mp\gametypes\_promod::setClassChoice(self.pers["class"]);
                            self maps\mp\gametypes\_promod::menuAcceptClass();
                        }

                        self openpopupMenu(game["menu_changeclass_" + self.pers["team"]]);
                    }

                    continue;
                }

            case "demo":
                {
                    if (menu == "demo") self.inrecmenu = false;
                    continue;
                }

            case "changeteam":
                {
                    self closepopupMenu();self closeInGameMenu();self openpopupMenu(game["menu_team"]);
                    continue;
                }

            case "shoutcast_setup":
                if (self.pers["team"] != "spectator") continue;
                self closepopupMenu();
                self closeInGameMenu();
                self openpopupMenu(game["menu_shoutcast_setup"]);
                continue;
            case "changeclass_marines":
                {
                    if (self.pers["team"] != "allies") continue;self closepopupMenu();self closeInGameMenu();self openpopupMenu(game["menu_changeclass_allies"]);
                    continue;
                }

            case "changeclass_opfor":
                {
                    if (self.pers["team"] != "axis") continue;self closepopupMenu();self closeInGameMenu();self openpopupMenu(game["menu_changeclass_axis"]);
                    continue;
                }

            case "endround":
                {
                    if (!self isHost())
                    {
                        continue;
                    }

                    if (!level.gameEnded)
                    {
                        level thread maps\mp\gametypes\_gamelogic::forceEnd();
                    }
                    else
                    {
                        self closepopupMenu();
                        self closeInGameMenu();
                        self iprintln(&"MP_HOST_ENDGAME_RESPONSE");
                    }

                    continue;
                }
        }

        switch (menu)
        {
            case "echo":
                k = strtok(response, "_");
                buf = "";
                for (i = 0; i < k.size; i++)
                {
                    buf += k[i];
                    if (i != k.size - 1) buf += " ";
                }

                self iprintln(buf);
                continue;
            case "team_marinesopfor":
            case "team_marinesopfor_flipped":
                {
                    switch (response)
                    {
                        case "allies":
                            self[[level.allies]]();
                            break;
                        case "axis":
                            self[[level.axis]]();
                            break;
                        case "autoassign":
                            self[[level.autoassign]]();
                            break;
                        case "spectator":
                            self[[level.spectator]]();
                            break;
                    }

                    continue;
                }

            case "changeclass_marines_mw":
            case "changeclass_opfor_mw":
                {
                    if (response == "killspec")
                    {
                        self[[level.killspec]]();
                        continue;
                    }

                    if (!self maps\mp\gametypes\_promod::verifyClassChoice(self.pers["team"], response)) continue;self maps\mp\gametypes\_promod::setClassChoice(response);self closepopupMenu();self closeInGameMenu();self openpopupMenu(game["menu_changeclass"]);
                    continue;
                }

            case "changeclass_mw":
                {
                    self closepopupMenu();self closeInGameMenu();self.selectedClass = true;self maps\mp\gametypes\_promod::menuAcceptClass();
                    continue;
                }

            case "shoutcast_setup":
                {
                    if (self.pers["team"] == "spectator")
                    {
                        if (int(response) > 10) self thread maps\mp\gametypes\_quickmessages::setFollowSpec((int(response) - 10));
                        else self thread maps\mp\gametypes\_quickmessages::setFollow(response);
                    }

                    continue;
                }

            case "quickcommands":
                maps\mp\gametypes\_quickmessages::quickcommands(response);
                continue;
            case "quickstatements":
                maps\mp\gametypes\_quickmessages::quickstatements(response);
                continue;
            case "quickresponses":
                maps\mp\gametypes\_quickmessages::quickresponses(response);
                continue;
            case "quickpromod":
                maps\mp\gametypes\_quickmessages::quickpromod(response);
                continue;
            case "quickpromodgfx":
                maps\mp\gametypes\_quickmessages::quickpromodgfx(response);
                continue;
        }
    }
}

getTeamAssignment()
{
    teams[0] = "allies";
    teams[1] = "axis";
    if (!level.teamBased) return teams[randomInt(2)];
    if (self.sessionteam != "none" && self.sessionteam != "spectator" && self.sessionstate != "playing" && self.sessionstate != "dead")
    {
        assignment = self.sessionteam;
    }
    else
    {
        playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
        if (playerCounts["allies"] == playerCounts["axis"])
        {
            if (getTeamScore("allies") == getTeamScore("axis")) assignment = teams[randomInt(2)];
            else if (getTeamScore("allies")<getTeamScore("axis")) assignment = "allies";
            else assignment = "axis";
        }
        else if (playerCounts["allies"]<playerCounts["axis"])
        {
            assignment = "allies";
        }
        else
        {
            assignment = "axis";
        }
    }

    return assignment;
}

menuAutoAssign()
{
    self closeMenus();
    assignment = getTeamAssignment();
    if (isDefined(self.pers["team"]) && (self.sessionstate == "playing" || self.sessionstate == "dead"))
    {
        if (assignment == self.pers["team"])
        {
            self beginClassChoice();
            self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
            return;
        }
        else
        {
            self.switching_teams = true;
            self.joining_team = assignment;
            self.leaving_team = self.pers["team"];
            self suicide();
        }
    }

    oldTeam = self.pers["team"];
    self addToTeam(assignment);
    self.pers["class"] = undefined;
    self.class = undefined;
    if (!isAlive(self)) self.statusicon = "hud_status_dead";
    self notify("end_respawn");
    if (self.pers["team"] == "allies")
    {
        if (game["attackers"] == "allies" && game["defenders"] == "axis") iPrintLN(self.name + " Joined Attack");
        else iPrintLN(self.name + " Joined Defence");
    }
    else if (self.pers["team"] == "axis")
    {
        if (game["attackers"] == "allies" && game["defenders"] == "axis") iPrintLN(self.name + " Joined Defence");
        else iPrintLN(self.name + " Joined Attack");
    }

    for (i = 0; i < level.players.size; i++)
    {
        if (level.players[i].pers["team"] == "spectator") level.players[i] thread promod\shoutcast::resetShoutcast();
    }

    if (oldTeam != self.pers["team"] && (oldTeam == "allies" || oldTeam == "axis")) thread maps\mp\gametypes\_promod::updateClassAvailability(oldTeam);
    self beginClassChoice();
}

beginClassChoice(forceNewChoice)
{
    if (self.pers["team"] != "axis" && self.pers["team"] != "allies") return;
    team = self.pers["team"];
    self openpopupMenu(game["menu_changeclass_" + team]);
    if (!isAlive(self)) self thread maps\mp\gametypes\_playerlogic::predictAboutToSpawnPlayerOverTime(0.1);
}

beginTeamChoice()
{
    self openpopupMenu(game["menu_team"]);
}

showMainMenuForTeam()
{
    assert(self.pers["team"] == "axis" || self.pers["team"] == "allies");
    team = self.pers["team"];
    self openpopupMenu(game["menu_class_" + team]);
}

menuAllies()
{
    if (self.pers["team"] == "allies") return;
    self closeMenus();
    if (!isDefined(self.switching)) self.switching = false;
    if (self.pers["team"] != "allies")
    {
        if (level.teamBased && !maps\mp\gametypes\_teams::getJoinTeamPermissions("allies"))
        {
            self openpopupMenu(game["menu_team"]);
            return;
        }

        if (level.inGracePeriod && !self.hasDoneCombat) self.hasSpawned = false;
        oldTeam = self.pers["team"];
        if (self.sessionstate == "playing")
        {
            self.switching_teams = true;
            self.joining_team = "allies";
            self.leaving_team = self.pers["team"];
            self suicide();
        }

        self addToTeam("allies");
        self.pers["class"] = undefined;
        self.class = undefined;
        self setClientDvar("loadout_curclass", "");
        self notify("end_respawn");
        self.freelook = undefined;
        if (game["attackers"] == "allies" && game["defenders"] == "axis") iprintln(self.name + " Joined Attack");
        else iprintln(self.name + " Joined Defence");
        for (i = 0; i < level.players.size; i++)
        {
            if (level.players[i].pers["team"] == "spectator") level.players[i] thread promod\shoutcast::resetShoutcast();
        }

        if (oldTeam == "axis") thread maps\mp\gametypes\_promod::updateClassAvailability(oldTeam);
        self setClientDvar("g_compassShowEnemies", 0);
    }

    self.switching = false;
    self beginClassChoice();
}

menuAxis()
{
    if (self.pers["team"] == "axis") return;
    self closeMenus();
    if (!isDefined(self.switching)) self.switching = false;
    if (self.pers["team"] != "axis")
    {
        if (level.teamBased && !maps\mp\gametypes\_teams::getJoinTeamPermissions("axis"))
        {
            self openpopupMenu(game["menu_team"]);
            return;
        }

        if (level.inGracePeriod && !self.hasDoneCombat) self.hasSpawned = false;
        oldTeam = self.pers["team"];
        if (self.sessionstate == "playing")
        {
            self.switching_teams = true;
            self.joining_team = "axis";
            self.leaving_team = self.pers["team"];
            self suicide();
        }

        self addToTeam("axis");
        self.pers["class"] = undefined;
        self.class = undefined;
        self setClientDvar("loadout_curclass", "");
        self notify("end_respawn");
        self.freelook = undefined;
        if (game["attackers"] == "allies" && game["defenders"] == "axis") iprintln(self.name + " Joined Defence");
        else iprintln(self.name + " Joined Attack");
        for (i = 0; i < level.players.size; i++)
        {
            if (level.players[i].pers["team"] == "spectator") level.players[i] thread promod\shoutcast::resetShoutcast();
        }

        if (oldTeam == "allies") thread maps\mp\gametypes\_promod::updateClassAvailability(oldTeam);
        self setClientDvar("g_compassShowEnemies", 0);
    }

    self.switching = false;
    self beginClassChoice();
}

menuSpectator()
{
    self closeMenus();
    self openpopupMenu(game["menu_shoutcast"]);
    if (isDefined(self.pers["team"]) && self.pers["team"] == "spectator") return;
    oldTeam = self.pers["team"];
    if (isAlive(self))
    {
        assert(isDefined(self.pers["team"]));
        self.switching_teams = true;
        self.joining_team = "spectator";
        self.leaving_team = self.pers["team"];
        self suicide();
    }

    self addToTeam("spectator");
    self.pers["class"] = undefined;
    self.class = undefined;
    self setClientDvar("loadout_curclass", "");
    self thread maps\mp\gametypes\_playerlogic::spawnSpectator();
    if (game["attackers"] == "allies" && game["defenders"] == "axis") self setClientDvars("shout_scores_attack", game["teamScores"]["allies"], "shout_scores_defence", game["teamScores"]["axis"], "shout_attack_name", "Attack", "shout_defence_name", "Defence");
    else self setClientDvars("shout_scores_attack", game["teamScores"]["axis"], "shout_scores_defence", game["teamScores"]["allies"], "shout_attack_name", "Defence", "shout_defence_name", "Attack");
    self setclientdvar("g_scriptMainMenu", game["menu_shoutcast"]);
    iprintln(self.name + " Joined Shoutcaster");
    for (i = 0; i < level.players.size; i++)
    {
        if (level.players[i].pers["team"] == "spectator") level.players[i] thread promod\shoutcast::resetShoutcast();
    }

    if (oldTeam == "allies" || oldTeam == "axis") thread maps\mp\gametypes\_promod::updateClassAvailability(oldTeam);
    self setClientDvar("g_compassShowEnemies", 1);
}

menuClass(blank1)
{
    if (!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis")) return;
    if (self.sessionstate == "playing")
    {
        self.pers["primary"] = undefined;
        self.pers["weapon"] = undefined;
        if (game["state"] == "postgame") return;
        if (level.inGracePeriod && !self.hasDoneCombat)
        {
            self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
        }
        else
        {
            self iPrintLnBold(game["strings"]["change_class"]);
            if (level.numLives == 1 && !level.inGracePeriod && self.curClass != self.pers["class"])
            {
                self setClientDvar("loadout_curclass", "");
                self.curClass = undefined;
            }
        }
    }
    else
    {
        self.pers["primary"] = undefined;
        self.pers["weapon"] = undefined;
        if (game["state"] == "postgame") return;
        if (game["state"] == "playing") self thread maps\mp\gametypes\_playerlogic::spawnClient();
    }

    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

addToTeam(team, firstConnect)
{
    if (isDefined(self.team)) self maps\mp\gametypes\_playerlogic::removeFromTeamCount();
    self.pers["team"] = team;
    self.team = team;
    if (!matchMakingGame() || isDefined(self.pers["isBot"]))
    {
        if (level.teamBased)
        {
            self.sessionteam = team;
        }
        else
        {
            if (team == "spectator") self.sessionteam = "spectator";
            else self.sessionteam = "none";
        }
    }

    if (game["state"] != "postgame") self maps\mp\gametypes\_playerlogic::addToTeamCount();
    self updateObjectiveText();
    if (isDefined(firstConnect) && firstConnect) waittillframeend;
    self updateMainMenu();
    if (team == "spectator")
    {
        self notify("joined_spectators");
        level notify("joined_team");
    }
    else
    {
        self notify("joined_team");
        level notify("joined_team");
}
}