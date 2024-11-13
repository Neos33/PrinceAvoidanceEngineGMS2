/// @desc
event_inherited();
numBullets = 1 //Number of bullets in the circle
dAngle = 1 //Time increment, where 1t = 1 cycle. In the default case, one cycle is 200 frames. (4 seconds)

motion = 1 //Motion setting: 1 = normal circle, 2 = loop back to center, 3 = complex circle, 4 = swaying circle
radius = 0; //Maximum distance of the bullets from the center

angle = 0

init=false;
circleID=0;
lineBullets=0;
initBulletAngle=-90;
bulletID=objAvoidance3DBullet;

phi=180//random(360);
dPhi=0;
theta=0;
dTheta=0;

frozen=false;
slowdown=false;

killer=false;
image_alpha=1.0;

baseScale=1.0;

z=0;




///Shape descriptor

shaper = shaper_circle;
n=6;



phase=0;
dPhase=0;


///Morphing
newShaper = shaper;
newN = n;
morph = false;
morphInst = noone;
morphT = 0; //normalized T from 0 to 1
