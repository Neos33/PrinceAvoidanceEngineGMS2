/// @desc Destroy the instance if moving away from the screen
var cam = camera_properties(0);
if(destroyOutside &&
(x > 800 + cam.view_x && hspeed > 0 ||
x < cam.view_x && hspeed < 0 ||
y > 608 + cam.view_y && vspeed > 0 ||
y < cam.view_y && vspeed < 0))
    instance_destroy();