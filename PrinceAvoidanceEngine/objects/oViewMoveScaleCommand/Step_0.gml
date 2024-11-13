/// @desc
if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	var currentX = StartX + _value * DeltaX;
    var currentY = StartY + _value * DeltaY;
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	var cam = camera_properties(0);
	
	var set_wview = StartScale + _value * MaxScale;
	var set_hview = set_wview * 608 / 800;

	var set_xview = currentX + (StartScale - set_wview) / 2;
	var set_yview = currentY + 608 / 800 * (StartScale - set_wview) / 2;
	
	camera_set_view_size(cam.view_cam, set_wview, set_hview);
	camera_set_view_pos(cam.view_cam, set_xview, set_yview);
}
else
	instance_destroy();

