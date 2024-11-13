/// @desc
if( !instance_exists( TargetId )) {
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


	if curve_position >= end_position
	{
	    with(TargetId){
        morphT = 1.0;
        morph=false;
        shaper=newShaper;
        n=newN;
    }   
    instance_destroy();
    exit;
	}

	TargetId.morphT=_value;
}
