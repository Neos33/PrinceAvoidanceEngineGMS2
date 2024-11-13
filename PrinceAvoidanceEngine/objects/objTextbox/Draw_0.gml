/// @desc
draw_set_colour(image_blend);
draw_set_alpha(image_alpha);
draw_set_font(font);
if(additive) gpu_set_blendmode(bm_add);
draw_set_align(halign,valign);
draw_text_transformed_colour(x,y,text,image_xscale,image_yscale,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha);


draw_set_colour(c_white);
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_font(fntMenu3);