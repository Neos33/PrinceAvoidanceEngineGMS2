/// @desc
if Type == "Hold"
{
    var _len = sprite_width + 8;
    var _x1, _y1, _x2, _y2, _x3, _y3;
    
    var _side = 360 / 3;
    
    //draw_set_color(triangle_color);
    draw_set_color(c_white);
    
    _x1 = x + lengthdir_x(_len, triangle_angle);
    _y1 = y + lengthdir_y(_len, triangle_angle);
    _x2 = x + lengthdir_x(_len, triangle_angle + _side);
    _y2 = y + lengthdir_y(_len, triangle_angle + _side);
    _x3 = x + lengthdir_x(_len, triangle_angle + _side * 2);
    _y3 = y + lengthdir_y(_len, triangle_angle + _side * 2);
    
    
    draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, true);
    
    _len += 6;
    
    _x1 = x + lengthdir_x(_len, triangle_angle);
    _y1 = y + lengthdir_y(_len, triangle_angle);
    _x2 = x + lengthdir_x(_len, triangle_angle + _side);
    _y2 = y + lengthdir_y(_len, triangle_angle + _side);
    _x3 = x + lengthdir_x(_len, triangle_angle + _side * 2);
    _y3 = y + lengthdir_y(_len, triangle_angle + _side * 2);
    
    
    draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, true);
    
    // Reset color
    draw_set_color(c_white);
}