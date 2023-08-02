addHook("NetVars", function(net)
	SRBZ.survival_time = net($);
	SRBZ.swarm_time = net($);
	SRBZ.wait_time = net($);
	SRBZ.round_active = net($);
	SRBZ.onwinscreen = net($);
	SRBZ.wintics = net($);
	SRBZ.game_time = net($);
	
	
	SRBZ.WeaponPresets = net($); -- im just paranoid
end)