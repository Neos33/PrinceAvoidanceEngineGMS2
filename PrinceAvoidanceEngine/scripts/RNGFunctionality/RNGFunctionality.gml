#region RNG Control

/**
    * Creates an RNG controller object with the specified number of bins.
    * RNG controller objects are required for further {@link random_range_controlled} calls.
    * 
    * The number of bins dictates how even you want your RNG to be - the more bins, the more even the RNG will be. 
    * However, an amount that is too large will eventually cause the randomness to be lost. 2-4 bins are usually recommended.
    * 
    * @param {integer} [opt_numBins] - The number of bins to be created.
    * The default is 4.
    * 
    * @returns {Id.Instance} The index of the created RNG controller instance.
*/
function rng_controller_create(opt_numBins = 4)
{

	var a=instance_create_depth(0,0,0,objRNGController);

		a.numBins=opt_numBins;

	return a;

}


/**
    * Randomly generates a value between x1 and x2, using an rngController object (see {@link rng_controller_create}).
    * The RNG controller object separates the interval into a number of "bins". On the first call, the value is guaranteed to generate in the first bin, then on the second call in the second bin, so on and so forth.
    * This way, random clusters and variations of RNG density can be mitigated, however, care should be taken as using an RNG controller with an amount of bins that is too large will cause the function to lose its randomness.
    * 
    * @param {float} x1 - The lower boundary of the interval.
    * @param {float} x2 - The upper boundary of the interval.
    * @param {Id.Instance} rngController - The index of an RNG controller object previously created using {@link rng_controller_create}.
    * 
    * @returns {float} The randomly generated value.
*/
function random_range_controlled(x1,x2,rngController)
{
	/*
	* 
    * @example
    * // The following code creates an RNG controller with 4 bins on the first frame of the attack,
    * // and then generates instances with random direction based on the RNG controller.
    * if(ct==1){
    *     rngController = rng_controller_create(4); //Create the RNG controller
    * }else if(ct>1){
    *    var bullet = instance_create(400,304,objAvoidanceBullet);
    *    bullet.speed = 1;
    *    bullet.direction = random_range_controlled(0,360,rngController);
    * }
    * 
	*/

	var bin = rngController.bin;


	var xBin1=lerp(x1,x2,bin/rngController.numBins);
	var xBin2=lerp(x1,x2,(bin+1)/rngController.numBins);
	with(rngController) event_user(0);

	return random_range(xBin1,xBin2);

}

#endregion

#region RNG Seeding

function seeded_sequence_init(size,seed)
{

	var obj = instance_create_depth(1,1,0,objSeededRNGSeq);
	random_set_seed(seed);
	with(obj){
	    for(var i=0;i<size;i++){
	        seq[i]=random(1);
	    }
	    self.size=size;
	}
	return obj;

}

function random_seeded(x,rngObj)
{
	var valX,valY;
	valX=x;
	with(rngObj){
	    valY=seq[n];
	    n++;
	    if(n==size) n=0;
	}
	return valY*valX;
}

function random_seeded_range(x1,x2,rngObj)
{
	var valX1,valX2,valY;
	valX1=x1;
	valX2=x2;
	with(rngObj){
	    valY=seq[n];
	    n++;
	    if(n==size) n=0;
	}
	return lerp(valX1,valX2,valY);
}

#endregion