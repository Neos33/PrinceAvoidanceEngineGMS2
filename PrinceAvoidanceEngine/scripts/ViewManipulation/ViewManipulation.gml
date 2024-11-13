/**
	* Simultaneously moves and scales the default view by the specified amount. The movement is relative to the current position of the view.
	* 
	* @param {float} targetX - the X value to move to the view by.
	* @param {float} targetY - the Y value to move to the view by.
	* @param {float} targetScale - the value to set the scale of the view to, where 1 corresponds to the default size of the view.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} easingFunc - The easing function to use. The default is tween_sine_inout.
	* 
*/
function view_move_scale( targetX, targetY, targetScale, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{
	
	var cam = camera_properties(0);

	var command = instance_create_depth( 0, 0, depth, oViewMoveScaleCommand );

		command.StartX = cam.view_x;
		command.StartY = cam.view_y;
		command.DeltaX = targetX-command.StartX;
		command.DeltaY = targetY-command.StartY;
		command.StartScale = cam.view_w;
		command.MaxScale = targetScale - command.StartScale;
		command.curve_position = 0;
		command.end_position = 1;
		command.duration = duration;
		command.curve_tween = easingFunc;
		command.curve_mode = easeMode;
}

/**
	* Moves the default view by a specified amount over time. The movement is relative to the initial position of the view when the script is called.
	* 
	* @param {float} targetX - the X value to move to the view by.
	* @param {float} targetY - the Y value to move to the view by.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} easingFunc - The easing function to use. The default is tween_sine_inout.
	* 
*/
function view_offset( targetX, targetY, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{

	var cam = camera_properties(0);

	var command = instance_create_depth(0, 0, 0, oViewOffsetCommand );
		command.StartX = cam.view_x;
		command.StartY = cam.view_y;
		command.MaxX = targetX - command.StartX;
		command.MaxY = targetY - command.StartY;
		command.curve_position = 0;
		command.end_position = 1;
		command.duration = duration;
		command.curve_tween = easingFunc;
		command.curve_mode = easeMode;
}

/**
	* Sets the scale of the default view to the specified amount, over time. This is useful for "zoom in/out"-style effects.
	* 
	* @param {float} targetScale - the value to set the scale of the view to, where 1 corresponds to the default size of the view.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} easingFunc - The easing function to use. The default is tween_sine_inout.
	*
*/
function view_scale( targetScale, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{

	var cam = camera_properties(0);

	var command = instance_create_depth(0, 0, 0,oViewScaleCommand );

		command.StartX = cam.view_x;
		command.StartY = cam.view_y;
		command.StartScale = cam.view_w;
		command.MaxScale = targetScale - command.StartScale;
		command.curve_position = 0;
		command.end_position = 1;
		command.duration = duration;
		command.curve_tween = easingFunc;
		command.curve_mode = easeMode;
}

/**
	* Creates a screen shake effect with the specified amplitude for the specified amount of frames.
	* @param {float} amplitude - The amplitude of the screen shake.
	* @param {int} duration - The duration of the effect in frames.
*/
function view_screen_shake(amplitude, duration)
{


	var cam = camera_properties(0);

	with(oViewScreenShakeCommand) {
		camera_set_view_pos(cam.view_cam, viewXStart, viewYStart);
	    instance_destroy();

	}
	var obj = instance_create_depth(0, 0, 0, oViewScreenShakeCommand);
		obj.amplitude = amplitude;
		obj.t = duration;
		obj.viewXStart = cam.view_x;
		obj.viewYStart = cam.view_y;

}

/**
	* Rotates the default view by a specified amount over time. The movement is relative to thie initial rotation of the view.
	* 
	* @param {float} targetAngle - The angle to rotate the view by.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} easingFunc - The easing function to use. The default is tween_sine_inout.
	* 
*/
function view_rotate(targetAngle, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{

	
	var cam_get_angle = camera_get_view_angle(view_camera[0]);

	var command = instance_create_depth(0, 0, 0, oViewRotateCommand);

		command.StartAngle = cam_get_angle;
		command.DeltaAngle = targetAngle - cam_get_angle;
		command.curve_position = 0;
		command.end_position = 1;
		command.duration = duration;
		command.curve_tween = easingFunc;
		command.curve_mode = easeMode;
}

function view_set_scale(targetScale = 1)
{
	var cam = camera_properties(0);
	
	var TargetScale = targetScale * 800;
	var StartX = cam.view_x;
	var StartY = cam.view_y;
	var StartScale = cam.view_w;
	var MaxScale = TargetScale - StartScale;
	
	

	var camera_w = StartScale + MaxScale;
	var camera_h = cam.view_w * 608 / 800;

	var camera_x = StartX + (StartScale - cam.view_w) / 2;
	var camera_y = StartY + 608 / 800 * (StartScale - cam.view_w) / 2;
	
	camera_set_view_size(cam.view_cam, camera_w, camera_h);
	camera_set_view_pos(cam.view_cam, camera_x, camera_y);
}