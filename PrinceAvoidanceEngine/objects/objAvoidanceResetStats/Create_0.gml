/// @desc
function reset_boss_stats(value)
{
	// Ance
	
	// Reset rank. score and combo 
	global.combo = 0;
	global.maxCombo = 0;
	global.hitScore = 0;
	global.comboMultiplier = 1;
	
	with objScoreSystemController
	{
		combo = 0;
		comboTimer = 0;
		combo_breaked = true;
		combo_multiplier_factor = 0;
	}
	
	// Avoidance 
	
	// Reset HP
	global.hp = global.hp_max;
	
	print("Boss stats reseted")
}


reset_boss_stats(reset_stats);