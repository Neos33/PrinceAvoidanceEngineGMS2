/// @desc
///Destroy if there is more than 1 instance of the object
if(instance_number(object_index)>1){
    instance_destroy();
    exit;
}

///initialize the variables
t=0;