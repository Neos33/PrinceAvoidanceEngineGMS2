/// @desc
///Count down and execute the given script when the countdown reaches 0

delay--;

if(delay<=0){
    event_user(0); //execute the given script
    instance_destroy();
}