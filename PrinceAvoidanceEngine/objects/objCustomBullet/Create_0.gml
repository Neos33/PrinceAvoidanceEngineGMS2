/// @desc
///Variables for default bullet
event_inherited();
image_speed=0;

curve = 0;
accel = 0;
bounce = false;
persist = false;
aimlock=true;

t=0;

tag = 0;
free_variable[0]=0;

parent=noone;


///Variables for basic trigonometric bullet
b_trig=false;  //activates usage of trigonometry

cx=0;     //center's x coordinates
cy=0;     //center's y coordinates
deg_x=1;     //degrease length on x axis
deg_y=-1;    //degrease length on y axis
len=0;       //length
dir=0;       //direction
dir_inc=0;   //increase direction on every frame
len_inc=0;   //increase length on every frame


///Variables for extended version of trigonometric bullet
ext_trig=false;

ccx=0;
ccy=0;
cdeg_x=1;
cdeg_y=-1;
clen=0;
cdir=0;
cdir_inc=0;
clen_inc=0;


///Variables for '2d rotation matrix' bullet
r2d_trig=false
cx = 0;
cy = 0;
r_1 = 0;
r_2 = 0;
dir=0;
ofs=0;

dir_inc=0;
ofs_inc=0;
r1_inc=0;
r2_inc=0;