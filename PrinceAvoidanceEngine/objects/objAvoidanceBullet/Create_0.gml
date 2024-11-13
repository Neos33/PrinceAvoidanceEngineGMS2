#region Set the basic variables

event_inherited();

image_speed=0;
killer=true;
trail=true;
image_index=3;
destroyOutside=false;


drawTag=false;
scaleTag=false;
exScale=image_xscale;

curveSpeed=0;
followDirection=0;

#endregion

#region Set the ance variables

Score = 1;
Type = "Collect";
Combo = 1;
//Type = "Collect" - a regular bullet that disappears and adds score upon collision with the player
//Type = "Hold" - a bullet that does not disappear and adds score for each frame it collides with the player. Use this for persistent spawner-type bullets.
//Hold bullets will only add combo every 5 frames rather than every frame.

//Specifying a negative score value makes the bullet lower the player's score, as well as reset the combo.


randomInd=0;
decay=1;
decaydrop=0.1;


ance_killer=true;
ance_alpha=1.0;

// UI
triangle_angle = 0;
triangle_speed = 1;

#endregion