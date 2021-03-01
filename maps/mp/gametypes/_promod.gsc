#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
    level.serverDvars =[];
    game["allies_assault_count"] = 0;
    game["allies_specops_count"] = 0;
    game["allies_demolitions_count"] = 0;
    game["allies_sniper_count"] = 0;
    game["axis_assault_count"] = 0;
    game["axis_specops_count"] = 0;
    game["axis_demolitions_count"] = 0;
    game["axis_sniper_count"] = 0;
    setServerDvarDefault("class_assault_limit", 64, 0, 64);
    setServerDvarDefault("class_specops_limit", 2, 0, 64);
    setServerDvarDefault("class_demolitions_limit", 1, 0, 64);
    setServerDvarDefault("class_sniper_limit", 1, 0, 64);
    setDvarDefault("class_assault_allowdrop", 1, 0, 1);
    setDvarDefault("class_specops_allowdrop", 1, 0, 1);
    setDvarDefault("class_demolitions_allowdrop", 0, 0, 1);
    setDvarDefault("class_sniper_allowdrop", 0, 0, 1);
    setDvarDefault("weap_allow_m16", 1, 0, 1);
    setDvarDefault("weap_allow_ak47", 1, 0, 1);
    setDvarDefault("weap_allow_m4", 1, 0, 1);
    setDvarDefault("weap_allow_famas", 1, 0, 1);
    setDvarDefault("weap_allow_scar", 1, 0, 1);
    setDvarDefault("weap_allow_tavor", 1, 0, 1);
    setDvarDefault("weap_allow_fal", 1, 0, 1);
    setDvarDefault("weap_allow_masada", 1, 0, 1);
    setDvarDefault("weap_allow_fn2000", 1, 0, 1);
    setDvarDefault("attach_allow_assault_none", 1, 0, 1);
    setDvarDefault("attach_allow_assault_silencer", 1, 0, 1);
    setDvarDefault("weap_allow_mp5k", 1, 0, 1);
    setDvarDefault("weap_allow_uzi", 1, 0, 1);
    setDvarDefault("weap_allow_kriss", 1, 0, 1);
    setDvarDefault("weap_allow_ump45", 1, 0, 1);
    setDvarDefault("attach_allow_specops_none", 1, 0, 1);
    setDvarDefault("attach_allow_specops_silencer", 1, 0, 1);
    setDvarDefault("weap_allow_m1014", 1, 0, 1);
    setDvarDefault("weap_allow_spas12", 1, 0, 1);
    setDvarDefault("weap_allow_ranger", 1, 0, 1);
    setDvarDefault("weap_allow_model1887", 1, 0, 1);
    setDvarDefault("weap_allow_cheytac", 1, 0, 1);
    setDvarDefault("weap_allow_ak74u", 1, 0, 1);
    setDvarDefault("weap_allow_m40a3", 1, 0, 1);
    setServerDvarDefault("weap_allow_beretta", 1, 0, 1);
    setServerDvarDefault("weap_allow_coltanaconda", 1, 0, 1);
    setServerDvarDefault("weap_allow_usp", 1, 0, 1);
    setServerDvarDefault("weap_allow_deserteagle", 1, 0, 1);
    setServerDvarDefault("weap_allow_deserteaglegold", 1, 0, 1);
    setServerDvarDefault("attach_allow_pistol_none", 1, 0, 1);
    setServerDvarDefault("attach_allow_pistol_silencer", 1, 0, 1);
    setServerDvarDefault("weap_allow_frag_grenade", 1, 0, 1);
    setServerDvarDefault("weap_allow_flash_grenade", 1, 0, 1);
    setServerDvarDefault("weap_allow_smoke_grenade", 1, 0, 1);
    setServerDvarDefault("allies_allow_assault", 1, 0, 1);
    setServerDvarDefault("allies_allow_specops", 1, 0, 1);
    setServerDvarDefault("allies_allow_demolitions", 1, 0, 1);
    setServerDvarDefault("allies_allow_sniper", 1, 0, 1);
    setServerDvarDefault("axis_allow_assault", 1, 0, 1);
    setServerDvarDefault("axis_allow_specops", 1, 0, 1);
    setServerDvarDefault("axis_allow_demolitions", 1, 0, 1);
    setServerDvarDefault("axis_allow_sniper", 1, 0, 1);
    setDvarDefault("class_assault_primary", "ak47");
    setDvarDefault("class_assault_primary_attachment", "none");
    setDvarDefault("class_assault_secondary", "deserteagle");
    setDvarDefault("class_assault_secondary_attachment", "none");
    setDvarDefault("class_assault_grenade", "smoke_grenade");
    setDvarDefault("class_assault_camo", "none");
    setDvarDefault("class_specops_primary", "mp5k");
    setDvarDefault("class_specops_primary_attachment", "none");
    setDvarDefault("class_specops_secondary", "deserteagle");
    setDvarDefault("class_specops_secondary_attachment", "none");
    setDvarDefault("class_specops_grenade", "smoke_grenade");
    setDvarDefault("class_specops_camo", "none");
    setDvarDefault("class_demolitions_primary", "spas12");
    setDvarDefault("class_demolitions_primary_attachment", "none");
    setDvarDefault("class_demolitions_secondary", "deserteagle");
    setDvarDefault("class_demolitions_secondary_attachment", "none");
    setDvarDefault("class_demolitions_grenade", "smoke_grenade");
    setDvarDefault("class_demolitions_camo", "none");
    setDvarDefault("class_sniper_primary", "cheytac");
    setDvarDefault("class_sniper_primary_attachment", "none");
    setDvarDefault("class_sniper_secondary", "deserteagle");
    setDvarDefault("class_sniper_secondary_attachment", "none");
    setDvarDefault("class_sniper_grenade", "smoke_grenade");
    setDvarDefault("class_sniper_camo", "none");
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connecting", player);
        player thread initClassLoadouts();
        player thread updateServerDvars();
    }
}

setClassChoice(classType)
{
    self.pers["class"] = classType;
    self.class = classType;
    self setClientDvar("loadout_class", classType);
    self initClassLoadouts();
    self setDvarsFromClass(classType);
    switch (classType)
    {
        case "assault":
            self setClientDvars("weap_allow_m16", getDvar("weap_allow_m16"), "weap_allow_ak47", getDvar("weap_allow_ak47"), "weap_allow_m4", getDvar("weap_allow_m4"), "weap_allow_famas", getDvar("weap_allow_famas"), "weap_allow_scar", getDvar("weap_allow_scar"), "weap_allow_tavor", getDvar("weap_allow_tavor"), "weap_allow_fal", getDvar("weap_allow_fal"), "weap_allow_masada", getDvar("weap_allow_masada"), "weap_allow_fn2000", getDvar("weap_allow_fn2000"), "attach_allow_assault_none", getDvar("attach_allow_assault_none"), "attach_allow_assault_silencer", getDvar("attach_allow_assault_silencer"));
            break;
        case "specops":
            self setClientDvars("weap_allow_mp5k", getDvar("weap_allow_mp5k"), "weap_allow_uzi", getDvar("weap_allow_uzi"), "weap_allow_ump45", getDvar("weap_allow_ump45"), "weap_allow_kriss", getDvar("weap_allow_kriss"), "weap_allow_ak74u", getDvar("weap_allow_ak74u"), "attach_allow_specops_none", getDvar("attach_allow_specops_none"), "attach_allow_specops_silencer", getDvar("attach_allow_specops_silencer"));
            break;
        case "demolitions":
            self setClientDvars("weap_allow_m1014", getDvar("weap_allow_m1014"), "weap_allow_spas12", getDvar("weap_allow_spas12"), "weap_allow_ranger", getDvar("weap_allow_ranger"), "weap_allow_model1887", getDvar("weap_allow_model1887"));
            break;
        case "sniper":
            self setClientDvars("weap_allow_cheytac", getDvar("weap_allow_cheytac"), "weap_allow_m40a3", getDvar("weap_allow_m40a3"));
            break;
    }

    thread updateClassAvailability(self.pers["team"]);
}

setDvarWrapper(dvarName, setVal)
{
    setDvar(dvarName, setVal);
    if (isDefined(level.serverDvars[dvarName]))
    {
        level.serverDvars[dvarName] = setVal;
        players = level.players;
        for (index = 0; index < level.players.size; index++) players[index] setClientDvar(dvarName, setVal);
    }
}

setDvarDefault(dvarName, setVal, minVal, maxVal)
{
    if (getDvar(dvarName) != "")
    {
        if (isString(setVal)) setVal = getDvar(dvarName);
        else setVal = getDvarFloat(dvarName);
    }

    if (isDefined(minVal) && !isString(setVal)) setVal = max(setVal, minVal);
    if (isDefined(maxVal) && !isString(setVal)) setVal = min(setVal, maxVal);
    setDvar(dvarName, setVal);
    return setVal;
}

setServerDvarDefault(dvarName, setVal, minVal, maxVal)
{
    setVal = setDvarDefault(dvarName, setVal, minVal, maxVal);
    level.serverDvars[dvarName] = setVal;
}

setServerInfoDvarDefault(dvarName, setVal, minVal, maxVal)
{
    makeDvarServerInfo(dvarName, setVal);
    setVal = setDvarDefault(dvarName, setVal, minVal, maxVal);
}

initClassLoadouts()
{
    self initLoadoutForClass("assault");
    self initLoadoutForClass("specops");
    self initLoadoutForClass("demolitions");
    self initLoadoutForClass("sniper");
}

initLoadoutForClass(classType)
{
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_primary"])) self.pers[classType]["loadout_primary"] = getDvar("class_" + classType + "_primary");
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_primary_attachment"])) self.pers[classType]["loadout_primary_attachment"] = getDvar("class_" + classType + "_primary_attachment");
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_secondary"])) self.pers[classType]["loadout_secondary"] = getDvar("class_" + classType + "_secondary");
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_secondary_attachment"])) self.pers[classType]["loadout_secondary_attachment"] = getDvar("class_" + classType + "_secondary_attachment");
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_grenade"])) self.pers[classType]["loadout_grenade"] = getDvar("class_" + classType + "_grenade");
    if (!isDefined(self.pers[classType]) || !isDefined(self.pers[classType]["loadout_camo"])) self.pers[classType]["loadout_camo"] = getDvar("class_" + classType + "_camo");
}

setDvarsFromClass(classType)
{
    self setClientDvars("loadout_primary", self.pers[classType]["loadout_primary"], "loadout_primary_attachment", self.pers[classType]["loadout_primary_attachment"], "loadout_secondary", self.pers[classType]["loadout_secondary"], "loadout_secondary_attachment", self.pers[classType]["loadout_secondary_attachment"], "loadout_grenade", self.pers[classType]["loadout_grenade"], "loadout_camo", self.pers[classType]["loadout_camo"]);
}

isValidWeaponString(string)
{
    switch (string)
    {
        case "loadout_primary:m16":
        case "loadout_primary:ak47":
        case "loadout_primary:m4":
        case "loadout_primary:famas":
        case "loadout_primary:scar":
        case "loadout_primary:fal":
        case "loadout_primary:masada":
        case "loadout_primary:tavor":
        case "loadout_primary:fn2000":
        case "loadout_primary:mp5k":
        case "loadout_primary:uzi":
        case "loadout_primary:ump45":
        case "loadout_primary:kriss":
        case "loadout_primary:spas12":
        case "loadout_primary:m1014":
        case "loadout_primary:ranger":
        case "loadout_primary:model1887":
        case "loadout_primary:cheytac":
        case "loadout_primary:ak74u":
        case "loadout_primary:m40a3":
        case "loadout_secondary:deserteaglegold":
        case "loadout_secondary:deserteagle":
        case "loadout_secondary:coltanaconda":
        case "loadout_secondary:usp":
        case "loadout_secondary:beretta":
            return true;
        default:
            return false;
    }
}

isValidAttachmentString(string)
{
    switch (string)
    {
        case "loadout_primary_attachment:assault:none":
        case "loadout_primary_attachment:assault:silencer":
        case "loadout_primary_attachment:specops:none":
        case "loadout_primary_attachment:specops:silencer":
        case "loadout_primary_attachment:demolitions:none":
        case "loadout_secondary_attachment:pistol:none":
        case "loadout_secondary_attachment:pistol:silencer":
            return true;
        default:
            return false;
    }
}

processLoadoutResponse(respString)
{
    commandTokens = strTok(respString, ",");
    for (index = 0; index < commandTokens.size; index++)
    {
        subTokens = strTok(commandTokens[index], ":");
        assert(subTokens.size > 1);
        switch (subTokens[0])
        {
            case "loadout_primary":
            case "loadout_secondary":
                if (!isValidWeaponString(respString)) return;
                if (getDvarInt("weap_allow_" + subTokens[1]) && self verifyWeaponChoice(subTokens[1], self.class))
                {
                    self.pers[self.class][subTokens[0]] = subTokens[1];
                    self setClientDvar(subTokens[0], subTokens[1]);
                    if (subTokens[1] == "deserteagle" || subTokens[1] == "deserteaglegold" || subTokens[1] == "coltanaconda")
                    {
                        self.pers[self.class]["loadout_secondary_attachment"] = "none";
                        self setClientDvar("loadout_secondary_attachment", "none");
                    }
                }
                else
                {
                    self setClientDvar(subTokens[0], self.pers[self.class][subTokens[0]]);
                }

                break;
            case "loadout_primary_attachment":
            case "loadout_secondary_attachment":
                if (!isValidAttachmentString(respString)) return;
                if (subTokens[0] == "loadout_primary_attachment" && (self.pers[self.class]["loadout_primary"] == "peacekeeper" || self.pers[self.class]["loadout_primary"] == "ak74u"))
                {
                    self.pers[self.class]["loadout_primary_attachment"] = "none";
                    self setClientDvar("loadout_primary_attachment", "none");
                }

                if (getDvarInt("attach_allow_" + subTokens[1] + "_" + subTokens[2]))
                {
                    self.pers[self.class][subTokens[0]] = subTokens[2];
                    self setClientDvar(subTokens[0], subTokens[2]);
                }
                else
                {
                    self setClientDvar(subTokens[0], self.pers[self.class][subTokens[0]]);
                }

                break;
            case "loadout_grenade":
                if (respString != "loadout_grenade:flash_grenade" && respString != "loadout_grenade:smoke_grenade") return;
                if (getDvarInt("weap_allow_" + subTokens[1]))
                {
                    self.pers[self.class][subTokens[0]] = subTokens[1];
                    self setClientDvar(subTokens[0], subTokens[1]);
                }
                else
                {
                    self setClientDvar(subTokens[0], self.pers[self.class][subTokens[0]]);
                }

                break;
            case "loadout_camo":
                switch (subTokens[1])
                {
                    case "none":
                    case "woodland":
                    case "desert":
                    case "arctic":
                    case "digital":
                    case "red_urban":
                    case "red_tiger":
                    case "blue_tiger":
                    case "orange_fall":
                        self.pers[self.class][subTokens[0]] = subTokens[1];
                        self setClientDvar(subTokens[0], subTokens[1]);
                        break;
                }
        }
    }
}

verifyWeaponChoice(weaponName, classType)
{
    if (tableLookup("mp/statsTable.csv", 4, weaponName, 2) == "weapon_pistol") return true;
    switch (classType)
    {
        case "assault":
        case "sniper":
            if (tableLookup("mp/statsTable.csv", 4, weaponName, 2) == "weapon_" + classType) return true;
            break;
        case "specops":
            if (tableLookup("mp/statsTable.csv", 4, weaponName, 2) == "weapon_smg") return true;
            break;
        case "demolitions":
            if (tableLookup("mp/statsTable.csv", 4, weaponName, 2) == "weapon_shotgun") return true;
            break;
    }

    return false;
}

verifyClassChoice(teamName, classType)
{
    if (teamName == "allies" || teamName == "axis")
    {
        if (isDefined(self.pers["class"]) && self.pers["class"] == classType) return true;
        game[teamName + "_" + classType + "_count"] = 0;
        for (i = 0; i < level.players.size; i++)
            if (level.players[i].team == teamName && isDefined(level.players[i].class) && level.players[i].class == classType) game[teamName + "_" + classType + "_count"]++;
        return (game[teamName + "_" + classType + "_count"]<getDvarInt("class_" + classType + "_limit"));
    }

    return false;
}

updateClassAvailability(teamName)
{
    game[teamName + "_assault_count"] = 0;
    game[teamName + "_specops_count"] = 0;
    game[teamName + "_demolitions_count"] = 0;
    game[teamName + "_sniper_count"] = 0;
    for (i = 0; i < level.players.size; i++)
    {
        player = level.players[i];
        if (player.team == teamName && isDefined(player.class) && player.class == "assault") game[teamName + "_assault_count"]++;
        if (player.team == teamName && isDefined(player.class) && player.class == "specops") game[teamName + "_specops_count"]++;
        if (player.team == teamName && isDefined(player.class) && player.class == "demolitions") game[teamName + "_demolitions_count"]++;
        if (player.team == teamName && isDefined(player.class) && player.class == "sniper") game[teamName + "_sniper_count"]++;
    }

    setDvarWrapper(teamName + "_allow_assault", game[teamName + "_assault_count"]<getDvarInt("class_assault_limit"));
    setDvarWrapper(teamName + "_allow_specops", game[teamName + "_specops_count"]<getDvarInt("class_specops_limit"));
    setDvarWrapper(teamName + "_allow_demolitions", game[teamName + "_demolitions_count"]<getDvarInt("class_demolitions_limit"));
    setDvarWrapper(teamName + "_allow_sniper", game[teamName + "_sniper_count"]<getDvarInt("class_sniper_limit"));
}

menuAcceptClass()
{
    if (!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis")) return;
    if (self.sessionstate == "playing")
    {
        if (game["state"] == "postgame") return;
        if (self instant_give())
        {
            self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], self.pers["class"]);
        }
        else
        {
            self iPrintLnBold(game["strings"]["change_class"]);
            self setClientDvar("loadout_curclass", self.pers["class"]);
        }
    }
    else
    {
        self setClientDvar("loadout_curclass", self.pers["class"]);
        if (game["state"] == "postgame") return;
        if (game["state"] == "playing" && !isInKillcam()) self thread maps\mp\gametypes\_playerlogic::spawnClient();
    }

    self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

instant_give()
{
    instant = false;
    if (((!gameFlag("prematch_done")) || (isDefined(level.strat_over) && !level.strat_over) || (isDefined(level.ready_up_over) && !level.ready_up_over) || (isDefined(level.timeout_over) && !level.timeout_over) && (self.pers["team"] == "axis" || self.pers["team"] == "allies")) && (!isDefined(self.usingBot) || !self.usingBot)) instant = true;
    if ((isDefined(game["PROMOD_KNIFEROUND"]) && game["PROMOD_KNIFEROUND"]) && ((isDefined(level.strat_over) && !level.strat_over) || (!gameFlag("prematch_done") && game["PROMOD_MATCH_MODE"] == "pub"))) instant = false;
    return instant;
}

updateServerDvars()
{
    self endon("disconnect");
    dvarKeys = getArrayKeys(level.serverDvars);
    for (index = 0; index < dvarKeys.size; index++)
    {
        self setClientDvar(dvarKeys[index], level.serverDvars[dvarKeys[index]]);
        wait(0.05);
    }
}