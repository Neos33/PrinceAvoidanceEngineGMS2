/// @desc
// Calculate radius and angle based on timer and radius
// Then move each cherry to that location
// Code ported from Collect the Pixels
if(frozen) exit;
theta+=dTheta;
phi+=dPhi;
if(!init){
    init=true;
    for (var i=0; i<numBullets; i++) {
        bullets[i] = instance_create_depth(x, y, depth, bulletID)
        //bullets[i].sprite_index = sprite_index
        bullets[i].depth = -5
        bullets[i].image_alpha=0;
        bullets[i].image_speed=0;
    }
}

radius=image_xscale;
for (var i=0; i<numBullets; i++) {
    if(instance_exists(bullets[i])){
        var ct = phase/360+i/numBullets; // individual cherry's time
        var r = radius;
        var a = ct;
        var r2=r/5;
        
        
        var aaa=script_execute(shaper,ct%1,n);
        r = radius*aaa[0];
        a = aaa[1]+angle;
        
        if(morph){
            
            aaa2=script_execute(newShaper,ct%1,newN);
            r=radius*lerp(aaa[0],aaa2[0],morphT);
            a=angle+aaa[1]+morphT*angle_difference(aaa2[1],aaa[1]);
            show_debug_message(morphT);
        }
        // Move bullets
        var baseX=lengthdir_x(r, a);
        var baseY=lengthdir_y(r*dcos(theta), a);
        
        bullets[i].x = x+baseX*dcos(phi)+baseY*dsin(phi); // apply rotation
        bullets[i].y = y+baseX*dsin(phi)-baseY*dcos(phi);
        
        
        bullets[i].z = z+r*dcos(a-90)*dsin(theta)
        bullets[i].baseAlpha=image_alpha;
        bullets[i].killer=killer;
        bullets[i].r = radius;
        bullets[i].baseScale=baseScale;
        
    } 
}
angle += dAngle;
phase += dPhase;