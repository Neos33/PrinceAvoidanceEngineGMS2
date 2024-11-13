/// @description 
if( !instance_exists( TargetId )) {
    instance_destroy();
    exit;
}

if curve_position <= end_position
{
	var _struct = animcurve_get(curve_tween);
	var _channel = animcurve_get_channel(_struct, curve_mode);
	var _value = animcurve_channel_evaluate(_channel, curve_position);


	// Magic
	var blendFactor = StartVar + _value * targetX;
	
	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	// Apply changes to the onwer instance
	variable_instance_set(TargetId, varName, merge_colour(StartVar, targetX, blendFactor));
}
else
	instance_destroy();

