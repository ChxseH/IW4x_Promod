	#define LOADOUT_WIDTH           270

	#define ORIGIN_LOADOUT_X				(-(LOADOUT_WIDTH - RIGHTITEM_OFFSET))
	#define ORIGIN_LOADOUT_Y				-10
	#define ORIGIN_LOADOUT         			ORIGIN_LOADOUT_X ORIGIN_LOADOUT_Y

	#define VIS_WHEN_ONE_PRIME visible when( dvarstring("loadout_secondary") == "beretta" || dvarstring("loadout_secondary") == "coltanaconda" || dvarstring("loadout_secondary") == "usp" || dvarstring("loadout_secondary") == "deserteagle" || dvarstring("loadout_secondary") == "deserteaglegold") 
	#define VIS_WHEN_TWO_PRIME visible when( dvarstring("loadout_secondary") != "beretta" && dvarstring("loadout_secondary") != "coltanaconda" && dvarstring("loadout_secondary") != "usp" && dvarstring("loadout_secondary") != "deserteagle" && dvarstring("loadout_secondary") != "deserteaglegold") 

/* ================================================================================= */
/* ================================ LOADOUT DISPLAY ================================ */
/* ================================================================================= */

// CAC loadout main frame =================

    #define LOADOUT_ALIGN   RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP    
    
    #define LOADOUT_PLATING( py, ph, vis_gradient_top, vis_gradient_bottom ) \
            LOADOUT_PLATING_RAW( ORIGIN_LOADOUT, 0, py, (LOADOUT_WIDTH+8), ph, LOADOUT_ALIGN, vis_gradient_top, vis_gradient_bottom )
        
    // background frame --------

    PREPROC_SHADER_DRAW_ALIGNED( -24 8 -20 217 LOADOUT_ALIGN, ORIGIN_LOADOUT, "gradient", 1 1 1 0.65, 0, 0, 0 0 0 0 )
    PREPROC_SHADER_DRAW_ALIGNED( (LOADOUT_WIDTH+4) 8 20 217 LOADOUT_ALIGN, ORIGIN_LOADOUT, "gradient", 1 1 1 0.65, 0, 0, 0 0 0 0 )

    // primary weapon camo
    PREPROC_SHADER_DRAW_ALIGNED( -4 16 (LOADOUT_WIDTH+8) 80 LOADOUT_ALIGN, ORIGIN_LOADOUT, STAT_CAC_CAMO, 1 1 1 1, 0, 1, 1 1 1 1) 

    /* top bar */           LOADOUT_PLATING( 16, 8, 0, 1 )
    /* bottom bar */        LOADOUT_PLATING( 225, 8, 1, 0 )
    /* weapon divider */    LOADOUT_PLATING( 104, 8, 1, 1 )
    /* grenade plate */        LOADOUT_PLATING( 188, 8, 1, 1 )


// weapon loadout info display ============

    // primary weapon name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 20 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/statstable.csv", 0, STAT_CAC_PRIMARY, 3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE )
    // primary weapon attachment name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 74 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/attachmenttable.csv", 9, STAT_CAC_PRIMARY_ATTACHMENT, 3), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR )
    // primary weapon image
    PREPROC_SHADER_DRAW_ALIGNED( 74 10 180 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_PRIMARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1) 
    // primary weapon attachment image
    PREPROC_SHADER_DRAW_ALIGNED( 2 42 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 9, STAT_CAC_PRIMARY_ATTACHMENT, 6 ), 1 1 1 1, 0, 1, 1 1 1 1)  
  
    // second weapon name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 108 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@" + tablelookup("mp/statstable.csv", 0, STAT_CAC_SECONDARY, 3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE )
    // second weapon attachment name
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 162 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, "@"+tablelookup("mp/attachmenttable.csv", 9, STAT_CAC_SECONDARY_ATTACHMENT, 3), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR )
    // second weapon image
    PREPROC_SHADER_DRAW_ALIGNED( 160 98 180 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_SECONDARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1 VIS_WHEN_TWO_PRIME ) 
	PREPROC_SHADER_DRAW_ALIGNED( 74 98 180 90 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/statstable.csv", 0, STAT_CAC_SECONDARY, 6 ), 1 1 1 1, 0, 1, 1 1 1 1 VIS_WHEN_ONE_PRIME ) 
    // second weapon attachment image
    PREPROC_SHADER_DRAW_ALIGNED( 2 130 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, tablelookup( "mp/attachmenttable.csv", 9, STAT_CAC_SECONDARY_ATTACHMENT, 6 ), 1 1 1 1, 0, 1, 1 1 1 1)   

    // grenade icons ------------
    PREPROC_SHADER_DRAW_ALIGNED( 5 186 32 32 LOADOUT_ALIGN, ORIGIN_LOADOUT, "weapon_fraggrenade", 1 1 1 1, 0, 1, 1 1 1 1 visible when(  dvarInt( weap_allow_frag_grenade ) ) ) 
    PREPROC_SHADER_DRAW_ALIGNED( 35 192 22 22 LOADOUT_ALIGN, ORIGIN_LOADOUT, "weapon_smokegrenade", 1 1 1 1, 0, 1, 1 1 1 1 visible when( dvarString( loadout_grenade ) == "smoke_grenade" ) ) 
    PREPROC_SHADER_DRAW_ALIGNED( 35 192 22 22 LOADOUT_ALIGN, ORIGIN_LOADOUT, "weapon_flashbang", 1 1 1 1, 0, 1, 1 1 1 1 visible when( dvarString( loadout_grenade ) == "flash_grenade" ) ) 

    // grenade counts ------------
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 0 192 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_frag_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarInt( weap_allow_frag_grenade ) ) )
    PREPROC_TEXT_DRAW_ALIGNED_EXP( 30 192 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_flash_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString( loadout_grenade ) == "flash_grenade" ) )
	PREPROC_TEXT_DRAW_ALIGNED_EXP( 30 192 (LOADOUT_WIDTH+8) 20 LOADOUT_ALIGN, ORIGIN_LOADOUT, dvarInt( weap_allow_smoke_grenade ), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString( loadout_grenade ) == "smoke_grenade" ) )	
  
