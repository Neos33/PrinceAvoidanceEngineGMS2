/// @desc
/// Practice mode is disabled then we destroy the controller
if !global.practice_enabled
{
    initialize = false;
    instance_destroy();
    exit;
}

initialize = true;


/// Room speed
default_room_speed = 50;

/// Attack timings

// Variables taken from the *Sample avoidance*
//BEAT_TIME = 50 / (BPM / 60); //BEAT_TIME = time between beats in frames. Calculated from the BPM

//Add attacks using avoidance_add_attack. "END" should always be last
numTimings = 0;

attackNames = ds_list_create();
attackTimings = ds_list_create();
avoidance_add_attack("ATTACK1", 0);
avoidance_add_attack("ATTACK2", 500);
avoidance_add_attack("ATTACK3", 1000);
avoidance_add_attack("END", 2000);

// -------------------------------------------------------------------- //

/// Position
screen_x = 0;
screen_y = 0;

thick_x = 256;
thick_y = 42;

total_attacks = numTimings;
attackTimingInfoSeconds = array_create(total_attacks);
attackTimingInfoDurationSeconds = array_create(total_attacks);
segment_x = array_create(total_attacks);
segment_y = array_create(total_attacks);

song_length = attackTimings[| total_attacks - 1] / 50; // Converted in seconds

current_segment_selection = -1;
current_segment_picked = -1;

total_main_segments = total_attacks - 1;

separation_y = 64;
if total_attacks > 0
{
    for (var i = 0; i < total_main_segments; i += 1)
    {
        var _next_attack = min(i + 1, total_main_segments); // Do not exceed the ds_list limit
        
        // Info in seconds
        attackTimingInfoSeconds[i] = attackTimings[| i] / default_room_speed;
        attackTimingInfoDurationSeconds[i] = abs(attackTimings[| i] - attackTimings[| _next_attack]) / default_room_speed;
		
		attackTimingInfoPercentage[i] = lerp(0, 100, attackTimings[| i]  / attackTimings[| total_attacks - 1]);
		
		// Position
		segment_x[i] = screen_x + 32;
		segment_y[i] = screen_y + 48 + separation_y * i;
    }
}

enum PRACTICE_PAGE
{
	ASK_USER,
	SEGMENTS,
	OTHER
}

menu = PRACTICE_PAGE.ASK_USER;
// Start from the segment page if we came back from a practice attempt
if global.practice_use 
{
	menu = PRACTICE_PAGE.SEGMENTS;	
}


ask_menu_hovered = false;
ask_menu_position_x = 400;
ask_menu_position_y = 48;

cursor_alpha = 0.8;
cursor_time = 0;
cursor_time_speed = 4;

ask_thick_x = 96;
ask_thick_y = 16;