/**
	* Adds a timing for an avoidance attack named ``name`` that starts at time ``time``.
	* @param {string} name - The name of the attack.
	* @param {real} time - The time at which the attack starts, in frames.
*/
function avoidance_add_attack(name, time)
{
	ds_list_add(attackNames, name);
	ds_list_add(attackTimings, time);
	numTimings++;
}