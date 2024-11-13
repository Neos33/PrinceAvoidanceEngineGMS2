/// @desc

#region Destroy if there is more than 1 instance of the object

if(instance_number(object_index)>1){
    instance_destroy();
    exit;
}

#endregion

#region Initialize everything

comboTimer = 0;
global.BLCcomboDropRate = 1/500;

exAlpha=1.0;

if(!global.ance) image_blend=merge_colour(c_white,c_red,0.5);

hitTimer = 0;


hp_set=global.hp_max;

#endregion

#region Initialize variables for drawing a circle

center_x = 0;
center_y = 0;
radius = 48;
start_angle = 90;   // degrees
    
end_angle_input = 0;   // degrees
end_angle = 0;  // degrees
    
alpha = 0
num_segments = 50;
end_flag = false;

#endregion