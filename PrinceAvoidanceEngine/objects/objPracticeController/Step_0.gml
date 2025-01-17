/// @desc

#region ASK USER

if menu == PRACTICE_PAGE.ASK_USER
{
	if point_in_rectangle(mouse_x, mouse_y, ask_menu_position_x - ask_thick_x, ask_menu_position_y - ask_thick_y, 
						ask_menu_position_x + ask_thick_x, ask_menu_position_y + ask_thick_y)
	{
		if !ask_menu_hovered
		{
			audio_play_sound(sndJump, 0, false);
			ask_menu_hovered = true;
		}
		
		if mouse_check_button_pressed(mb_left)
		{
			menu = PRACTICE_PAGE.SEGMENTS;	
			audio_play_sound(sndItem, 0, false);
			global.practice_use = true;
		}
	}
	else 
	{
		ask_menu_hovered = false;	
	}
	
	

}

#endregion

#region SEGMENTS

if menu == PRACTICE_PAGE.SEGMENTS
{
	for (var i = 0; i < total_main_segments; i += 1)
	{
	    if point_in_rectangle(mouse_x, mouse_y, segment_x[i], segment_y[i], segment_x[i] + thick_x, segment_y[i] + thick_y)
		{
			// Hover
			if current_segment_selection != i
			{
				audio_play_sound(sndJump, 0, false);	
			}
			current_segment_selection = i;
			
			// Pick
			if mouse_check_button_pressed(mb_left)
			{
				if current_segment_picked != i
				{
					current_segment_picked = i;
					audio_play_sound(sndItem, 0, false);	
				
					// The avoidance will start at the moment you selected
					global.practice_starts = attackTimings[| i];
				}
			}
		}
	}
	
	// Go back
	if mouse_check_button_pressed(mb_right)
	{
		current_segment_picked = -1;
		menu = PRACTICE_PAGE.ASK_USER;	
		
		audio_play_sound(sndDoubleJump, 0, false);	
		
		// Reset/dectivate globals
		global.practice_starts = 0; // Timer
		global.practice_use = false;
	}
	
}

#endregion


// Mouse animation
cursor_alpha = 0.8 + lengthdir_y(0.2, cursor_time);
cursor_time += cursor_time_speed;