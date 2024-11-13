/// @desc
///Draw all bullets with additive blending

if(additive) gpu_set_blendmode(bm_add);

with(objAvoidanceBullet){
    if(!scaleTag) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*ance_alpha);
    else draw_sprite_ext(sprite_index,image_index,x,y,exScale,exScale,image_angle,image_blend,image_alpha*ance_alpha);
}
with(objAvoidance3DBullet){
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*ance_alpha);
}
with(objAvoidanceCosmetic) draw_self();

gpu_set_blendmode(bm_normal);

