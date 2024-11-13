/// @desc Save the freeze intervals to the included file

if(global.debug_enable){
    if(keyboard_check(vk_control)&&keyboard_check_pressed(ord("S"))){
        fname = get_open_filename("freezedata|*.dat","");
        show_debug_message(fname);
        if(file_exists(fname)){
            var f = file_text_open_write_ns(fname,-1);
            
            
            for(var i=0;i<ds_list_size(global.freeze_start);i++){
                file_text_write_line_ns(f,string(global.freeze_start[|i]));
                file_text_write_line_ns(f,string(global.freeze_end[|i]));
            }
            file_text_close_ns(f);
        }
    }
}