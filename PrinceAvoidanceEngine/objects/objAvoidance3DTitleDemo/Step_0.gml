/// @desc
t++;

if(t%300==0){
    with(objAvoidance3DShape){
        instance_morph(id,choose(shaper_circle,shaper_flower,shaper_star,shaper_shape,shaper_sawblade),5,100,ac_ease)
    }
}

with(objTextbox) image_alpha=0.8+0.2*dsin(other.t*2.2);