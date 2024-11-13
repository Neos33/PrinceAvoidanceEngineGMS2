// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function state() constructor {
	start = function() {};
	run = function() {};
	stop = function() {};
}
 
function run_state() {
	active_state.run();
}
 
function change_state(_state) {
	active_state.stop();
	active_state = _state;
	active_state.start();
}
 
function init_state(_state) {
	active_state = _state;
	active_state.start();
}


/*
--Create--
idle_state = new state();
idle_state.start = function()
idle_state.run = function()
{
	left ... right ... etc
}
init_state(idle_state);

--Step--
run_state();
*/
