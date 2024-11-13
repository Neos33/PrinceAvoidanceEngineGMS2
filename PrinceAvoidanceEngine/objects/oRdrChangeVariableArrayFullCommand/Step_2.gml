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
	
	var _total = array_length(currVar);
	for(var i = 0; i < _total; i++)
	{
		currVar[@i] = lerp(StartVar[i], TargetVar[i], _value);
	}

	
	
	// Increment
	var _curveSpeed = 1 / duration;
	curve_position += _curveSpeed;
		
		
	
	// Apply changes to the onwer instance
	variable_instance_set(TargetId, varName, currVar);
}
else
	instance_destroy();

