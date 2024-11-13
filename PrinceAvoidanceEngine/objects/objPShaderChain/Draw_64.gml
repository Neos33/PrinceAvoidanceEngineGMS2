/// @desc

for(var i=0;i<numShaders;i++){
    if(!instance_exists(chain[i])) exit;
    
    var currSurf=surf1;
    var targetSurf=surf2;
    
    if(i%2==0){
        currSurf=surf2;
        targetSurf=surf1;
    }
    if(!surface_exists(surf1)){
        surf1=surface_create(800,608);
    }
    if(!surface_exists(surf2)){
        surf2=surface_create(800,608);
    }
    
    if(i==0) surface_copy(currSurf,0,0,application_surface);
    
    surface_set_target(targetSurf); 
    draw_clear_alpha(c_black,0);

    var shaderTimerHandle=shader_get_uniform(chain[i].shader,"time");
    var shaderIntensityHandle=shader_get_uniform(chain[i].shader,"intensity");
    shader_set(chain[i].shader);
    shader_set_uniform_f(shaderTimerHandle,t/50);
    shader_set_uniform_f(shaderIntensityHandle,chain[i].intensity);
    
    draw_surface(currSurf,0,0);
    
    shader_reset();
    gpu_set_blendmode(bm_add);
    draw_set_colour(c_black);
    draw_rectangle(0,0,800,608,0);
    draw_set_colour(c_white);
    gpu_set_blendmode(bm_normal);
    

    surface_reset_target();
    if(i==numShaders-1) draw_surface(targetSurf,0,0);
}

