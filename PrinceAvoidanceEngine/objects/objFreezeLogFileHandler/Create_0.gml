/// @desc
///Make sure there is only 1 file handler object


if(instance_number(object_index)>1){
    instance_destroy();
    exit;
}

///Initialize the variables
file="";

///Load the freeze log from the included file


var _f = file_text_open_read("freezedata.dat");
while(!file_text_eof(_f)){
    var _v1 = file_text_read_real(_f);
    file_text_readln(_f);
    if(!file_text_eof(_f)){
        var _v2 = file_text_read_real(_f);
        file_text_readln(_f);
        ds_list_add(global.freeze_start,_v1);
        ds_list_add(global.freeze_end,_v2);
    }else{
        break;
    }
}

file_text_close(_f);