
/** 
	* Change the alpha of an instance over time.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change the alpha of.
	* @param {real} targetAlpha - The final value to change the alpha to.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_linear.
	* 
*/
function instance_change_alpha( targetId, targetAlpha, duration, easingFunc = ac_linear, easeMode = EASE_OUT )
{


	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeAlphaCommand );
		    command.TargetId = id;
		    command.StartAlpha = image_alpha;
		    command.DeltaAlpha = targetAlpha - image_alpha;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_AlphaChangeCommand = command;
	}
}

/** 
    * Change the angle of an instance over time.
    * 
    * New instance commands override existing ones.
    * @param {Id.Instance} targetId - The instance to change the angle of.
    * @param {real} targetAngle - The final value to change the angle to.
    * @param {integer} duration - The duration of the change, in frames.
    * @param {easingFuncID} [easingFunc] - The easing function to use. The default is tween_linear.
    * 
*/
function instance_change_angle( targetId, targetAngle, duration, easingFunc = ac_linear, easeMode = EASE_OUT )
{
	
	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeAngleCommand );
		    command.TargetId = id;
		    command.StartAngle = image_angle;
		    command.DeltaAngle = angle_difference(targetAngle, image_angle);
			command.curve_position = 0;
			command.end_position = 1;
			command.duration = max( duration, 1 );
			command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_AngleChangeCommand = command;
	}
	
}
/**
    * Change the shape of a 3D shape object.
    *
    * New instance commands override existing ones.
    *
    * @param {instanceID} targetId - The 3D shape instance to morph(returned by {@link spawn_3D_shape})
    * @param {shaper} targetShape - The shape function to morph into.
    * @param {int} targetN - The amount of edges of the target shape.
    * @param {integer} duration - The duration of the change, in frames.
    * @param {easingFuncID} [easingFunc] - The easing function to use. The default is tween_sine_inout.
    * 
*/
function instance_morph( targetId, targetShape, targetN, duration, easingFunc = ac_ease, easeMode = EASE_INOUT)
{

	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oMorphCommand );
		    command.TargetId = id;
			command.curve_position = 0;
			command.end_position = 1;
			command.duration = max( duration, 1 );
			command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_MorphCommand = command;
		    morphT=0;
		    morph=true;
		    newShaper = targetShape;
		    newN = targetN;
	}
}

/** 
	* Change the colour of an instance over time.
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change the alpha of.
	* @param {Constant.Color} targetColour - The final value to change the colour to.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_linear.
	* 
*/
function instance_change_color( targetId, targetColour, duration, easingFunc = ac_linear, easeMode = EASE_OUT )
{
	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeColorCommand );
		    command.TargetId = id;
		    command.StartColor = image_blend;
		    command.EndColor = targetColour;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ColorChangeCommand = command;
	}
}

/** 
	* Change the colour variable given by the string varName to targetX over time. 
	* 
	* A separate script from {@link instance_change_variable} is used for colour variables specifically as they are handled differently internally.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change a variable of.
	* @param {string} varName - A string containing the name of the variable to change.
	* @param {Constant.Color} targetX - The final value of the manipulated variable.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_change_color_variable( targetId, varName, targetX, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{
	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeColourVariableCommand );
		    command.TargetId = id;
		    command.varName = varName;
		    command.StartVar = variable_instance_get(id, varName);
		    command.targetX = targetX;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ChangeVariableCommand = command;
	}
}


/** 
	* Change the variable given by the string varName to targetX over time. 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change a variable of.
	* @param {string} varName - A string containing the name of the variable to change.
	* @param {real} targetX - The final value of the manipulated variable.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_change_variable( targetId, varName, targetX, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{
	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeVariableCommand );
		    command.TargetId = id;
		    command.varName = varName;
		    command.StartVar = variable_instance_get(id, varName);
		    command.DeltaX = targetX - command.StartVar;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ChangeVariableCommand = command;
	}
}


/** 
	* Change the element of an array given by varName to targetX over time. Refer to {@link instance_change_variable} for non-array variables.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change a variable of.
	* @param {string} varName - A string containing the name of the array to change an element from.
	* @param {real} varIndex - The index of the element to change.
	* @param {real} targetX - The final value of the manipulated array element.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_change_variable_array( targetId, varName, varIndex, targetX, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{


	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeVariableArrayCommand );
		    command.TargetId = id;
		    command.varName = varName;
		    command.varIndex = varIndex;
		    command.currVar = variable_instance_get(id, varName); //get the array
		    command.StartVar = command.currVar[varIndex];
		    command.DeltaX = targetX - command.StartVar;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ChangeVariableCommand = command;
	}
}

/** 
	* Change the array variable given by the string varName to targetX over time, element-wise. Refer to {@link instance_change_variable} for non-array variables, and {@link instance_change_variable_array} to change a single element of an array.
	*
	* The dimensions of the array provided and the array variable specified must match.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change a variable of.
	* @param {string} varName - A string containing the name of the variable to change.
	* @param {array} targetX - The final value of the manipulated array variable.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_change_variable_array_full( targetId, varName, targetX, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{


	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrChangeVariableArrayFullCommand );
		    command.TargetId = id;
		    command.varName = varName;
		    command.currVar = variable_instance_get(id, varName); //get the array
		    //command.StartVar=variable_instance_get(id,varName);
			var total_list = array_length(command.currVar);
		    for(var i = 0; i < total_list; i++)
			{
		        command.StartVar[i] = command.currVar[i]
		    }
			command.TargetVar = targetX;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ChangeVariableCommand = command;
	}
}

/**
	* Gradually lower the alpha value of all instances with the given targetId.
	* When the alpha reaches zero, destroy them.
	* Fade duration represents the maximum possible duration for fully opaque instances.
	* If an instance is already partially transparent, it will disappear quicker.
	* @param {Id.Instance} targetId - the index of the object to fade out.
	* @param {integer} fadeDuration - The duration of the fadeout for an object with full alpha, in frames.
*/
function instance_fade_out( targetId, fadeDuration = 1)
{

	var fade_time = max( fadeDuration, 1 );

	var newCommand = instance_create_depth( 0, 0, 0, oRdrFadeCommand );
		newCommand.AlphaDelta = 1 / fade_time;

	var fadeCount = 0;
	with( targetId ) {
	    newCommand.FadeList[fadeCount] = id;
	    fadeCount++;
	}
	newCommand.FadeCount = fadeCount;
	newCommand.alarm[0] = fade_time;
}


/**
	* Move an instance or all instances of an object to a given position.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to move.
	* @param {real} targetX - The X coordinate of the point to move the instance to.
	* @param {real} targetY - The Y coordinate of the point to move the instance to.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_move_to( targetId, targetX, targetY, duration, easingFunc = ac_ease, easeMode = EASE_OUT )
{
	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrMoveCommand );
		    command.TargetId = id;
		    command.DeltaX = targetX - x;
		    command.DeltaY = targetY - y;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_MoveCommand = command;
	}
}

/**
	* Move an instance or all instances of an object to a given position, in polar coordinates around a specified point.
	* 
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to move.
	* @param {real} pivotX - The X coordinate of the point to move the instance around.
	* @param {real} pivotY - The Y coordinate of the point to move the instance around.
	* @param {real} targetRadius - The distance from the pivot point to move the instance to.
	* @param {real} targetAngle - The angle to move the instance to, with 0 being the positive horizontal axis (the 3 o'clock position)
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_move_to_polar( targetId, pivotX, pivotY, targetRadius, targetAngle, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{


	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oMoveToPolarCommand );
		    command.TargetId = id;
		    command.PointX = targetX
		    command.PointY = targetY
		    command.StartDist = point_distance(x, y, targetX, targetY);
		    command.StartAngle = point_direction(x, y, targetX, targetY) + 180;
		    command.AngleDelta = targetAngle;
		    command.RadiusDelta = targetRadius - command.StartDist;
		    command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_MoveToPolarCommand = command;
	}
}

/** 
	* Change the scale of an instance over time.
	* New instance commands override existing ones.
	* @param {Id.Instance} targetId - The instance to change the scale of.
	* @param {real} targetScale - The final value to change the scale to.
	* @param {integer} duration - The duration of the change, in frames.
	* @param {easingFuncID} [easingFunc] - The easing function to use. The default is ac_ease.
	* 
*/
function instance_scale( targetId, targetScale, duration, easingFunc = ac_ease, easeMode = EASE_INOUT )
{


	with( targetId ) {
	    var command = instance_create_depth( x, y, depth, oRdrScaleCommand );
		    command.TargetId = id;
		    command.StartScale = image_xscale;
		    command.ScaleDelta = targetScale - image_xscale;
			command.curve_position = 0;
			command.end_position = 1;
		    command.duration = max( duration, 1 );
		    command.curve_tween = easingFunc;
			command.curve_mode = easeMode;
		    self.Internal_ScaleChangeCommand = command;
	}
}

/**
	* Gradually lower the scale value of all instances with the given targetId.
	* When the scale reaches zero, destroy them.
	* Fade duration represents the maximum possible duration for fully opaque instances.
	* If an instance is already partially transparent, it will disappear quicker.
	* @param {Id.Instance} targetId - the index of the object to shrink out.
	* @param {integer} shrinkDuration - The duration of the shrinkout for an object with full scale, in frames.
*/
function instance_shrink_out( targetId, shrinkDuration = 1) 
{

	var fadeDuration = max( shrinkDuration, 1 );

	var newCommand = instance_create_depth( 0, 0, 0, oRdrShrinkCommand );
		newCommand.AlphaDelta = 1 / fadeDuration;

		var fadeCount = 0;
		with( targetId ) {
		    newCommand.FadeList[fadeCount] = id;
		    newCommand.StartXScale = image_xscale;
		    newCommand.StartYScale = image_yscale;
    
		    fadeCount++;
		}
		newCommand.FadeCount = fadeCount;
		newCommand.alarm[0] = fadeDuration;
		newCommand.fadeDuration = fadeDuration;
}


/** 
	* Executes a script after a certain number a frames has passed.
	* 
	* Supports up to 5 arguments: param1, param2 etc.
	* @param {scriptID} scr - A script to execute.
	* @param {integer} delay - The time delay before the script is executed, in frames.
	* @param param1 - The first parameter of the script.
	* @param param2 - The second parameter of the script.

*/
function script_execute_delayed(scr,delay)
{

	var numargs=argument_count-2;

	var obj=instance_create_depth(0,0,0,oDelayedExecutionCommand);
		obj.scr=scr;
		obj.delay=delay;
		obj.numargs=numargs;
		for(var i=0;i<argument_count;i++){
		    obj.args[i]=argument[i];
		}
	
}