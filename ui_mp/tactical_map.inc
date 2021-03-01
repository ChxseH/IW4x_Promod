#ifndef MAP_X
#define MAP_X					(- (MAP_WIDTH - RIGHTITEM_OFFSET + 20 ))
#endif
	
#ifndef MAP_Y
#define MAP_Y					114
#endif
	
#ifndef MAP_WIDTH
#define MAP_WIDTH				240
#endif
	
#ifndef MAP_HEIGHT	
#define MAP_HEIGHT				268
#endif
	
#define ORIGIN_MAP_FRAME		MAP_X MAP_Y
#define MAP_WIDTH2				(MAP_WIDTH+5)

#ifndef TEAM_IS_MARINES
#error "TEAM_IS_MARINES undefined"
#endif

#ifndef TEAM_IS_OPFOR
#error "TEAM_IS_OPFOR undefined"
#endif

#define SHOULD_SHOW_MAP 1

// map display ================================================

#define UI_MAP_NAME		getmapname()
#define MAP_OFFSET		0 21 //2 20

	itemDef
   	{
		name			"mini_map2"
		rect			ORIGIN_MAP_FRAME MAP_WIDTH MAP_WIDTH RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
		origin			MAP_OFFSET
		forecolor		1 1 1 1
		background		"compass_map_default"
		ownerdraw		CG_PLAYER_FULLMAP_MAP
		visible			when ( SHOULD_SHOW_MAP );
		decoration
   	}
   	
	// Objective pointers
	itemDef
	{
		name			"compasspointers2"
		rect			ORIGIN_MAP_FRAME MAP_WIDTH MAP_WIDTH RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
		origin			MAP_OFFSET
		forecolor		1 1 1 1
		background		"objective_line"
		ownerdraw		CG_PLAYER_FULLMAP_POINTERS
		visible			when ( SHOULD_SHOW_MAP );
		decoration
	}
   	// Friendlies pointers
	itemDef
	{
		name			"compassfriendlies2"
		rect			ORIGIN_MAP_FRAME MAP_WIDTH MAP_WIDTH RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
		origin			MAP_OFFSET
		forecolor		1 1 1 1
		background		"compassping_friendly"
		ownerdraw		CG_PLAYER_FULLMAP_FRIENDS
		visible			when ( SHOULD_SHOW_MAP );
		decoration
	}
	// Player direction indicator
	itemDef
	{
		name			"compassplayer2"
		rect			ORIGIN_MAP_FRAME MAP_WIDTH MAP_WIDTH RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP
		origin			MAP_OFFSET
		forecolor		1 1 1 1
		background		"compassping_player"
		ownerdraw		CG_PLAYER_FULLMAP_PLAYER
		visible			when ( SHOULD_SHOW_MAP && team( name ) != "TEAM_FREE" );
		decoration
	}		

	PREPROC_SHADER_DRAW_ALIGNED( ORIGIN_MAP_FRAME (-(MAP_WIDTH)) 20 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 5 0, "white", 0 0 0 0.3, 0, 0, 0 0 0 0 )
	PREPROC_SHADER_DRAW_ALIGNED( ORIGIN_MAP_FRAME (-(MAP_WIDTH)) 20 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 5 0, "gradient_fadein", 0.9 0.95 1 0.4, 0, 0, 0 0 0 0 )
	
	UI_EDGE_REVERSE( ORIGIN_MAP_FRAME, RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 0, 0, 0 0 0 0.3 )
	UI_EDGE_REVERSE( ORIGIN_MAP_FRAME, RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 0, 0, 0.9 0.95 1 0.4 )

	PREPROC_SHADER_DRAW_ALIGNED( ORIGIN_MAP_FRAME (-(MAP_WIDTH2)) 6 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 0 (MAP_HEIGHT-6), "gradient_fadein",0.9 0.95 1 0.35, 0, 0, 0 0 0 0 )
	PREPROC_TEXT_DRAW_ALIGNED_EXP( ORIGIN_MAP_FRAME MAP_WIDTH 0 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, 5 20, UI_MAP_NAME, TEXTSIZE_DEFAULT, 0, 0, ITEM_ALIGN_LEFT, 1 1 1 0.7 )
