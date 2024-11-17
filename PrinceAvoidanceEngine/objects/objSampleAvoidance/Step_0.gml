/// @desc Core
#region Increment timer, sync to music
if(!instance_exists(objAvoidanceMarker)){
     instance_destroy();
     exit;
}
t++;
t_music=t;
//Anti-desync taken from Shift Engine.

if(t > 0 and audio_is_playing(global.current_music)){
    var music_t = audio_sound_get_track_position(global.current_music) * 50;
    if(abs(t_music - music_t) > 5){
        audio_sound_set_track_position(global.current_music,t_music / 50);
    }
}
if(attack<numTimings-1){
    if(t>attackTimings[| attack+1]){
        attack++;
    }
}


#endregion

#region Debug timeline and keys

if(global.debug_enable){
    function avoidance_jump_to_timing(timing, opt_cleanup = true)
	{
		/*
		    * Sets the avoidance timer to a value specified by **timing**.
		    * If **opt_cleanup** is set to true, also cleans up all of the avoidance entities such as bullets.
		    * 
		    * @param {int} timing - The timing to jump to.
		    * @param {boolean} opt_cleanup - Whether to clean up the avoidance entities.
		    * 
		*/

		audio_sound_set_track_position(global.current_music, timing / 50);
		t = floor(timing);
		var full_list = ds_list_size(attackTimings) - 1; // We skip the last state which is just room_goto and clean up
		for (var i = 0; i < full_list; i++)
		{
		    if (timing * 50 > attackTimings[|i])
			{
		        attack = i;
		        break;       
		    }
		}
		if (opt_cleanup)
		{
		    with (objAvoidanceEntity) 
			{
		        if (!child)
					instance_destroy();
		    }
		}
	}
	
	if(keyboard_check_pressed(vk_space)){ //Set a debug snap on SPACE
        global.debugSnaps[global.numDebugSnaps]=t;
        global.numDebugSnaps++;
        show_debug_message(string(t));
    }
    if(point_in_rectangle(mouse_x,mouse_y,32,0,room_width-32,64)&&mouse_check_button_pressed(mb_left)&&!keyboard_check(vk_control)){ //Navigate the timeline by clicking on it
        var trackPos=lerp(startTiming,endTiming,(mouse_x-32)/(room_width-64))
        avoidance_jump_to_timing(trackPos);
    }
    
    //Jump to a debug snap by clicking on it
    var spacing = 32;
    for(var i=0;i<global.numDebugSnaps;++i){
        var snapX=room_width-64;
        var snapY=64+spacing*(i+1)
        if(point_in_rectangle(mouse_x,mouse_y,snapX,snapY,snapX+64,snapY+spacing)){
            highlight=i;
            if(mouse_check_button_pressed(mb_left)){
                var trackPos = global.debugSnaps[i];
                avoidance_jump_to_timing(trackPos);
            }
        }
    }
    //User made debug keys
    for(var i=0;i<numDebugKeys;i++){
        if(keyboard_check_pressed(debugKeys[|i])){
            var trackPos = debugKeyTimings[|i];
            avoidance_jump_to_timing(trackPos);
            with(objPlayer){
                if(other.debugKeyStartX[|i]!=-1) x = other.debugKeyStartX[|i];
                if(other.debugKeyStartY[|i]!=-1) y = other.debugKeyStartY[|i];
            }
        }
    }
    
    //Ance Mode - highlight moments on the timeline to freeze using CTRL+Mouse Drag
    if(point_in_rectangle(mouse_x,mouse_y,32,0,room_width-32,64)&&mouse_check_button_pressed(mb_left)&&keyboard_check(vk_control)){
        ///When clicking on an existing interval, move its start or end point depending on which one is closest to the cursor
        var trackPos=lerp(startTiming,endTiming,(mouse_x-32)/(room_width-64));
        var _existing_interval_selected = false;
        for(var i=0;i<ds_list_size(global.freeze_start);i++){
            if(trackPos>global.freeze_start[|i]&&trackPos<global.freeze_end[|i]){
                _existing_interval_selected = true;
                debug_timeline_entry_selected = i;
                if(abs(trackPos-global.freeze_start[|i])<abs(trackPos-global.freeze_end[|i])){
                    debug_timeline_entry_point_move = 0; //Move the start point
                }else{
                    debug_timeline_entry_point_move = 1; //Move the end point
                }
                break;
            }
        }
        
    
        ///When clicking on an empty interval, create a new freeze interval
        if(!_existing_interval_selected){
            var trackPos=lerp(startTiming,endTiming,(mouse_x-32)/(room_width-64))
            ds_list_add(global.freeze_start,trackPos);
            ds_list_add(global.freeze_end,trackPos+1);
            
            debug_timeline_entry_selected = ds_list_size(global.freeze_start)-1; //move the new entry
            debug_timeline_entry_point_move = 1 //move the end point 
        }
        debug_timeline_clicked=true;
    }
    if(debug_timeline_clicked){
        var trackPos=lerp(startTiming,endTiming,(mouse_x-32)/(room_width-64))
        if(debug_timeline_entry_point_move){
            global.freeze_end[|debug_timeline_entry_selected]=trackPos;
        }
        else{
            global.freeze_start[|debug_timeline_entry_selected]=trackPos;
        }
    }
    if(mouse_check_button_released(mb_left)){
        debug_timeline_clicked=false;
    }

    
    // Fast forward
    if keyboard_check(vk_control)
    {
        game_set_speed(1000, gamespeed_fps);
    }
    else if keyboard_check_released(vk_control)
    {
        game_set_speed(50, gamespeed_fps);
    }
}

#endregion

#region Attacks

var ct=t-attackTimings[|attack];
var gt=t;
var BT=BEAT_TIME;

if(!instance_exists(objPlayer)) exit;

switch(attackNames[|attack]){ //Main attack loop
    case "ATTACK1":
    {   
		if(on_beat(ct,BT)){ // An example of a simple attack that spawns a flower every beat
           spawn_shape(400,304, random(360),6,20,6,objAvoidanceBullet,"flower",shaper_flower);
        }
        if(ct==1) rngController = rng_controller_create(4);
        else if(ct>1&&ct mod 5 == 0){ 
        
            //An example of an RNG-controlled barrage attack
            var bullet = instance_create_ext(400,304,0,objAvoidanceBullet,random_range(4,6),random_range_controlled(0,360,rngController),1,"test");
            bullet.sprite_index = sprBulletRazzor;
            bullet.image_index = 13*rngController.bin;
        }
        
        if(ct==1){
        
            //view_rotate(180,200,tween_sine_inout);
            for(var i=0;i<8;i++){ //An example of using a tracer to create a flower pattern
                var bullet = instance_create_ext(400,304,0,objAvoidanceBullet,3,360*i/8,1,"test");
                bullet.tag = "curve";
                bullet.sprite_index = sprBulletArrowhead;
                
                bullet.image_angle = bullet.direction;
                tracer_attach(bullet,objAvoidanceBullet,300,16,"tail");
                instance_shrink_out(bullet,300);
            }
            
            //An example of applying multiple shader effects
            
            var godRaysShader=shader_push(shGodRays,0.0);
            var hueShiftShader=shader_push(shHueShift,0);
            //var twirlShader=shader_push(shTwirl,0);
            
            //We can change the shader parameters using instance manipulation functions
            instance_change_variable(godRaysShader,"intensity",0.5,100,ac_ease, EASE_INOUT);
            instance_change_variable(hueShiftShader,"intensity",2*360.0,1000,ac_linear, EASE_IN);
            //instance_change_variable(twirlShader,"intensity",1,1000,tween_linear);
        }
        with(objAvoidanceBullet){
            if(tag=="curve"){
                direction+=0.04*(ct-50);
                image_index+=0.1;    
                image_angle=direction;
            }
        }
        break;
    }
    
    case "ATTACK2":
    {
        if(ct==1){
            visual_flash();
            //Remove a shader from the stack - in this case the latest applied (hue shift) shader is removec
            
            shader_pop();
            
            var ca = random(360);
            spawn_shape(400,304,ca,6,30,6,objAvoidanceBullet,0,shaper_spiral); //an example of using spawn_shape with custom shapes
            spawn_shape(400,304,ca+180,6,30,6,objAvoidanceBullet,0,shaper_spiral);
            
        }
        break;
    }
    case "ATTACK3":
    {
        if(ct==1){ //An example of creating a 3D circle that morphs into a heart over time
        
            var heart = spawn_3D_shape(400,304,sprBulletRazzor,32,0,0,0.5,40,0,shaper_circle,5);
            heart.dPhase=0.0;
            heart.z=-100;
            heart.killer=true;
            heart.dTheta=0.25;
            instance_scale(heart,200,400,ac_linear,0);
            instance_morph(heart,shaper_heart,5,400,ac_ease, EASE_INOUT);
        }
        break;
    }
    
    case "END":
    {
        if(ct==1){
        
            if (bossItem != -1) global.items.bosses[bossItem] = true;
            if (secretItem != -1) global.items.secrets[secretItem] = true;
            if(autoWarp){
                with(objPlayer) instance_destroy();
                room_goto(roomTo);
            }
        }
        break;
    }
    default:
    {
        show_debug_message("WARNING: Attack "+attackNames[|attack]+" is empty!");
        break;
    }
}



#endregion

#region Extra conditions
if infinite_jump
	reset_jumps();
	
global.iframes = max(global.iframes - 1, 0);
#endregion