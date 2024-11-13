/// @desc
for( var i = 0; i < FadeCount; i++ ) 
{
    var targetId = FadeList[i];
    if( instance_exists( targetId ) ) 
	{;
        targetId.image_xscale = StartXScale * alarm[0] / fadeDuration;
        targetId.image_yscale = StartYScale * alarm[0] / fadeDuration;
        
        if( targetId.image_xscale <= 0 ) 
		{
            with( targetId ) 
			{
                instance_destroy();
            }
        }
    }
}