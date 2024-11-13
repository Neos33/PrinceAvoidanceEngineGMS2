/// @desc
if( !instance_exists( TargetId ) || TargetId.Internal_AngleChangeCommand != id ) {
    instance_destroy();
    exit;
}

if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	// Magic
	image_angle = StartAngle + _value * DeltaAngle;
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	TargetId.image_angle = image_angle;
}
else
	instance_destroy();

