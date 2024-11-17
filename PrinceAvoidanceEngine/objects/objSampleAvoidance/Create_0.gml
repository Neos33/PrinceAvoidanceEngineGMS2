/// @desc
#region Music and BPM
musicID=bgmGameOver //Music used

//Uncomment the following code if the music is loaded externally. 
//In this example, the file would be named "Music\Avoidance.ogg"
//musicID = scrLoadMusic("Avoidance"); 


//Set the BPM of the song. Use Audacity or similar to detect it.
BPM = 120
#endregion

#region Attack timings

BEAT_TIME=50/(BPM/60); //BEAT_TIME = time between beats in frames. Calculated from the BPM

//Add attacks using avoidance_add_attack. "END" should always be last
numTimings=0;

attackNames=ds_list_create();
attackTimings=ds_list_create();


function avoidance_add_attack(name, time)
{
	/**
	    * Adds a timing for an avoidance attack named ``name`` that starts at time ``time``.
	    * @param {string} name - The name of the attack.
	    * @param {integer} time - The time at which the attack starts, in frames.
	*/

	ds_list_add(attackNames, name);
	ds_list_add(attackTimings, time);
	numTimings++;
}

avoidance_add_attack("ATTACK1",0);
avoidance_add_attack("ATTACK2",500);
avoidance_add_attack("ATTACK3",1000);
avoidance_add_attack("END",2000);



#endregion

#region Debug keys

numDebugKeys = 0;
debugKeys = ds_list_create();
debugKeyTimings = ds_list_create();
debugKeyStartX = ds_list_create();
debugKeyStartY = ds_list_create();


/**
	* Create a debug timing for the avoidance that makes it so that when a key is pressed, the player is automatically brought to a certain position in the avoidance.
	* 
	* @param {keyIndex} key - The key to use.
	* @param {int} timing - The timing to warp the player to.
	* @param {float} opt_startX - The X position to teleport the player to. Default is -1 (don't move the player)
	* @param {float} opt_startY - The Y position to teleport the player to. Default is -1 (don't move the player)
*/
function avoidance_add_debug_key(key, timing, opt_startX = 1, opt_startY = 1)
{


	ds_list_add(debugKeys, key);
	ds_list_add(debugKeyTimings, timing);
	ds_list_add(debugKeyStartX, opt_startX);
	ds_list_add(debugKeyStartY, opt_startY);

	numDebugKeys++;
}

//Add debug keys here using avoidance_add_debug_key
avoidance_add_debug_key(ord("1"), 500);




#endregion

#region Internal variables and start the avoidance

attack=0;


t=0;
t_music=0;
finish=false;
RealStep=0;
debug_timeline_clicked = false;
debug_timeline_entry_point_move = 0;
debug_timeline_entry_selected = 0;

startTiming=0;
endTiming=attackTimings[|numTimings-1];//floor(audio_sound_length(musicID)*50);

if(instance_number(object_index)>1) {
    
    instance_destroy();
    exit;
}

play_music(musicID,false);


//Reset infjump, nodeath and player gravity to avoid replay/restart bugs
global.noDeath=false; 
infinite_jump=false; 
global.grav=1;

global.iframes = 0; // HP mode

highlight=-1;
#endregion

#region Set up end room and boss item


autoWarp = true;

roomTo = rSampleRoom; //set the room to go to at the end of the avoidance. Disabled if autoWarp is set to false;
bossItem = -1; //set the boss item to award the player. Default is -1 => do not award any boss item
secretItem = -1; //set the secret item to award the player. Default is -1 => do not award any secret item

#endregion

// Custom functions
event_user(0);
