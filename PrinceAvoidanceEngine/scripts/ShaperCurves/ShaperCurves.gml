///Shaper scripts return a pair of values corresponding to the polar position of a point on a parametric curve
///theta goes from 0 to 1
function shaper_circle(theta, n)
{
	var R = 1;
	var THETA = 360 * theta;


	///Pack the values into an array and return them
	var a;
	a[0] = 0;
	a[1] = 0;

	a[@0] = R;
	a[@1] = THETA;
	return a;
}

function shaper_teardrop(theta,n)
{
	var X = 0, Y = 0;
	var newTheta = 360 * theta;

	Y = 1.0 * (1.0 - dsin(newTheta)) * dcos(newTheta);
	X = 2.2 * (dsin(newTheta) - 1.0);


	///Convert to polar

	var R = point_distance(0, 0, X, Y);
	var THETA = point_direction(0, 0, X, Y);
	

	///Pack the values into an array and return them
	var a;
	a[0] = 0;
	a[1] = 0;

	a[@0] = R;
	a[@1] = THETA;
	return a;
}

function shaper_gear(theta,n)
{
	var R = 0.5+0.5*(((n*theta)%1)>0.5);
	var THETA = 360*theta;


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_identity(theta,n)
{
	var R = 1;
	var THETA = 0;


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_spiral(theta,n)
{
	var R = theta;
	var THETA = 360*theta;


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_flower(theta,n)
{
	var tt=360*theta;

	var amplitude=abs(tt%(360/n)-(360/n)/2)/(360/n);

	var R = 0.25+0.75*amplitude;
	var THETA = 360*theta;


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;

}

function shaper_shape(theta,n)
{
	var X=0,Y=0;


	for(var i=0;i<n;i++){
	    if(theta>=i/n && theta<=(i+1)/n){
	        var X1 = dcos(360*i/n);
	        var Y1 = -dsin(360*i/n);
        
	        var X2 = dcos(360*(i+1)/n);
	        var Y2 = -dsin(360*(i+1)/n);
	        X = lerp(X1,X2,n*(theta-i/n));
	        Y = lerp(Y1,Y2,n*(theta-i/n));
	        break;
	    }
	}

	///Convert to polar

	var R = point_distance(0,0,X,Y);
	var THETA = point_direction(0,0,X,Y);


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_sawblade(theta, number)
{
	var n0 = number;
	var X=0,Y=0;

	var n=2*n0;
	for(var i=0;i<n;i++){
	    if(theta>=i/n && theta<=(i+1)/n){
	        var X1 = dcos(360*i/n);
	        var Y1 = -dsin(360*i/n);
        
	        var X2 = dcos(360*(i+1)/n);
	        var Y2 = -dsin(360*(i+1)/n);
	        if(i%2){
	            X2*=0.5;
	            Y2*=0.5;
	        }else{
	            X1*=0.5;
	            Y1*=0.5;
	        }
	        X = lerp(X1,X2,n*(theta-i/n));
	        Y = lerp(Y1,Y2,n*(theta-i/n));
	        break;
	    }
	}

	///Convert to polar

	var R = point_distance(0,0,X,Y);
	var THETA = point_direction(0,0,X,Y);


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_heart(theta,n)
{
	var X,Y;
	var tt = theta*360;


	X = power(dsin(tt),3);
	Y = (13*dcos(tt)-5*dcos(2*tt)-2*dcos(3*tt)-dcos(4*tt))/16;


	///Convert to polar

	var R = point_distance(0,0,X,Y);
	var THETA = point_direction(0,0,X,Y);


	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}

function shaper_star(theta,n)
{
	var X=0,Y=0;


	for(var i=0;i<n;i++){
	    if(theta>=i/n&&theta<(i+1)/n){
	        var X1 = dcos(360*i/n);
	        var Y1 = -dsin(360*i/n);
        
	        var X2 = dcos(360*(i+2)/n);
	        var Y2 = -dsin(360*(i+2)/n);
	        X = lerp(X1,X2,n*(theta-i/n));
	        Y = lerp(Y1,Y2,n*(theta-i/n));
	        break;
	    }
	}

	var R = point_distance(0,0,X,Y);
	var THETA = point_direction(0,0,X,Y);

	///Pack the values into an array and return them
	var a;
	a[0]=0;
	a[1]=0;

	a[@0]=R;
	a[@1]=THETA;
	return a;
}






