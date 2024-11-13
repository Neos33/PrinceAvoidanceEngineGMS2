/// @desc

#region ///Increment combo
if(!global.freezeCombo&&!global.freezeComboTimeline){
    if(comboTimer>0) comboTimer-=global.comboDropRate;
    else{
        global.combo = 0;
        comboTimer = 0;
        if(global.comboInit) global.fullCombo=false //break combo/fullcombo
    }
}

global.comboMultiplier = 1 + sqrt(global.combo)/2;
//show_debug_message(global.comboMultiplier);
if(global.combo>global.maxCombo) {
    global.maxCombo = global.combo;
    global.maxComboMultiplier = global.comboMultiplier;
}

#endregion

#region ///Display the scorebar using the particles

if(global.scoreVisible&&instance_exists(objAvoidanceMarker)){
    repeat(floor(20*comboTimer)){
        partX = room_width - 32 - random_seeded(128*comboTimer,scorebar_seq);
        partY = room_height - 16 + random_seeded_range(-12,12,scorebar_seq);
        part_particles_create(global.scorebarpsys, partX , partY, global.scorebarptyp, 1);
    }
}

#endregion

#region ///Ranks
var _oldRank=global.currentRank;
for(var i=0;i<4;i++){
    if(global.hitScore>global.rankScore[i]) global.currentRank=i;
}
if(global.currentRank>_oldRank&&instance_exists(objPlayer)){
    with(instance_create_depth(objPlayer.x,objPlayer.y,objPlayer.depth, objTextbox)){
    
        image_xscale=0.75;
        image_yscale=0.75;
        font=fScore;
        instance_fade_out(id,100);
        instance_move_to(id,x,y-64,100,ac_linear, 0);
        str=other.rankText[global.currentRank]+ " RANK ACHIEVED! !";
    }
}