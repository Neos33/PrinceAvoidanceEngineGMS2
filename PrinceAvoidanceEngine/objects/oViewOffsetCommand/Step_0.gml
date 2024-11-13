/// @desc
if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	var currentX = StartX + _value * MaxX;
    var currentY = StartY + _value * MaxY;
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	var cam = camera_properties(0);
	
	camera_set_view_pos(cam.view_cam, currentX, currentY);
}
else
	instance_destroy();

