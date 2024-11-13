/// @desc Define custom functions

#region S1
function scrImpale(duration,factor)
{
	var _duration;_duration = argument[0];
	var _factor;_factor=4;
	if(argument_count>1) _factor = argument[1];
	with(objAvoidanceBullet){
	    var _bulletID = id;
	    image_angle = direction;
	    direction = point_direction(objPlayer.x,objPlayer.y,x,y);
	    instance_change_angle(id,direction,_duration,tween_sine_out);
	    gravity = 0.6;
	    gravity_direction = direction + 180;
	    speed = 20;
	    instance_change_variable(id,"image_xscale",_factor,_duration,ac_ease, EASE_OUT);
	    instance_change_variable(id,"image_yscale",0.5,_duration,ac_ease, EASE_OUT);
	    instance_change_variable(id,"gravity",2,_duration,ac_expo, EASE_OUT);
	    script_execute_delayed(scrSetKiller,_duration,true);
	}
}

#endregion

#region S

#endregion

#region S

#endregion



