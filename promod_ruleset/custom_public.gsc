main()
{
	// custom_public ruleset, promodlive_v3.3_r187

	// sd
	game["PROMOD_KNIFEROUND"] = 0; // [0-1] (disabled / enabled)
	setDvar( "scr_sd_bombtimer", 45 ); // [1->] (seconds)
	setDvar( "scr_sd_defusetime", 5 ); // [1->] (seconds)
	setDvar( "scr_sd_multibomb", 0 ); // [0-1] (everyone can plant)
	setDvar( "scr_sd_numlives", 1 ); // [0->] (amount of lives)
	setDvar( "scr_sd_planttime", 5 ); // [1->] (seconds)
	setDvar( "scr_sd_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_sd_roundlimit", 23 ); // [0->] (points)
	setDvar( "scr_sd_roundswitch", 3 ); // [0->] (points)
	setDvar( "scr_sd_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_sd_winlimit", 12 );  //[0->] (rounds)
	setDvar( "scr_sd_timelimit", 2.5 ); // [0->] (minutes)
	setDvar( "scr_sd_waverespawndelay", 0 ); // [0->] (seconds)

	// dom
	setDvar( "scr_dom_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_dom_playerrespawndelay", 7 ); // [0->] (seconds)
	setDvar( "scr_dom_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_dom_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_dom_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_dom_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_dom_waverespawndelay", 0 ); // [0->] (seconds)

	// koth
	setDvar( "koth_autodestroytime", 120 ); // [1->] (hq online time in seconds)
	setDvar( "koth_capturetime", 20 ); // [1->] (time to capture hq in seconds)
	setDvar( "koth_delayPlayer", 0 ); // [0-1] (override default respawn delay in seconds)
	setDvar( "koth_destroytime", 10 ); // [1->] (time to destroy hq in seconds)
	setDvar( "koth_kothmode", 0 ); // [0-1] (classic mode, non-classic)
	setDvar( "koth_spawnDelay", 45 ); // [0->] (default respawn delay in seconds)
	setDvar( "koth_spawntime", 10 ); // [0->] (hq spawn time in seconds)
	setDvar( "scr_koth_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_koth_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_koth_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_koth_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_koth_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_koth_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_koth_waverespawndelay", 0 ); // [0->] (seconds)

	// sab
	setDvar( "scr_sab_bombtimer", 45 ); // [1->] (seconds)
	setDvar( "scr_sab_defusetime", 5 ); // [1->] (seconds)
	setDvar( "scr_sab_hotpotato", 0 ); // [0-1] (shared bomb timer)
	setDvar( "scr_sab_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_sab_planttime", 5 ); // [1->] (seconds)
	setDvar( "scr_sab_playerrespawndelay", 7 ); // [0->] (seconds)
	setDvar( "scr_sab_roundlimit", 4 ); // [0->] (points)
	setDvar( "scr_sab_roundswitch", 2 ); // [0->] (points)
	setDvar( "scr_sab_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_sab_timelimit", 10 ); // [0->] (minutes)
	setDvar( "scr_sab_waverespawndelay", 0 ); // [0->] (seconds)

	// tdm
	setDvar( "scr_war_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_war_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_war_roundlimit", 2 ); // [0->] (points)
	setDvar( "scr_war_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_war_roundswitch", 1 ); // [0->] (points)
	setDvar( "scr_war_timelimit", 15 ); // [0->] (minutes)
	setDvar( "scr_war_waverespawndelay", 0 ); // [0->] (seconds)

	// dm
	setDvar( "scr_dm_numlives", 0 ); // [0->] (amount of lives)
	setDvar( "scr_dm_playerrespawndelay", 0 ); // [0->] (seconds)
	setDvar( "scr_dm_roundlimit", 1 ); // [0->] (points)
	setDvar( "scr_dm_scorelimit", 0 ); // [0->] (points)
	setDvar( "scr_dm_timelimit", 10 ); // [0->] (points)
	setDvar( "scr_dm_waverespawndelay", 0 ); // [0->] (seconds)

	// team killing
	setDvar( "scr_team_fftype", 0 ); // [0-3] (disabled, enabled, reflect, shared)
	setDvar( "scr_team_teamkillpointloss", 5 ); // [0->] (points)

	// player death/respawn settings
	setDvar( "scr_player_forcerespawn", 1 ); // [0-1] (require player to press use key to spawn, do not require use key to spawn)
	setDvar( "scr_game_deathpointloss", 0 ); // [0->] (points)
	setDvar( "scr_game_suicidepointloss", 0 ); // [0->] (points)
	setDvar( "scr_player_suicidespawndelay", 0 ); // [0->] (points)

	// player fall damage
	setDvar( "bg_fallDamageMinHeight", 140 ); // [1->] (min height to inflict min fall damage)
	setDvar( "bg_fallDamageMaxHeight", 350 ); // [1->] (max height to inflict max fall damage)
	

	setDvar( "g_no_script_spam", 1 );
	setDvar( "g_smoothClients", 1 );
	setDvar( "g_deadChat", 0 ); // [0-1]
	setDvar( "scr_hardcore", 0 ); // [0-1]
	setDvar( "scr_game_allowkillcam", 1 ); // [0-1]
	setDvar( "scr_game_spectatetype", 1 ); // [0-2] (disabled, team only, all)
	setDvar( "scr_game_matchstarttime", 10 ); // [0->] (seconds)
	
	//class limits per team
	setDvar( "class_assault_limit", 64 );
	setDvar( "class_specops_limit", 64 );
	setDvar( "class_demolitions_limit", 64 );
	setDvar( "class_sniper_limit", 64 );
	
	//allow weapon dropping for specific class [0-1]
	setDvar( "class_assault_allowdrop", 0 );
	setDvar( "class_specops_allowdrop", 0 );
	setDvar( "class_demolitions_allowdrop", 0 );
	setDvar( "class_sniper_allowdrop", 0 );
	
	
	//weapon restrictions [0-1]
	setDvar( "weap_allow_m16", 1 );
	setDvar( "weap_allow_ak47", 1 );
	setDvar( "weap_allow_m4", 1 );
	setDvar( "weap_allow_famas", 1 );
	setDvar( "weap_allow_scar", 1 );
	setDvar( "weap_allow_tavor", 1 );
	setDvar( "weap_allow_fal", 1 );
	setDvar( "weap_allow_masada", 1 );
	setDvar( "weap_allow_fn2000", 1 );
	
	setDvar( "attach_allow_assault_none", 1 );
	setDvar( "attach_allow_assault_silencer", 1 );
	
	setDvar( "weap_allow_mp5k", 1 );
	setDvar( "weap_allow_uzi", 1 );
	setDvar( "weap_allow_kriss", 1 );
	setDvar( "weap_allow_ump45", 1 );
	
	setDvar( "attach_allow_specops_none", 1 );
	setDvar( "attach_allow_specops_silencer", 1 );
	
	setDvar( "weap_allow_m1014", 1 );
	setDvar( "weap_allow_spas12", 1 );
	setDvar( "weap_allow_ranger", 1 );
	setDvar( "weap_allow_model1887", 0 );
	
	setDvar( "weap_allow_cheytac", 1 );

	/*setDvar( "weap_allow_peacekeeper", 1 );*/
	setDvar( "weap_allow_ak74u", 0 );
	setDvar( "weap_allow_m40a3", 0 );

	
	setDvar( "weap_allow_beretta", 1 );
	setDvar( "weap_allow_coltanaconda", 1 );
	setDvar( "weap_allow_usp", 1 );
	setDvar( "weap_allow_deserteagle", 1 );
	setDvar( "weap_allow_deserteaglegold", 1 );
	
	setDvar( "attach_allow_pistol_none", 1 );
	setDvar( "attach_allow_pistol_silencer", 1 );
	
	setDvar( "weap_allow_frag_grenade", 1 );
	setDvar( "weap_allow_flash_grenade", 0 );
	setDvar( "weap_allow_smoke_grenade", 0 );
	
	setDvar( "allies_allow_assault", 1 );
	setDvar( "allies_allow_specops", 1 );
	setDvar( "allies_allow_demolitions", 1 );
	setDvar( "allies_allow_sniper", 1 );
	
	setDvar( "axis_allow_assault", 1 );
	setDvar( "axis_allow_specops", 1 );
	setDvar( "axis_allow_demolitions", 1 );
	setDvar( "axis_allow_sniper", 1 );
	
	setDvar( "class_assault_primary", "ak47" );
	setDvar( "class_assault_primary_attachment", "none" );	
	setDvar( "class_assault_secondary", "deserteagle" );
	setDvar( "class_assault_secondary_attachment", "none" );	
	setDvar( "class_assault_grenade", "none" );
	setDvar( "class_assault_camo", "none" );
	
	setDvar( "class_specops_primary", "mp5k" );
	setDvar( "class_specops_primary_attachment", "none" );	
	setDvar( "class_specops_secondary", "deserteagle" );
	setDvar( "class_specops_secondary_attachment", "none" );	
	setDvar( "class_specops_grenade", "none" );	
	setDvar( "class_specops_camo", "none" );
	
	setDvar( "class_demolitions_primary", "spas12" );
	setDvar( "class_demolitions_primary_attachment", "none" );	
	setDvar( "class_demolitions_secondary", "deserteagle" );
	setDvar( "class_demolitions_secondary_attachment", "none" );
	setDvar( "class_demolitions_grenade", "none" );
	setDvar( "class_demolitions_camo", "none" );
	
	setDvar( "class_sniper_primary", "cheytac" );
	setDvar( "class_sniper_primary_attachment", "none" );
	setDvar( "class_sniper_secondary", "deserteagle" );
	setDvar( "class_sniper_secondary_attachment", "none" );
	setDvar( "class_sniper_grenade", "none" );
	setDvar( "class_sniper_camo", "none" );
	
	
	setDvar( "promod_adv_balance", 1 ); //[0-1] (balanced teams, can't join team which already has more players,custom public only dvar)
	setDvar( "g_allowvote", 0 ); // [0-1] (allow ingame server browser, forced 0 in match modes )
	setDvar( "promod_allow_stratweapon", 0 ); //[0-1] (allow shooting/weapons in strat time, forced 0 in match modes )
	setDvar( "promod_allow_winningkc", 1);
}