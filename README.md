# Promod for IW4x
Basically what it says on the tin.

Notes:

**When you are ready to use this mod on a server, place everything into a zip and rename it to `z_promod.iwd` and distribute that through FastDL, or any way you want. This is required.**

* I ship some weird defaults in `promod_ruleset/custom_public.gsc` which you should change before using this mod.

* There are ads in places, you *can* change them, but I'd appreciate if you left them;)
```
./maps/mp/gametypes/_rank.gsc: self setClientDvar( "cg_objectiveText", "^1Promod\n^2chse.xyz/donate" );
./promod/_promod_util.gsc: [...] setDvarIfUninitialized("promod_hud_website","chse.xyz/donate"); [...]
./ui_mp/auconfirm.menu: text "chse.xyz/donate"
```

* Recommended server.cfg settings:
```
set promod_mode "custom_public"
set promod_allow_strattime "1" //strat time in pub modes
set promod_allow_readyup "0" //ready-up time in pub modes
set promod_allow_timeout "0"  //timeout in pub modes
set promod_adv_balance "1" //won't allow players to join a team, that already has more players than the other one in pub modes
set weap_allow_new_weapons "1" //allows ak74u and m40a3, 0 by default on non-react clients
set promod_allow_stratweapon "0" //gives weapons in strat time already, allows player to fire in strat time
set promod_allow_winningkc_match "1" //match mode only
set promod_allow_winningkc "1"  //non-match modes
set promod_allow_leaderdialog "1"  //leader saying "bomb planted/defused"
set promod_hud_website "chse.xyz/donate"  //website shown in hud
set promod_less_rotating "1" //won't rotate map if server is empty -> less server crashes
```
