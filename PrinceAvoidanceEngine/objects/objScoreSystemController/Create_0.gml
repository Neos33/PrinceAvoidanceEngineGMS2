/// @desc
#region Destroy if there is more than 1 instance of the object
if(instance_number(object_index)>1){
    instance_destroy();
    exit;
}

#endregion

#region Initialize everything


combo = 0;
comboTimer = 0;
comboTimerMax = 1;
global.comboDropRate = 1/125;


global.hitScore = 0;
global.bestHitScore=0;
global.comboMultiplier = 1;
global.maxComboMultiplier = 1;
global.combo = 0;
global.maxCombo = 0;
global.freezeCombo=false;
global.freezeComboTimeline=false;

global.unstuckX=400;
global.unstuckY=608-64;


unstuckBoundary=32;


combo_breaked = true;

// Animation
combo_multiplier_offset_x = 0;
combo_multiplier_offset_x_const = 12;
combo_multiplier_color = [c_white, c_red];
combo_multiplier_current_color = 0;
combo_multiplier_factor = 0;
combo_multiplier_count = 0;


//ranks
rankText[0]="";
rankText[1]="BRONZE";
rankText[2]="SILVER";
rankText[3]="GOLD";

#endregion

#region Initialize the particle system for the scorebar

// -------- Particle System --------
// Run this code at the beginning of your game
global.scorebarpsys = part_system_create();
part_system_depth(global.scorebarpsys, -100);
part_system_automatic_draw(global.scorebarpsys,0);

// -------- Particle Type --------
// Run this code at the beginning of your game
global.scorebarptyp = part_type_create();
part_type_shape(global.scorebarptyp, pt_shape_pixel);
part_type_color3(global.scorebarptyp, 15525100, 15260123, 15000812);
part_type_alpha2(global.scorebarptyp, 0.99, 0.2);
part_type_life(global.scorebarptyp, 10, 12);
part_type_size(global.scorebarptyp, 0.5, 3, -0.001, 0);
part_type_speed(global.scorebarptyp, 0.36, 0.61, -0.004, 0);
part_type_direction(global.scorebarptyp, 34.41, 256.53, -0.78, 0);
part_type_orientation(global.scorebarptyp, 348.75, 457.24, 1.07, 0, false);
part_type_gravity(global.scorebarptyp, 0, 270);
part_type_blend(global.scorebarptyp, true);


scorebar_seq=seeded_sequence_init(2000,2);

#endregion

#region initialize the surface for the scorebar


surf=surface_create(800,608);

#endregion