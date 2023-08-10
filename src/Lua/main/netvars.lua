addHook("NetVars", function(net)
	SRBZ.time_limit = net($);
	SRBZ.wait_time = net($);
	SRBZ.round_active = net($); -- stays on even if the end screen is on
	SRBZ.game_ended = net($);
	SRBZ.win_tics = net($); -- Increases if SRBZ.game_ended is true
	SRBZ.game_time = net($);
	SRBZ.team_won = net($);
	
	SRBZ.VoteTimeLimit = net($);
	SRBZ.MapsOnVote = net($);
	SRBZ.NextMapVoted = net($);
	
	for i,v in pairs(SRBZ.MapTimers) do
		v.map = net($)
		v.time = net($)
		v.active = net($)
		v.originaltime = net($)
	end
end)