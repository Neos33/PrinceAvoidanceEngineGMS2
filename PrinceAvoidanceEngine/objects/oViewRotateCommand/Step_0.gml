/// @desc
if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	var set_angle = StartAngle + _value * DeltaAngle;
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	var cam = camera_properties(0);
	camera_set_view_angle(cam.view_cam, set_angle);

}
else
	instance_destroy();

