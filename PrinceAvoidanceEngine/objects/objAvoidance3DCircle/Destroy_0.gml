/// @desc
///Clean up all bullets
if(init)
for (var i=0; i<numBullets; i++) {
    var ct = angle+i/numBullets // individual cherry's time
    var r = radius
    var a = ct*360
    if(instance_exists(bullets[i])){
        with(bullets[i]){ 
            instance_destroy();
        }
    }
}