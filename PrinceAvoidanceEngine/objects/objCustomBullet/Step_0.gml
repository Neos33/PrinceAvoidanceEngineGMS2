/// @desc
///Basic bullet things (acceleration, curve, bounce)
direction += curve;
speed += accel;
if (bounce == true) {
    move_bounce_solid(false);
}

t++;


///Basic trigonometric bullet things (spins around some point)

dir+=dir_inc;
len+=len_inc;

if (b_trig) {
    
    x=cx+len*cos(degtorad(dir))/deg_x;
    y=cy+len*sin(degtorad(dir))/deg_y;
}


///Extended trigonometric bullet things (spins the center)
    cdir+=cdir_inc;
    clen+=clen_inc;
if (ext_trig) {
    b_trig=true;
    
    cx=ccx+clen*cos(degtorad(cdir))/cdeg_x;
    cy=ccy+clen*sin(degtorad(cdir))/cdeg_y;
}


///'2d rotation matrix' bullet things
    ofs+=ofs_inc;
    r_1+=r1_inc;
    r_2+=r2_inc;
if (r2d_trig) {
    //dir+=dir_inc;
    
    x = cx + r_1 * dcos(dir) * dcos(ofs) - r_2 * dsin(dir) * dsin(ofs)
    y = cy + r_2 * dsin(dir) * dcos(ofs) + r_1 * dcos(dir) * dsin(ofs)
}