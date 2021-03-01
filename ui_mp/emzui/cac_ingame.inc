#define CHOICE_X_START          0
#define CHOICE_Y_START          0

#include "ui_mp/menustyle.inc"
#include "ui/choices_setup_common.menu"
 
#define ORIGIN_STATUS           390 64
#define MENU_FONT_COLOR2        1 1 1 0.5
#define OPENMENUONDVAR(dvar,dvarArg,menuArg) \
	if ( dvarString( dvar ) == dvarArg ) { open menuArg }


    menuDef {
        name            CAC_MENU_NAME
        rect            0 0 640 480
        focuscolor      COLOR_FOCUSED
        style           WINDOW_STYLE_EMPTY
        blurWorld       3.0

        onEsc {
            scriptMenuResponse "back";
        }
		
		#include "ui_mp/emzui/ingamebg.inc"

		itemDef
		{
			rect 48 30 0 0
			text			"Inventory"
			textfont		UI_FONT_NORMAL
			forecolor       COLOR_TITLE
			textscale		TEXTSIZE_TITLE
			textStyle 		6
			visible			1
			decoration
		}
		
        #define BACK_OPEN ;
		#include "ui_mp/navcontrols.inc"
        
        // PRIMARY WEAPON BUTTON =============================================================
        #define CAC_SETUP_ACTION1 \
            play "mouse_click"; \
			OPENMENUONDVAR(loadout_class,assault,ocd_popup_cac_assault)\
			OPENMENUONDVAR(loadout_class,specops,ocd_popup_cac_specops)\
			OPENMENUONDVAR(loadout_class,demolitions,ocd_popup_cac_demolitions)\
			OPENMENUONDVAR(loadout_class,sniper,ocd_popup_cac_sniper)

        CHOICE_HIGHLIGHT( 1, 0 )        
        CHOICE_BUTTON_NOHI( 1, "1. Primary Weapon", CAC_SETUP_ACTION1 )
        execKey "1" { CAC_SETUP_ACTION1; }

        #define CAC_SETUP_ACTION_ATTACHMENT \
            play "mouse_click"; \
			OPENMENUONDVAR(loadout_class,assault,ocd_attachment_popup_assault) \
			if( dvarString( loadout_primary ) != "ak74u") { OPENMENUONDVAR(loadout_class,specops,ocd_attachment_popup_specops) }

        CHOICE_HIGHLIGHT( 2, 1 )
		CHOICE_BUTTON_VIS_NOHI( 2, "2. Primary Attachment", CAC_SETUP_ACTION_ATTACHMENT, when( dvarString( loadout_class ) != "sniper" && dvarString( loadout_class ) != "demolitions" && dvarString( loadout_primary ) != "ak74u") )
        CHOICE_DBUTTON_VIS_NOHI( 2, "2. Primary Attachment", when( dvarString( loadout_class ) == "sniper" || dvarString( loadout_class ) == "demolitions" || dvarString( loadout_primary ) == "ak74u" ) )
        execKey "2" { CAC_SETUP_ACTION_ATTACHMENT; }

        // SECONDARY WEAPON/SIDE ARM BUTTON =============================================================
        #define CAC_SETUP_ACTION2 \
            play "mouse_click"; \
            open "ocd_popup_cac_secondary";

        CHOICE_BUTTON_BG( 3, 0 )
        CHOICE_HIGHLIGHT( 3, 0 )        
        CHOICE_BUTTON_NOHI( 3, "3. Side Arm", CAC_SETUP_ACTION2 )
        execKey "3" { CAC_SETUP_ACTION2; }
        
        // SPECIAL GRENADE BUTTON =============================================================
        #define CAC_SETUP_ACTION3 \
            play "mouse_click"; \
            open "ocd_popup_cac_extra";

        CHOICE_HIGHLIGHT( 4, 0 )        
        CHOICE_BUTTON_NOHI( 4, "4. Grenade", CAC_SETUP_ACTION3 )
        execKey "4" { open "ocd_popup_cac_extra"; }
		
        #define CAC_SETUP_ACTION4 \
            play "mouse_click"; \
            if ( dvarString( loadout_primary ) != "ranger" && dvarString( loadout_primary ) != "model1887"  && dvarString( loadout_primary ) != "ak74u" && dvarString( loadout_primary ) != "m40a3" ) { open "ocd_popup_cac_camo"; }
		
        CHOICE_HIGHLIGHT( 5, 0 )        
		CHOICE_BUTTON_VIS_NOHI( 5, "5. Camo", CAC_SETUP_ACTION4, when( dvarString( loadout_primary ) != "ranger" && dvarString( loadout_primary ) != "model1887"  && dvarString( loadout_primary ) != "ak74u" && dvarString( loadout_primary ) != "m40a3" ) )
		CHOICE_DBUTTON_VIS_NOHI( 5, "5. Camo", when( dvarString( loadout_primary ) == "ranger" || dvarString( loadout_primary ) == "model1887" ||  dvarString( loadout_primary ) == "ak74u" || dvarString( loadout_primary ) == "m40a3") )
        execKey "5" { CAC_SETUP_ACTION4; }
		
        #define CAC_SETUP_ACTIONGO \        
            play "mouse_click"; \
            scriptMenuResponse "start";

        CHOICE_HIGHLIGHT( 6, 0 )
		CHOICE_BUTTON_NOHI( 6, "6. Start!", CAC_SETUP_ACTIONGO )
        execKey "6" { CAC_SETUP_ACTIONGO; }

        #define STAT_CAC_PRIMARY                tableLookup("mp/statstable.csv", 4, dvarString( loadout_primary ), 0)
        #define STAT_CAC_PRIMARY_ATTACHMENT     tableLookup("mp/attachmentTable.csv", 4, dvarString( loadout_primary_attachment ), 9)
        #define STAT_CAC_SECONDARY              tableLookup("mp/statstable.csv", 4, dvarString( loadout_secondary ), 0)
        #define STAT_CAC_SECONDARY_ATTACHMENT   tableLookup("mp/attachmentTable.csv", 4, dvarString( loadout_secondary_attachment ), 9)
        #define STAT_CAC_SPECIAL_GRENADE        tableLookup("mp/statstable.csv", 4, dvarString( loadout_grenade ), 0)
        #define STAT_CAC_CAMO                 	tablelookup("mp/camotable.csv",1,dvarString( loadout_camo ),4)
        #include "ui_mp/emzui/cac_loadout_ingame.inc"
    }

    // close all 2nd and 3rd layer popups on end action
    #define PREPROC_ATTACH_CLOSEALL \
    close "ocd_popup_cac_primary"; \
    close "ocd_popup_cac_secondary"; \
    close "ocd_popup_cac_assault"; \
    close "ocd_popup_cac_specops"; \
    close "ocd_popup_cac_sniper"; \
    close "ocd_popup_cac_demolitions"; \
    close "popup_cac_template"; \
    close "ocd_attachment_popup_assault"; \
    close "ocd_attachment_popup_specops"; \
	close "ocd_attachment_popup_demolitions"; \
    close "ocd_attachment_popup_pistol"; \
    close "ocd_popup_cac_camo"; \
    close "ocd_attachment_popup_fake";  
    
    // including weapon data
    #include "ui_mp/weaponinfo.menu"
    
#include "ui_mp/popupstyle.inc" 
#include "ui/choices_setup_popmenu.menu"

#undef CHOICE_SIZE_X
#define CHOICE_SIZE_X           216

#undef NEW_X_OFFSET         
#define NEW_X_OFFSET    (0-CHOICE_SIZE_X)

#undef NEW_Y_OFFSET         
#define NEW_Y_OFFSET    (0-2)
#undef CHOICE_Y_START
#define CHOICE_Y_START 1

    // ====================================================================================================
    // primary weapon selection ===========================================================================
    // ====================================================================================================
	#define LOCAL_WEAPON_INFO_WINDOW \
		/* weapon information side frame*/ \
		PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 9 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( 1 ); ) \
		LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -4, -2, 280, (CHOICE_POPUP_HEIGHT( 9 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( 1 );, 0, 0 )\
		/* weapon image*/ \
		PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( 1 ); ) \
		PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+72) -6 180 90 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_primary_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( 1 ); ) \
		/* weapon title*/\
		PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_primary_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( 1 ); ) \
		/* weapon desc unlocked*/\
		PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_primary_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1  )\
		
    #define LOCAL_PRIMARY_WEAPON_ACTION( weapRef ) \
        play "mouse_click"; \
        scriptMenuResponse "loadout_primary:"weapRef;\
        setdvar loadout_primary weapRef; \
		setdvar loadout_camo none; \
		close self;\
		scriptMenuResponse "go";
		
	#define WI_FOCUS_ACTION( weaponRef ) \
		exec "set ui_primary_highlighted "weaponRef;

    #define LOCAL_WEAPON_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_primary_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_PRIMARY_WEAPON_ACTION( weaponRef ), \
        WI_FOCUS_ACTION( weaponRef ), ;, when(dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_PRIMARY_WEAPON_ACTION( weaponRef ) } \

	#undef  UI_FOCUSFIRST
	#define UI_FOCUSFIRST "ui_primary_highlighted"
	
    // primary weapon items
     #define LOCAL_MASTER_WEAPON_GROUP( pos, y_offset )\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_assault", 9, (CHOICE_X( pos )), (CHOICE_Y( pos )-y_offset), ;, execnow "set "UI_FOCUSFIRST" ak47; set ui_inside_popup assault";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW\
        LOCAL_WEAPON_ITEM( 1, "1. AK-47", "ak47" )\
		LOCAL_WEAPON_ITEM( 2, "2. M16A4", "m16" )\
        LOCAL_WEAPON_ITEM( 3, "3. M4A1", "m4" )\
        LOCAL_WEAPON_ITEM( 4, "4. FAMAS", "famas" )\
        LOCAL_WEAPON_ITEM( 5, "5. SCAR-H", "scar" )\
        LOCAL_WEAPON_ITEM( 6, "6. TAR-21", "tavor" )\
        LOCAL_WEAPON_ITEM( 7, "7. FAL", "fal" )\
		LOCAL_WEAPON_ITEM( 8, "8. ACR", "masada" )\
		LOCAL_WEAPON_ITEM( 9, "9. F2000", "fn2000" )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_specops", 9, (CHOICE_X( pos )), (CHOICE_Y( pos )-y_offset), ;, execnow "set "UI_FOCUSFIRST" mp5k;set ui_inside_popup specops";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW\
        LOCAL_WEAPON_ITEM( 1, "1. MP5K", "mp5k" )\
        LOCAL_WEAPON_ITEM( 2, "2. UMP45", "ump45" )\
        LOCAL_WEAPON_ITEM( 3, "3. Vector", "kriss" )\
		LOCAL_WEAPON_ITEM( 4, "4. Mini-Uzi", "uzi" )\
		LOCAL_WEAPON_ITEM( 5, "5. AK74-U", "ak74u" )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_demolitions", 9, (CHOICE_X( pos )), (CHOICE_Y( pos )-y_offset), ;, execnow "set "UI_FOCUSFIRST" spas12; set ui_inside_popup demolitions";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW\
        LOCAL_WEAPON_ITEM( 1, "1. SPAS-12", "spas12" )\
		LOCAL_WEAPON_ITEM( 2, "2. M1014", "m1014" )\
		LOCAL_WEAPON_ITEM( 3, "3. Ranger", "ranger" )\
		LOCAL_WEAPON_ITEM( 4, "4. Model 1887", "model1887" )\
    }\
    menuDef {\
        IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_sniper", 9, (CHOICE_X( pos )), (CHOICE_Y( pos )-y_offset), ;, execnow "set "UI_FOCUSFIRST" cheytac; set ui_inside_popup sniper";, 0 )\
        LOCAL_WEAPON_INFO_WINDOW\
        LOCAL_WEAPON_ITEM( 1, "1. Intervention", "cheytac" )\
        LOCAL_WEAPON_ITEM( 2, "2. M40A3", "m40a3" )\
    }
    // primary and second primary weapon selection popup menus
    LOCAL_MASTER_WEAPON_GROUP( 1, 57 )
    
    // ====================================================================================================
    // primary and second primary attachment selection ====================================================
    // ====================================================================================================
    #define LOCAL_ATTACHMENT_INFO_WINDOW \
        /* attachment information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 6 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -4, -2, 280, (CHOICE_POPUP_HEIGHT( 6 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "camo" );, 0, 0 ) \
        /* attachment image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+182) 6 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        /* attachment title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString(ui_inside_popup) != "camo" ); ) \
        /* attachment desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/attachmentTable.csv",4,dvarString(ui_attachment_highlighted),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1 )\

    #define LOCAL_ATTACHMENT_ACTION( attachmentName, groupArg ) \
        setdvar loadout_primary_attachment attachmentName; \
        scriptmenuresponse "loadout_primary_attachment:"groupArg":"attachmentName;\
        close self; \
		scriptMenuResponse "go";
        
    #define LOCAL_ATTACHMENT_ACTION2( attachmentName, groupArg ) \
        setdvar loadout_secondary_attachment attachmentName; \
        scriptmenuresponse "loadout_secondary_attachment:"groupArg":"attachmentName;\
		close self;\
		scriptMenuResponse "go"; \
        PREPROC_ATTACH_CLOSEALL

    #define AI_FOCUS_ACTION( weaponRef ) \
        exec "set ui_attachment_highlighted "weaponRef;

    #define LOCAL_ATTACHMENT_ITEM( itemNum, groupArg, pname, ptype,name)\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_attachment_highlighted "weaponRef;, ;, when(!dvarBool( "attach_allow_"groupArg"_"pname )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, name, LOCAL_ATTACHMENT_ACTION(pname, groupArg ), \
        AI_FOCUS_ACTION(pname), ;, when( ptype == "primary" && dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, name, LOCAL_ATTACHMENT_ACTION2(pname, groupArg ), \
        AI_FOCUS_ACTION(pname), ;, when( ptype == "secondary" && dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, AI_FOCUS_ACTION(pname), ;, when( !dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, name, when( !dvarBool( "attach_allow_"groupArg"_"pname ) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "attach_allow_"groupArg"_"pname ) ) ) 
		
	
    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_attachment_highlighted"
        
    // primary and second primary attachment items
    #define LOCAL_MASTER_ATTACHMENT_GROUP( pos, ptype, y_offset)\
    menuDef { /* assault attachments*/ \
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_assault", 6, (CHOICE_X( pos )), (CHOICE_Y( pos )+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )\
        onClose{execnow "set ui_inside_popup 0";} \
        LOCAL_ATTACHMENT_INFO_WINDOW\
        LOCAL_ATTACHMENT_ITEM( 1,"assault", "none", ptype,"1. None" )\
        LOCAL_ATTACHMENT_ITEM( 2,"assault",  "silencer", ptype,"2. Silencer" )\
		execKey 1 { LOCAL_ATTACHMENT_ACTION( "none" , "assault" ) }\
		execKey 2 { LOCAL_ATTACHMENT_ACTION( "silencer" , "assault" ) } \
    }\
    menuDef { /* SMG attachments*/\
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_specops", 6, (CHOICE_X( pos )), (CHOICE_Y( pos )+y_offset), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )\
        onClose{execnow "set ui_inside_popup 0";} \
        LOCAL_ATTACHMENT_INFO_WINDOW\
        LOCAL_ATTACHMENT_ITEM( 1,"specops", "none", ptype,"1. None" )\
        LOCAL_ATTACHMENT_ITEM( 2,"specops",  "silencer", ptype,"2. Silencer" )\
		execKey 1 { LOCAL_ATTACHMENT_ACTION( "none" , "specops" ) } \
		execKey 2 { LOCAL_ATTACHMENT_ACTION( "silencer" , "specops" ) } \
    }\

    menuDef { /* fake attachment heading for weapons without attachments to be displayed on top of camo popup */
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_fake", 6, (CHOICE_X( 1 )), (CHOICE_Y( 1 ) + 44), ;, ;, 0 )
        LOCAL_ATTACHMENT_INFO_WINDOW
        PREPROC_SHADER_DRAW_ALIGNED( 0 -24 (CHOICE_POPUP_WIDTH-4) 22 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", 0.15 0.15 0.17 1, 0, 2, CHOICE_POPUP_BORDER_COLOR )
    }

    // side arm attachment selection ======================================================================
    menuDef { /* pistol attachments*/
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_attachment_popup_pistol", 6, (CHOICE_X( 2 )), (CHOICE_Y( 2 )+8-35), ;, execnow "set "UI_FOCUSFIRST" "REF_ATTACHMENT_NONE"; set ui_inside_popup attachment";, 0 )
        onClose{execnow "set ui_inside_popup 0";}
        LOCAL_ATTACHMENT_INFO_WINDOW
        LOCAL_ATTACHMENT_ITEM( 1, "pistol", "none", "secondary","1. None" )
        LOCAL_ATTACHMENT_ITEM( 2, "pistol", "silencer", "secondary","2. Silencer" )
		execKey 1 { LOCAL_ATTACHMENT_ACTION2( "none" , "pistol" ) }
		execKey 2 { LOCAL_ATTACHMENT_ACTION2( "silencer" , "pistol" ) }
    }
    
    // primary and second primary attachment popup menus
      LOCAL_MASTER_ATTACHMENT_GROUP( 1, "primary", 8-35 )

    // ====================================================================================================
    // side arm selection ===============================================================================
    // ====================================================================================================
    #define LOCAL_SIDEARM_INFO_WINDOW \
        /* sidearm information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 6 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -4, -2, 280, (CHOICE_POPUP_HEIGHT( 6 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "attachment" );, 0, 0 )\
        /* sidearm image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+72) -6 180 90 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_sidearm_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        /* sidearm title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sidearm_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        /* sidearm desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sidearm_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible 1; )\

    #define LOCAL_SIDEARM_ACTION( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_secondary weaponRef; \
            setdvar loadout_secondary_attachment none; \
            scriptMenuResponse "loadout_secondary:"weaponRef;\
			scriptMenuResponse "go"; \
            PREPROC_ATTACH_CLOSEALL

    #define LOCAL_SIDEARM_ACTION2( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_secondary weaponRef; \
            setdvar loadout_secondary_attachment none; \
            scriptMenuResponse "loadout_secondary:"weaponRef;\
			OPENMENUONDVAR(selected_weapon_class,pistol,ocd_attachment_popup_pistol)\
			scriptMenuResponse "go";
    
    #define SI_FOCUS_ACTION( weaponRef ) \
        exec "set ui_sidearm_highlighted "weaponRef;

    #define LOCAL_SIDEARM_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_sidearm_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SIDEARM_ACTION( weaponRef ), \
        SI_FOCUS_ACTION( weaponRef ), ;, when( dvarBool( "weap_allow_"weaponRef ) && ( weaponRef == REF_DESERTEAGLE || weaponRef == REF_DESERTEAGLEGOLD || weaponRef == REF_COLTANACONDA )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SIDEARM_ACTION2( weaponRef ), \
        SI_FOCUS_ACTION( weaponRef ), ;, when( dvarBool( "weap_allow_"weaponRef ) && weaponRef != REF_DESERTEAGLE && weaponRef != REF_DESERTEAGLEGOLD && weaponRef != REF_COLTANACONDA ); ) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when( !dvarBool( "weap_allow_"weaponRef ) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_SIDEARM_ACTION(weaponRef); }
    // side arm selection popup menu

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_sidearm_highlighted"
    
    menuDef 
    {
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_secondary", 6, (CHOICE_X( 2 )), (CHOICE_Y( 2 )+8-35), ;, execnow "set "UI_FOCUSFIRST" "REF_DESERTEAGLEGOLD"; set selected_weapon_class pistol; set ui_inside_popup pistol";, 1 )
        onClose{execnow "set ui_inside_popup 0";}
        LOCAL_SIDEARM_INFO_WINDOW
		LOCAL_SIDEARM_ITEM( 1, "1. Gold Desert Eagle", REF_DESERTEAGLEGOLD )
		LOCAL_SIDEARM_ITEM( 2, "2. Desert Eagle", REF_DESERTEAGLE )
		LOCAL_SIDEARM_ITEM( 3, "3. Magnum", REF_COLTANACONDA )
		LOCAL_SIDEARM_ITEM( 4, "4. USP .45", REF_USP )
		LOCAL_SIDEARM_ITEM( 5, "5. M9", REF_M9BERETTA )
		execKey "1" { LOCAL_SIDEARM_ACTION(REF_DESERTEAGLEGOLD); }
		execKey "2" { LOCAL_SIDEARM_ACTION(REF_DESERTEAGLE); }
		execKey "3" { LOCAL_SIDEARM_ACTION(REF_COLTANACONDA); }
		execKey "4" { LOCAL_SIDEARM_ACTION2(REF_USP); }
		execKey "5" { LOCAL_SIDEARM_ACTION2(REF_M9BERETTA); }
    }

    // ====================================================================================================
    // camo skin selection ================================================================================
    // ====================================================================================================
    #define LOCAL_CAMO_INFO_WINDOW \
        /* camo information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT( 9 ) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -4, -2, 280, (CHOICE_POPUP_HEIGHT( 9 )-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0, 0 )\
        /* camo image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 30 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+184) 0 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/camotable.csv",1,dvarString("ui_camo_highlighted"),4), 1 1 1 0.75, 1, 7, 0.2 0.2 0.225 1 ) \
        /* camo title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 58 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/camotable.csv",1,dvarString("ui_camo_highlighted"),2), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE ) \
        /* camo desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 80 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/camotable.csv",1,dvarString("ui_camo_highlighted"),3), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR visible when( 1 ); )\

    #define LOCAL_CAMO_ACTION( camoRef ) \
            play "mouse_click"; \
            setdvar loadout_camo camoRef;\
            scriptMenuResponse "loadout_camo:"camoRef;\
			scriptMenuResponse "go"; \
            PREPROC_ATTACH_CLOSEALL

    #define LOCAL_CAMO_ITEM( itemNum, camoName, camoRef, visArg )\
        CHOICE_HIGHLIGHT( itemNum, visArg ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, camoName, LOCAL_CAMO_ACTION( camoRef );, execnow "set ui_camo_highlighted "camoRef;, ;, visArg )  \
        execKey itemNum { LOCAL_CAMO_ACTION( camoRef ) }

    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_camo_highlighted"
    
    // camo skin selection for primary weapon popup menu
    #define LOCAL_CAMO_GROUP( prefix, onLeave )\
    menuDef \
    {\
		IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_camo"prefix, 9, (CHOICE_X( 1 )), (CHOICE_Y( 1 )+76-35), ;, execnow "set "UI_FOCUSFIRST" none; set ui_inside_popup camo";, 0 )\
        onClose{onLeave;} \
        LOCAL_CAMO_INFO_WINDOW\
        LOCAL_CAMO_ITEM( 1, "1. None", "none", 1 )\
        LOCAL_CAMO_ITEM( 2, "2. Desert", "desert", 1 )\
        LOCAL_CAMO_ITEM( 3, "3. Arctic", "arctic", 1 )\
        LOCAL_CAMO_ITEM( 4, "4. Woodland", "woodland", 1 )\
        LOCAL_CAMO_ITEM( 5, "5. Digital", "digital", 1 )\
        LOCAL_CAMO_ITEM( 6, "6. Urban", "red_urban", 1 )\
        LOCAL_CAMO_ITEM( 7, "7. Blue Tiger", "blue_tiger", 1 )\
        LOCAL_CAMO_ITEM( 8, "8. Red Tiger", "red_tiger", 1 )\
        LOCAL_CAMO_ITEM( 9, "9. Fall", "orange_fall", 1 )\
    }

    // camo skin selection for primary weapon popup menu
    LOCAL_CAMO_GROUP( "", execnow "set ui_inside_popup attachment" )
    // camo skin selection for primary weapon without attachments
    LOCAL_CAMO_GROUP( "2", execnow "set ui_inside_popup 0"; close "ocd_attachment_popup_fake" )
    
    
    // ====================================================================================================
    // special grenade selection ==========================================================================
    // ====================================================================================================
    #define LOCAL_SGRENADE_INFO_WINDOW \
        /* special grenade information side frame*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH-6) -4 280 CHOICE_POPUP_HEIGHT(5) CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "white", CHOICE_POPUP_BORDER_COLOR, 1, 2, CHOICE_POPUP_BORDER_COLOR ) \
        LOADOUT_PLATING_RAW( CHOICE_POPUP_WIDTH 8, -4, -2, 280, (CHOICE_POPUP_HEIGHT(5)-4), CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN visible when( dvarString(ui_inside_popup) != "attachment" );, 0, 0 )\
        /* special grenade image*/ \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+6) 6 256 48 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "gradient_bottom", 1 1 1 0.3, 0, 2, CHOICE_POPUP_BORDER_COLOR visible when( dvarString(ui_inside_popup) != "attachment" ); ) \
        PREPROC_SHADER_DRAW_ALIGNED( (CHOICE_POPUP_WIDTH+178) -6 64 64 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, tablelookup("mp/statsTable.csv",4,dvarString("ui_sgrenade_highlighted"),6), 1 1 1 1, 0, 2, CHOICE_POPUP_BORDER_COLOR ) \
        /* special grenade title*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 34 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sgrenade_highlighted"),3), TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, COLOR_TITLE ) \
        /* special grenade desc unlocked*/\
        PREPROC_TEXT_DRAW_ALIGNED_EXP( (CHOICE_POPUP_WIDTH+10) 56 256 20 CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN, 0 0, "@"+tablelookup("mp/statstable.csv",4,dvarString("ui_sgrenade_highlighted"),7), TEXTSIZE_SMALL, 0, 0, ITEM_ALIGN_MIDDLE_LEFT, CHOICE_TEXTCOLOR ) \

    #define LOCAL_SGRENADE_ACTION( weaponRef ) \
            play "mouse_click"; \
            setdvar loadout_grenade weaponRef; \
            scriptMenuResponse "loadout_grenade:"weaponRef;\
			scriptMenuResponse "go"; \
            close "ocd_popup_cac_extra"
        
    #define LOCAL_SGRENADE_ITEM( itemNum, weaponName, weaponRef )\
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, "", ;, execnow "set ui_sgrenade_highlighted "weaponRef;, ;, when(!dvarBool( "weap_allow_"weaponRef )); ) \
        CHOICE_BUTTON_FOCUS_VIS_NOHI( itemNum, weaponName, LOCAL_SGRENADE_ACTION( weaponRef ), \
        execnow "set ui_sgrenade_highlighted "weaponRef, ;, when(dvarBool("weap_allow_"weaponRef))) \
        CHOICE_DBUTTON_VIS_NOHI( itemNum, weaponName, when(!dvarBool("weap_allow_"weaponRef) ); ) \
        CHOICE_HIGHLIGHT( itemNum, when(dvarBool( "weap_allow_"weaponRef )) ) \
        execKey itemNum { LOCAL_SGRENADE_ACTION( weaponRef ) }
		
    // hackaround to work for PC's floating mouse unfocusing
    #undef  UI_FOCUSFIRST
    #define UI_FOCUSFIRST "ui_sgrenade_highlighted"
    
    // special grenade selection popup menus
    menuDef 
    {
       IMPROVED_POPUP_SETUP_ONOPEN( "ocd_popup_cac_extra", 5, (CHOICE_X( 3 )), (CHOICE_Y( 3 )+10-35), ;, execnow "set "UI_FOCUSFIRST" "REF_FLASH_X1"; set ui_inside_popup sgrenade";, 1 )
        onClose{ execnow "set ui_inside_popup 0"; }
        LOCAL_SGRENADE_INFO_WINDOW
        LOCAL_SGRENADE_ITEM( 1, "1. Flash", REF_FLASH_X1 )
        LOCAL_SGRENADE_ITEM( 2, "2. Smoke", REF_SMOKE_X1 )
    }
#include "ui/safearea_hd.menu"