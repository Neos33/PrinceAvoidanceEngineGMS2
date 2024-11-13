/// @desc
var cam = camera_properties(0);
if curve_position < end_position
{	
	
	var set_xview = viewXStart + random_range(-amplitude, amplitude);
	var set_yview = viewYStart + random_range(-amplitude, amplitude);
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	camera_set_view_pos(cam.view_cam, set_xview, set_yview);
}
else
{
	camera_set_view_pos(cam.view_cam, viewXStart, viewYStart);
	instance_destroy();
}

