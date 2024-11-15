/// @desc
///Draw the score counter widget 
if(global.ance&&global.scoreVisible&&instance_exists(objAvoidanceMarker)){
    draw_set_font(fScore);
    draw_set_align(fa_right,fa_bottom);
    
	draw_set_color(combo_multiplier_current_color);
    draw_text_outline(800-32+combo_multiplier_offset_x,608-64,"x"+string(global.comboMultiplier),c_black);
	
	draw_set_colour(c_white);
    
    draw_text_outline(800-32,608-32,string(floor(global.hitScore)),c_black);
    //draw_text_outline(800-32,608-64,"x"+string(global.comboMultiplier),c_black);
    
    //if(global.freezeCombo){
        //draw_set_align(1,0);
        //draw_text(room_width-32-128-8,room_height-16,"FREEZE");
    //}
    
    if(global.debug_enable){
        draw_set_align(fa_left,fa_bottom);
        draw_text_outline(32,608-32,"FC: "+string(global.fullCombo),c_black);
        draw_text_outline(32,608-64,"RANK: "+rankText[global.currentRank],c_black);
    }
    draw_set_font(fntMenu3);
    draw_set_align(fa_right,fa_bottom);
    
    
    ///draw the particles using a surface

    if(!surface_exists(surf)) surf=surface_create(800,608);
    
    
    surface_set_target(surf);
    draw_clear_alpha(0,0);
    
    
    part_system_drawit(global.scorebarpsys);
    
    surface_reset_target();
    gpu_set_blendmode(bm_add);
    
    
    draw_surface(surf,0,0);
    gpu_set_blendmode(bm_normal);

}
draw_set_align();