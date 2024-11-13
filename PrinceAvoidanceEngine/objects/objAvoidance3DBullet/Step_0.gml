/// @desc
event_inherited();
if(z>0){
    imageAlpha=0.5;
}else{
    imageAlpha=1.0;
}
imageAlpha=lerp(0.15,1.0,clamp(rlerp(100,-100,z),0,1))

depth=floor(z);

image_xscale=baseScale*abs(cameraZ)/(z-cameraZ); 
image_yscale=baseScale*abs(cameraZ)/(z-cameraZ); 


image_alpha=baseAlpha*imageAlpha;

//show_debug_message(baseScale);