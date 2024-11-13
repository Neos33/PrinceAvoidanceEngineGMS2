/**
    * Creates a screen-wide flash effect of the colour [colour].
    * @param {float} [alpha] - The initial alpha of the flash (the default is 0.5);
    * @param {integer} [time] - The duration of the flash in frames (the default is 20)
    * @param {colour} [colour] - The colour of the flash (the default is c_white)
    * 
*/
function visual_flash(alpha = 0.5, time = 20, colour = c_white)
{

	var _obj;
	_obj=instance_create_depth(0, 0, -9999, objPColourRectangle);
	_obj.image_blend = colour;
	_obj.image_alpha = alpha;
	instance_fade_out(_obj, time);
}