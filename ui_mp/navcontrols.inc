	#ifndef BACK_OPEN
	#define BACK_OPEN ;
	#endif	
		itemDef
		{
			name back
			rect -250 9 40 20 2 3
			style 1
			foreColor 1 1 1 1
			type 1
			textAlignY 18
			textScale 0.375
			textStyle 3
			textFont 1
			text "@MENU_BACK"
			visible 1
			mouseEnter
			{
				play mouse_over;
			}
			action
			{
				play mouse_click;
				close self;
			}
		}
		
		itemDef
		{
			rect -120 -32 378 64
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background white
			decoration 
			visible 1
		}
		itemDef
		{
			rect 258 -32 16 -64
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background button_highlight_end
			decoration 
			visible 1
		}
		itemDef
		{
			rect 56 448 528 40
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background white
			decoration 
			visible 1
		}
		itemDef
		{
			rect 584 448 16 64
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background button_highlight_end
			decoration 
			visible 1
		}
		itemDef
		{
			rect 40 448 -16 64
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background button_highlight_end
			decoration 
			visible 1
		}
		itemDef
		{
			rect -120 464 160 32
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background white
			decoration 
			visible 1
		}
		itemDef
		{
			rect 600 464 160 32
			style 3
			foreColor 0.9 0.9 0.95 0.175
			background white
			decoration 
			visible 1
		}