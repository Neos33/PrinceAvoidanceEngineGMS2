/// @desc
#region Draw segments info 

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if menu == PRACTICE_PAGE.ASK_USER
{
	// Draw box
	var _color_box = c_black;
	var _color_box_outline = c_white;
	
	var _color_text = c_white;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	if ask_menu_hovered
	{
		_color_box = c_gray;
		_color_box_outline = c_black;
		_color_text = c_black;	
	}
	
	// Draw box
	draw_sprite_ext(spr1x1, 0, ask_menu_position_x - ask_thick_x, ask_menu_position_y - ask_thick_y, ask_thick_x * 2, ask_thick_y * 2, 0, _color_box, 1);
	
	draw_set_color(_color_box_outline);
	draw_rectangle(ask_menu_position_x - ask_thick_x, ask_menu_position_y - ask_thick_y, ask_menu_position_x + ask_thick_x - 1, ask_menu_position_y + ask_thick_y - 1, true);
	
	
	draw_set_color(_color_text);	
	draw_text(ask_menu_position_x, ask_menu_position_y, "Use practice mode");
	
	// Draw cursor
	draw_sprite_ext(sprCursor, 0, 400, 96, 1, 1, 0, c_white, cursor_alpha);
}


draw_set_halign(fa_left);
var _color_box = c_black;
var _color_box_outline = c_white;
if menu == PRACTICE_PAGE.SEGMENTS
{
	for (var i = 0; i < total_main_segments; i += 1)
	{

	
		if current_segment_picked == i
		{
			draw_set_color(c_black);
			_color_box = merge_color(c_yellow, c_white, 0.4);
			_color_box_outline = c_black;
		}
		else if current_segment_selection == i
		{
			draw_set_color(c_white);
			_color_box = c_gray;
			_color_box_outline = c_black;
		}
		else
		{
			draw_set_color(c_white);	
			_color_box = c_black;
			_color_box_outline = c_white;
		}
		
		draw_sprite_ext(spr1x1, 0, segment_x[i], segment_y[i], thick_x, thick_y, 0, _color_box, 0.8);
		draw_set_color(_color_box_outline);
		draw_rectangle(segment_x[i], segment_y[i], segment_x[i] + thick_x - 1, segment_y[i] + thick_y - 1, true)
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(segment_x[i] + thick_x / 2, segment_y[i] + thick_y / 2, string(i+1) + ". " + attackNames[| i]);
    
	    //var _formatted_time = string(floor(attackTimingInfoSeconds[i]/60)) + ":" + string(floor(attackTimingInfoSeconds[i] mod 60));
	    //draw_text(segment_x[i] + 128, segment_y[i], _formatted_time);
    
	    //var _formatted_time_duration = string(floor(attackTimingInfoDurationSeconds[i]/60)) + ":" + string(floor(attackTimingInfoDurationSeconds[i] mod 60));
	    //draw_text(segment_x[i] + 256, segment_y[i], _formatted_time_duration);
    
	
		//draw_sprite_ext(spr1x1, 0, segment_x[i], segment_y[i], thick_x, thick_y, 0, c_yellow, 0.4);
	}

	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if current_segment_picked != -1
	{
		// Draw thumbnail
		draw_sprite_ext(sprPracticeSegmentPreview, current_segment_picked, 592, 176, 1, 1, 0, c_white, 1);
		draw_sprite_ext(sprPracticeSegmentPreviewFrame, current_segment_picked, 592, 176, 1, 1, 0, c_white, 1);
		
		// Draw timer start + percentage of the song
		var _formatted_time = string(floor(attackTimingInfoSeconds[current_segment_picked]/60)) + ":" + string(floor(attackTimingInfoSeconds[current_segment_picked] mod 60));
		draw_text(screen_x + 800 - 256, screen_y + 304, "Starts at: " + _formatted_time + " | " + string(attackTimingInfoPercentage[current_segment_picked]) + "%");
	
		// Draw duration of the segment
		var _formatted_time_duration = string(floor(attackTimingInfoDurationSeconds[current_segment_picked]/60)) + ":" + string(floor(attackTimingInfoDurationSeconds[current_segment_picked] mod 60));
		draw_text(screen_x + 800 - 256, screen_y + 304 + 16, "Duration: " + _formatted_time_duration);
	}
	
	var _formatted_time_song_length = string(floor(song_length/60)) + ":" + string(floor(song_length mod 60));
	draw_text(screen_x + 800 - 256, screen_y + 304 + 48, "Song length: " + _formatted_time_song_length);
	
	// Draw cursor
	draw_sprite_ext(sprCursor, 0, 400, 96, 1, 1, 0, c_white, cursor_alpha);

	// Go back
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text(screen_x + 800 - 32, screen_y + 608 - 32, "*Right click* to exit.")
}
#endregion

// Reset values
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);