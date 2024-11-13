#region Arrays
function array_shuffle(array) {
	var length = array_length(array);

	for (var i = 0; i < length; i++) {
	    var temp = array[i];
	    var rnd = irandom(length - 1);
	    array[i] = array[rnd];
	    array[rnd] = temp;
	}

	return array;
}

function array_pick(array) {
	return array[irandom(array_length(array) - 1)];
}
#endregion

#region Drawing
function draw_text_outline(x, y, text, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text(x + j, y + i, text);
	    }
	}

	draw_set_colour(color);
	draw_text(x, y, text);
}

function draw_sprite_fog(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha, fog_color = c_black) {
	gpu_set_fog(true, fog_color, 0, 0);
	draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha);
	gpu_set_fog(false, c_black, 0, 0);
}
#endregion

#region Other
function camera_properties(num) {
	var cam = view_camera[num];
	
	return {
		view_cam: cam,
		view_x: camera_get_view_x(cam),
		view_y: camera_get_view_y(cam),
		view_w: camera_get_view_width(cam),
		view_h: camera_get_view_height(cam),
		view_xw: camera_get_view_x(cam) + camera_get_view_width(cam),
		view_yh: camera_get_view_y(cam) + camera_get_view_height(cam),
		view_angle: camera_get_view_angle(cam),
	};
}

function remap(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function approach(val1, val2, amount) {
	if (val1 == val2) {
		return val1;
	}
	
	if (val1 < val2) {
		return min(val1 + amount, val2);
	} else {
		return max(val1 - amount, val2);
	}
}

function struct_all(struct) {
    var names = variable_struct_get_names(struct);

    for (var i = 0; i < array_length(names); i++) {
        if (!struct[$ names[i]]) {
            return false;
        }
    }

    return true;
}

function struct_set_all(struct, value) {
    var names = variable_struct_get_names(struct);
    
    for (var i = 0; i < array_length(names); i++) {
        struct[$ names[i]] = value;
    }
}

function seconds_to_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}

function frames_to_seconds(frames) {
	return frames / game_get_speed(gamespeed_fps);
}

function print(str) {
	show_debug_message(str);
}

function in_range(value, value_min, value_max)
{
	return value == median(value, value_min, value_max);
}
#endregion

/**
	* Keeps a value withing the provided edge by wrapping around the edges.
	* Inclusive at the lower bound, exclusive at the upper.
	* e.g. 8 in range 0-8 would wrap to 0.
	* Code taken from renex's gm82core.
	* 
	* @param {real} val - The value to wrap.
	* @param {real} min - The lower bound of the wrap interval.
	* @param {real} max - The upper bound of the wrap interval.
	* 
	* @returns {real} - The wrapped value.
*/
function modwrap(val, val_min, val_max)
{


	var f = val - val_min;
	var w = val_max - val_min;
	return f - floor(f / w) * w + val_min;
}


function draw_set_align(halign = fa_left, valign = fa_top)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function draw_text_outline_transformed(x,y,text,outlinecolor,xscale,yscale,angle)
{
	///draws any text with an outline
	///argument0 - text X position
	///argument1 - text Y position
	///argument2 - text string
	///argument3 - color of the text outline
	///argument4 - hello razzor


	//draw the text outline

	var text_color = draw_get_color();
	draw_set_color(outlinecolor);
	
	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
			draw_text_transformed(x + j, y + i, text, xscale, yscale, angle);
	    }
	}
	
	//draw the text itself
	draw_set_color(text_color);
	draw_text_transformed(x, y, text, xscale, yscale, angle);
}


/**
    * The Reverse lerp function.
    * 
    * This function takes a number, and returns that number's position between values ``val0`` and ``val1``, normalized from 0 to 1.
    * This is the reverse of the built-in ``lerp`` function.
    * Keep in mind that the returned value can be less than 0 (if the input value is less than val0), or more than 1 (if the input value is more than val1).
    * 
    * @param {float} val1 - The beginning value of the interval.
    * @param {float} val2 - The end value of the interval.
    * @param {float} val_in_the_middle - The value to calculate the position for.
    * 
    * @returns {float} - The position of the value between ``val0`` and ``val1``, from 0 to 1.
*/
function rlerp(val0, val1, val_in_the_middle)
{
	return (val0-val_in_the_middle)/(val0-val1);
}