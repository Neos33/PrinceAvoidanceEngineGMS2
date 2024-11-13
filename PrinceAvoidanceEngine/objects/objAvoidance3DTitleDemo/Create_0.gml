/// @desc
t=0;

_obj =spawn_3D_shape(400,304,sprBulletRazzor,irandom(sprite_get_number(sprBulletRazzor)-1),300,random(360),1,40,"intro",shaper_shape,5);
_obj.dTheta=choose(-1,1);

instance_create_depth(400,304,0,objTextbox);