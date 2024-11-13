/// @desc Stolen from AI

draw_set_alpha(1);
var center_x, center_y, radius;
var start_angle, num_segments;
var angle_step, i;
// Set the required parameters
if ((instance_exists(objPlayer)||instance_exists(objPlayerGhost))&&instance_exists(objAvoidanceMarker)) {
    //Resetting center coordinates and variables for partial circle
    if(instance_exists(objPlayer)){
        center_x = objPlayer.x;
        center_y = objPlayer.y;
    }else{
        center_x = objPlayerGhost.x;
        center_y = objPlayerGhost.y;
    }
    radius = 48;
    start_angle = 90;
    
    alpha = comboTimer*2.5*exAlpha;
    if(!global.ance) alpha = hitTimer;
    num_segments = 50;
    // Calculate the angular increment
    angle_step = (end_angle - start_angle) / num_segments;
    // Change the colour of the bar if the combo is frozen
    
    // Draw each line segment
    for (i = 0; i < num_segments; i++) {
        var angle = start_angle + i * angle_step;
        var x1 = center_x + lengthdir_x(radius, angle);
        var y1 = center_y + lengthdir_y(radius, angle);
        var x2 = center_x + lengthdir_x(radius, angle + angle_step);
        var y2 = center_y + lengthdir_y(radius, angle + angle_step);
        draw_set_alpha(alpha*image_alpha);
        draw_set_colour(c_black);
        draw_line_width(x1, y1, x2, y2, 5);
        
        draw_set_colour(c_white);
        if(global.freezeCombo||global.freezeComboTimeline) draw_set_colour(c_aqua);
        if(!global.ance) draw_set_colour(image_blend);
        draw_line_width(x1, y1, x2, y2, 3);
    }
}
draw_set_alpha(1);
draw_set_colour(c_white);