/// @desc Debug timeline

if(global.debug_enable)
{
	var screen_width = 800;
	
    // Bar background
	draw_sprite_ext(spr1x1, 0, 32, 32, screen_width - 64, 16, 0, c_black, 1);
	
	// Progress bar
	var barPosition = lerp(32, screen_width - 32, (t - startTiming) / (endTiming - startTiming));

	draw_sprite_ext(spr2x2, 0, barPosition, 32 + 8, 1, 20, 0, c_aqua, 1);
	
	//Display attack timings - marks
    for(var i = 0; i < numTimings; ++i)
	{ 
        var markPosition = lerp(32, screen_width - 32, (attackTimings[|i] - startTiming) / (endTiming - startTiming));
		draw_sprite_ext(spr2x2, 0, markPosition, 32 + 8, 1, 16, 0, c_white, 0.7);
    }
	
    draw_set_font(fntMenu3);
    draw_set_colour(c_white);
	draw_set_halign(fa_right);
    draw_text_outline_transformed(screen_width - 32, 304 - 20, $"Frames: {t}", c_black, 1, 1, 0);
	var zero_digit = (t / 50 < 10) ? "0" : "";
	var time_formatted = $"Time: {floor(t / 50 / 60)}:{zero_digit}{floor(t / 50 mod 60)}";
	draw_text_outline_transformed(screen_width - 32, 304, time_formatted, c_black, 1, 1, 0);

	
	// Hightlights marks
	draw_set_color(c_yellow);
	draw_set_halign(fa_left);
    var spacing = 20;
    for (var i = 0; i < global.numDebugSnaps; ++i)
	{
        draw_set_color(c_white);
		if (highlight == i) draw_set_color(c_yellow);
        draw_text(32, 304 + spacing * (i + 1), global.debugSnaps[i]);
		
        var markPosition = lerp(32, screen_width - 32, (global.debugSnaps[i] - startTiming) / (endTiming - startTiming));
		draw_sprite_ext(spr2x2, 0, markPosition, 32 + 8, 1, 12, 0, c_yellow, 0.7);

    }
    highlight = -1;
    
    
    // Debug display attacks names 
	draw_set_color(c_white);
    draw_set_halign(fa_right);
    
        var _total_names = ds_list_size(attackNames);
        for (var i = 0; i < _total_names; i += 1)
        {
            var _color_current_attack = (attack == i) ? c_red : c_white;
			draw_set_color(_color_current_attack);
            draw_text_outline_transformed(800 - 32, 64 + i * 16, attackNames[| i], c_black, 1, 1, 0);
        }
    
    // Reset values
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}
