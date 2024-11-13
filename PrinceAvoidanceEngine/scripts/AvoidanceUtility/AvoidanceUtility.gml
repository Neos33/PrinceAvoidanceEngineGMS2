/**
	* Returns ``true`` every **period** frames, using the timer variable **ct**. Otherwise returns ``false``. An offset **opt_offset** can be set.
	* This is useful if you, for example, want to spawn a bullet every **period** frames.
	* @param {integer} ct - The timer variable, in frames.
	* @param {real} period - The period of the check, in frames. A float value can be given.
	* @param {real} opt_offset - The offset to use, in frames. A float value can be given. The default value is 1.
*/
function on_beat(ct, period, opt_offset = 1)
{
	var wrappedValue = modwrap(ct, 0, period);
	return (floor(wrappedValue) == opt_offset);
	//return (floor(ct % floor(period))==opt_offset);
}

/**
* Creates an instance of an object initialized with speed, direction, scale and tag.
* @param {real} x - The X position to spawn the object at.
* @param {real} y - The Y position to spawn the object at.
* @param {string} layerID - The layer. Depth set to 0 if layer does not exist.
* @param {Asset.GMObject} obj - The obejct to spawn.
* @param {real} speed - The initial speed to spawn the object with.
* @param {real} direction - The initial direction the instance will be moving in.
* @param {real} scale - The initial scale of the object. This affects both the X and the Y scale.
* @param {string} tag - The tag to intialize the instance with. 
* @return {Id.Instance}
*/
function instance_create_ext(x, y, layer_id, object, spd, dir, scale = 1.0, tag = "")
{

	var instance_create = instance_create_layer;
	if !layer_exists(layer_id)
	{
		//print($"'{layer_id}' does not exists | setting default depth (0)");
		instance_create = instance_create_depth
		layer_id = 0;
	}
	
	var inst = instance_create(x, y, layer_id, object);
		inst . speed = spd;
		inst . direction = dir;
		inst . tag = tag;
		inst . image_xscale = scale;
		inst . image_yscale = scale;
		
	return inst;
}

function object_copy(obj)
{
	//Copies the instance and its default variables
	var ind = instance_create_depth(x, y, depth, obj);

		ind . sprite_index = sprite_index;
		ind . image_index = image_index;

		ind . image_xscale = image_xscale;
		ind . image_yscale = image_yscale;
		ind . image_angle = image_angle;

		ind . image_alpha = image_alpha;
		ind . image_blend = image_blend;


		ind . tag = tag;

	return ind;
}

/**
	* Sets the speed at which a bullet given by bulletID changes its direction.
	* 
	* @param {Id.Instance} bulletID - The ID of the bullet to apply the curving to.
	* @param {real} curveSpeed - The speed at which the bullet will curve.
	* 
*/
function bullet_set_curving(bulletID, curveSpeed)
{
	with(bulletID) self.curveSpeed=curveSpeed;
}

/**
	* Sets whether or not the bullet given by ID will change its sprite orientation as it moves.
	*
	* If **followDirection** is set to ``true``, then the bullet will automatically set its image_angle equal to the direction of its movement.
	* 
	* @param {Id.Instance} bulletID - The ID of the bullet to apply the curving to.
	* @param {bool} followDirection - Whether or not the bullet will change its image_angle according to its direction.
	* 
*/
function bullet_set_follow_direction(bulletID, followDirection)
{
	with(bulletID) self.followDirection=followDirection;
}

/**
	* Traces an object's trajectory with other objects for a specified amount of frames.
	* 
	* The spawned objects are placed at an equal distance from each other,specified by ``dist``. They also inherit the object's scale and alpha variables.
	* 
	* This is useful for creating structures like curves and tendrils.
	* 
	* Unlike {@link tracer_attach}, this executes the specified amount of steps immediately rather than over time.
	* @param {Id.Instance} obj - The type of the object to spawn.
	* @param {integer} steps - The amount of steps to trace for.
	* @param {float} dist - The distance at which to spawn the objects.
	* @param {string} tag - The tag to give the spawned objects.
	* 
*/
function trace_trajectory(object,steps,dist,tag)
{
	/*
	* @example
	* //The following code creates a bullet with gravity, then traces its trajectory for 80 frames, spawning another bullet every 16 pixels
	* var bullet = instance_create(400,304,objAvoidanceBullet);
	* 
	* bullet.speed = 5;
	* bullet.direction=random(360);
	* bullet.gravity = 0.4;
	* 
	* with(bullet) trace_trajectory(objAvoidanceBullet, 80, 16, "trace");
	*/
	var spawnObj=object;
	var spawnTag=tag;

	var cx=x;
	var cy=y;


	for(var i=0;i<steps;i++){
    
	    event_perform(ev_step,ev_step_normal);    
	    hspeed+=gravity*dcos(gravity_direction);
	    vspeed-=gravity*dsin(gravity_direction);
	    x+=hspeed;
	    y+=vspeed;
    
	    var cr=point_distance(cx,cy,x,y);
	    var ca=point_direction(cx,cy,x,y);
	    while(cr>dist)
		{
	        cx+=dist*dcos(ca);
	        cy-=dist*dsin(ca);
	        cr-=dist;
	        var obj=instance_create_depth(cx, cy, 0, spawnObj);
	        obj.tag=spawnTag;
	        obj.image_xscale=image_xscale;
	        obj.image_yscale=image_yscale;
	        obj.image_alpha=image_alpha;
	    }   
	}
}

/**
	* Attaches a tracer to an object which spawns an instance of an object ``obj`` every ``dist`` pixels the instance moves, for a specified amount of frames.
	* 
	* This is useful for things like bullet trails, as well as gradually drawing shapes with objects.
	* @param {Id.Instance} obj - The ID of the object to attach the tracer to.
	* @param {Asset.GMObject} spawnObj - The kind of object to spawn.
	* @param {integer} steps - The amount of frames to attach the tracer for, in frames.
	* @param {real} dist - The distance between spawned objects, in pixels.
	* @param {string} tag - The tag to assign to the instance.
*/
function tracer_attach(obj, spawnObj, steps, dist, tag)
{
	with(instance_create_depth(0, 0, 0, oTraceCommand)){
	    self.obj = obj;
	    self.spawnObj = spawnObj;
	    self.steps = steps;
	    self.dist = dist;
	    self.tag = tag;
	    cx=obj.x;
	    cy=obj.y;
	}

}
/**
	* Spawns a custom shape.
	*
	* You can pass a Shaper script as the last argument to define which shape to spawn.
	*
	* @param {real} x - The X position to spawn the shape at.
	* @param {real} y - The Y position to spawn the shape at.
	* @param {real} angle - The angle at which to spawn the shape.
	* @param {integer} edges - The amount of edges the shape should have.
	* @param {integer} numprojectiles - The total amount of projectiles spawned.
	* @param {real} speed - The speed at which the shape expands.
	* @param {Id.Instance OR Asset.GMObject} obj - The index of the object type to spawn as the projectile.
	* @param {string} opt_tag - The tag to assign the projectile. The default is "" (an empty string)
	* @param {shaper} opt_shaper - The shaper function to use. The default is ``shaper_shape``.
	* 
	* @returns {array} An array containing all of the created bullets.
	* 
*/
function spawn_shape(x, y, angle, edges, numprojectiles, speed, obj, opt_tag = 0, opt_shaper = shaper_shape)
{
	var spawnX = x;
	var spawnY = y;
	var spawnAngle = angle;
	var spawnEdges = edges; //3 = triangle, 4 = square, etc.
	var spawnNum = numprojectiles; //Projectiles per edge
	var spawnSpeed = speed;
	var spawnObj = obj;


	var th, xx, yy, ddx, ddy, dx, dy, a, aaa;

	th = degtorad(spawnAngle);

	aaa[0]=0;
	aaa[spawnNum-1]=0;
	for(var i=0;i<spawnNum;i++){
	    a = instance_create_depth(spawnX, spawnY, 0, spawnObj);
	    var aa = script_execute(opt_shaper,i/spawnNum,spawnEdges);
	    a.speed=spawnSpeed*aa[0];
	    a.direction=aa[1]+spawnAngle;
	    a.tag = opt_tag;
	    aaa[@i]=a;
	}

	return aaa;
}


/**
    * Spawns a ring of projectiles.
    * 
    * @param {float} x - The X position to spawn the circle at.
    * @param {float} y - The Y position to spawn the circle at.
    * @param {float} angle - The angle at which to spawn the circle.
    * @param {int} numprojectiles - The total amount of projectiles spawned.
    * @param {float} speed - The speed at which the circle expands.
    * @param {objectID} obj - The index of the object type to spawn as the projectile.
    * @param {string} opt_tag - The tag to assign the projectile. The default is "" (an empty string)
    * 
    * @returns {array} An array containing all of the created bullets.
    * 
*/
function spawn_circle(x,y,angle,numprojectiles,speed,obj,opt_tag = 0)
{
	var spawnX = x;
	var spawnY = y;
	var spawnAngle = angle;
	var spawnNum = numprojectiles;
	var spawnSpeed = speed;
	var spawnObj = obj;
	var a;

	aaa[0]=0;
	aaa[spawnNum-1]=0;
	for (var i = 0; i < spawnNum; i += 1)
	{
	    a = instance_create_depth(spawnX, spawnY, 0, spawnObj);
	    a.speed = spawnSpeed;
	    a.direction = spawnAngle + i * (360 / spawnNum);
	    a.tag=opt_tag;
	    aaa[@i]=a;
	}
	return aaa;
}


function spawn_3D_circle(x,y,sprite,index,radius,angle,dAngle,numBullets,tag)
{
	//TODO: add a demonstration of how the Euler angles (angle, theta, phi) work, 
	//either through a room or through an external image

	var obj=instance_create_depth(x,y,0, objAvoidance3DCircle);

		obj.numBullets = numBullets;
		obj.image_xscale = radius;
		obj.angle = angle;
		obj.dAngle = dAngle;
		obj.tag = tag;

		with(obj){
		    event_perform(ev_step,ev_step_normal);
		    for(var i=0;i<numBullets;i++){
		        bullets[i].sprite_index = sprite;
		        bullets[i].image_index = index;
		    }
		}
	return obj;


}

/**
    * Creates a 3d shape.
    * @param {float} x - The X coordinate to create the shape at.
    * @param {float} y - The Y coordinate to create the shape at.
    * @param {spriteID} sprite - The sprite of the bullets in the shape.
    * @param {int} index - The image index of the bullets in the shape.
    * @param {float} radius - The radius of the shape, in pixels.
    * @param {float} angle - The angle of the shape around its rotation axis.
    * @param {float} dAngle - The increment of the angle.
    * @param {int} numBullets - the amount of bullets in the shape.
    * @param {string} - The tag to assign the shape.
    * @param {shaper} shaper  - The shaper function to use.
    * @param {int} N - the number of edges in the shape.
    * 
*/
function spawn_3D_shape(x,y,sprite,index,radius,angle,dAngle,numBullets,tag,shaper,N)
{
	//TODO: add a demonstration of how the Euler angles (angle, theta, phi) work, 
	//either through a room or through an external image

	var obj=instance_create_depth(x,y,0,objAvoidance3DShape);

		obj.numBullets = numBullets;
		obj.image_xscale = radius;
		obj.angle = angle;
		obj.dAngle = dAngle;
		obj.tag = tag;

		obj.shaper=shaper;
		obj.n=N;
		with(obj){
		    event_perform(ev_step,ev_step_normal);
		    for(var i=0;i<numBullets;i++){
		        bullets[i].sprite_index = sprite;
		        bullets[i].image_index = index;
		    }
		}
	return obj;
}


function spawn_3D_circle_ext(x,y,sprite,index,radius,angle,dAngle,theta,dTheta,phi,dPhi,numBullets,tag)
{
	//TODO: add a demonstration of how the Euler angles (angle, theta, phi) work, 
	//either through a room or through an external image

	var obj=instance_create_depth(x,y,0,objAvoidance3DCircle);

	obj.numBullets = numBullets;
	obj.image_xscale = radius;
	obj.angle = angle;
	obj.dAngle = dAngle;
	obj.tag = tag;
	obj.theta=theta;
	obj.dTheta=dTheta;
	obj.phi=phi;
	obj.dPhi=dPhi;


	with(obj){
	    event_perform(ev_step,ev_step_normal);
	    for(var i=0;i<numBullets;i++){
	        bullets[i].sprite_index = sprite;
	        bullets[i].image_index = index;
	    }
	}
	return obj;

}