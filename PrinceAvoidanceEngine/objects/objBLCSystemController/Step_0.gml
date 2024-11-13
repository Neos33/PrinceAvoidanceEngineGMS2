/// @desc

#region Increment combo if player touches bullet

if(global.ance){
    if(instance_exists(objScoreSystemController)) comboTimer = objScoreSystemController.comboTimer;
    if(comboTimer>1) { 
        comboTimer=1;
    }
    
    if(comboTimer>0) comboTimer-=global.BLCcomboDropRate;
    else {
        comboTimer = 0;
    }
}else{
    comboTimer=global.hp/global.hp_max;
    hitTimer = lerp(hitTimer,0,0.05);
}

#endregion

#region Handle the healthbar display modes

if(!global.ance){
    switch(global.hp_display_mode){
        case 0:
        {
            hitTimer = 0;
            break;
        }    
        case 1:
        {
            if(hp_set>global.hp){
                hitTimer=1;
            }
            break;
        }
        case 2:
        {
            if(hp_set!=global.hp){
                hitTimer=1;
            }
            break;
        }
        case 3:
        {
            hitTimer=1;
            break;
        }
    
    }
}
hp_set=global.hp;

#endregion

#region Apply easing to the increment/decrement of the bar

end_angle_input = 90+360*comboTimer;
end_angle = lerp(end_angle,end_angle_input,0.2);

#endregion