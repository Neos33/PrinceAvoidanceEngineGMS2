global.can_restart=true;
global.can_f2=true;

global.dotHitbox = false; //NEW in version 1.1 - control whether the player has a dot hitbox for avoidance or not

global.hp_max = 3; //NEW in version 1.1 - the HP value
global.hp = global.hp_max;
global.hp_regen = 0.005; //NEW in version 1.1 - control the regeneration speed of the HP. Negative values drain your HP!
global.hp_display_mode = 1; //NEW in version 1.1 - control the display mode of the HP bar.
//0 = do not display the healthbar
//1 = display the healthbar on hit or drain
//2 = display the healthbar on any HP change
//3 = always display the healthbar

global.iframes = 0;
global.iframes_max = 50;

// Ance mode
global.ance = true;


//create the score and seed controllers

//instance_create_depth(0, 0, 0, objScoreSystemController);
//instance_create_depth(0, 0, 0, objSeedController);


global.hitSoundType = sndBossHit;

global.sfxLoseCombo = sndComboLose; // Added | Check objScoreSystemController 


enum Ranks{
    NONE=0,
    BRONZE=1,
    SILVER=2,
    GOLD=3
}

//Best rank
global.bestRank=Ranks.NONE;

global.rankScore[Ranks.NONE]=0;
global.rankScore[Ranks.BRONZE]=5000;
global.rankScore[Ranks.SILVER]=15000;
global.rankScore[Ranks.GOLD]=30000;


global.rankCombo[Ranks.NONE]=0;
global.rankCombo[Ranks.BRONZE]=0;
global.rankCombo[Ranks.SILVER]=0;
global.rankCombo[Ranks.GOLD]=0;


global.currentRank = Ranks.NONE
global.bestRank = Ranks.NONE


global.bestMaxCombo = 1.0;

//Detect fullcombo in a run
global.fullCombo=0;
global.comboInit=false;
global.bestFullCombo=0;

//happy combo meter

global.BLCscoreVisible=true;
//instance_create_depth(0, 0, 0, objBLCSystemController);


//Anti Avoidance
global.scoreVisible = true; //set whether the score is always visible, or only on the end screen
global.seeded = false; //set whether to seed the fight or not
global.displayDebugTimeline = true; //set whether to display the debug timeline

///Freeze frames
global.freeze_start=ds_list_create();
global.freeze_end=ds_list_create(); 
//All freeze frames are stored as a sequence of intervals 


//blood
//global.seqBlood = scrSeededSeqInit(222,irandom(100));




//global.practiceSegment=1;
//global.practiceOn=0;
//global.avoidance_pb=0;

//global.BLCscoreVisible=false;
global.debugAvoidanceStartTime = 0;

global.noDeath = false;

//Keep track of the custom markings for the avoidance timeline
global.debugSnaps[0]=0;
global.numDebugSnaps=0;


function ance_create_controllers()
{
	instance_create_depth(0, 0, 0, objScoreSystemController);
	instance_create_depth(0, 0, 0, objSeedController);
	
	instance_create_depth(0, 0, 0, objBLCSystemController);
}

function check_player_vulnerable()
{
	return (instance_exists(objPlayer) && (!global.noDeath && !global.debug_god_mode))	
}


function player_got_hit()
{
	if check_player_vulnerable()
	{
	    with (objPlayer)
	    {
	        //instance_create(x, y, objBloodEmitter);
	        repeat(150) 
			{
	            var a = instance_create_layer(x, y, layer, objCustomBullet);
		            //a . sprite_index = sprCustomCherry;
		            a . image_xscale = random_range(0.2,1.5);
		            a . image_yscale = a . image_xscale;
		            a . direction = random(360);
		            a . speed = random_range(0.5,5);
	        }
	        instance_destroy();
	    }
	    instance_create_layer(0, 0, layer, objGameOver);
	}
}

function bullet_kill_ance()
{

	if(ance_killer){
	    switch(Type){
	        case "Hold":
	            player_kill_ance(Score/5,Combo/5);
	            break;
	        case "Decay":
	            if(decay>0.6){
	                player_kill_ance(Score/5,Combo/5);
	                decay-=decaydrop;
	            }
	            break;
	        case "Collect":  
	        default:
	            ance_killer=false;
	            ance_alpha=0.5;
	            player_kill_ance(Score,Combo);                          
	    }
	}
}

function player_kill_ance(opt_amount = 1, opt_comboIncrement = 1, opt_hitSound = sndTakeDamage)
{
	//NEW: The script now adds *opt_amount* score instead of killing the player
	//NEW: *opt_comboIncrement" determines the value to increase the combo by


	if check_player_vulnerable()
	{
	    if(audio_is_playing(opt_hitSound)) audio_stop_sound(opt_hitSound);
	    //global.deathSound = audio_play_sound(opt_hitSound, 0, false);
		audio_play_sound(opt_hitSound, 0, false);
	    with (objPlayer)
	    {
	        //instance_create(x, y, objBloodEmitter);
	        //instance_destroy();
	    }
    
	    //instance_create(0, 0, objGameOver);
    
	    if (global.game_started)
	    {
	        with(objScoreSystemController) {
	            if (comboTimer<1) comboTimer += 1/10;
	        }
	        if(opt_amount>=0){
        
        
            
	            //Multiply the score by the current combo multiplier
	            opt_amount*=global.comboMultiplier;
	            //Increase the combo
	            with(objScoreSystemController){
	                comboTimer=comboTimerMax;
	                global.combo+=opt_comboIncrement;
	                global.comboInit=true; 
	            }
	        }else{
	            //reset the combo if the score amount is negative
	            comboTimer=0;
	            global.combo=0;
	        }
	        //Add the bullet's score to the total amount
	        global.hitScore+=opt_amount;
	    }
	}
}


function endurance_player_kill()
{
	//kills the player

	if check_player_vulnerable()
	{
	    if(global.ance){
	        player_kill_ance();
	        exit;
	    }
	    if(global.iframes) exit;
    
	    //with(objBLCSystemController) hitTimer=1;
	    global.hp--;
	    global.hp = max(global.hp,0);
		
	    if(global.hp>0)
	    {
	        global.iframes = global.iframes_max;
	        audio_play_sound(sndBossHit, 0, false);
			print("Got hit")
	        exit;
	    }
		print("Player is dead?")
	    //global.deathSound = audio_play_sound(sndDeath, 0, false);
		//audio_play_sound(sndDeath, 0, false);
		kill_player();
		/*
	    if (!global.muteMusic)  //play death music
	    {
	        if (global.deathMusicMode == 1) //instantly pause the current music
	        {
	            audio_pause_sound(global.currentMusic);
            
	            global.gameOverMusic = audio_play_sound(musOnDeath, 1, false);
	        }
	        else if (global.deathMusicMode == 2)    //fade out the current music
	        {                
	            with (objWorld)
	                event_user(0);  //fades out and stops the current music
            
	            global.gameOverMusic = audio_play_sound(musOnDeath, 1, false);
	        }
	        else if (global.deathMusicMode == 3)    //fade out the current music, but do not play the game over music
	        {                
	            with (objWorld)
	                event_user(0);  //fades out and stops the current music
            
	            //global.gameOverMusic = audio_play_sound(musOnDeath, 1, false);
	        }
	    }*/
    
	    with (objPlayer)
	    {
	        instance_create_depth(x, y, depth, objBloodEmitter);
	        instance_create_depth(x, y, depth, objPlayerGhost);
	        instance_destroy();
	    }
    
	    //instance_create_depth(0, 0, 0, objGameOver);
    
	    /*if (global.game_started)
	    {
	        savedata_set_persistent("death", savedata_get("death") + 1);
	        savedata_save(false); //save death/time
	    }*/
	}
}

