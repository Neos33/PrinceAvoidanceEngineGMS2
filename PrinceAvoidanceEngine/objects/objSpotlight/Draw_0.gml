/// @desc
if(!surface_exists(surf)) surf=surface_create(800,608);

    surface_set_target(surf);

    draw_clear_alpha(c_black,1);

    gpu_set_blendmode(bm_subtract);

    draw_sprite(sprite_index,image_index,x,y);

    with(objAvoidanceBullet){
        draw_sprite_ext(sprSpotlight,0,x,y,sprite_width/200,sprite_height/200,0,c_white,0.8);
    }

    gpu_set_blendmode(bm_normal);

    surface_reset_target();

    draw_surface_ext(surf,0,0,1,1,0,c_white,image_alpha);