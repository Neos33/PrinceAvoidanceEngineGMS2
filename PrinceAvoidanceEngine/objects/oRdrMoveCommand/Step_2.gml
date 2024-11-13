/// @description 
if( !instance_exists( TargetId ) || TargetId.Internal_MoveCommand != id ) {
    instance_destroy();
    exit;
}

if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	TargetId.x = xstart + _value * DeltaX;
	TargetId.y = ystart + _value * DeltaY;
}
else
	instance_destroy();

