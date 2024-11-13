/// @desc
event_inherited();
surf1=surface_create(800,608);
surf2=surface_create(800,608);


t=0;

numShaders=2;

chain[0] = instance_create_depth(0,0,0,objPShaderChainElement);
chain[1] = instance_create_depth(0,0,0,objPShaderChainElement);
