/// @desc
if(!instance_exists(obj)){
    instance_destroy();
    exit;
}


var cr=point_distance(cx,cy,obj.x,obj.y);
var ca=point_direction(cx,cy,obj.x,obj.y);

while(cr>dist){
    cx+=dist*dcos(ca);
    cy-=dist*dsin(ca);
    cr-=dist;
    var obj1=instance_create_depth(cx,cy,obj.depth,spawnObj);
    obj1.tag=tag;
    obj1.sprite_index=obj.sprite_index;
    obj1.image_index=obj.image_index;
    obj1.image_angle=obj.image_angle;
    obj1.image_xscale=obj.image_xscale;
    obj1.image_yscale=obj.image_yscale;
    obj1.image_alpha=obj.image_alpha;
}

steps--;
if(steps==0) instance_destroy();

