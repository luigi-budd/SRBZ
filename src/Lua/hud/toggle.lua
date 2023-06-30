SRBZ.togglehud = function(v, player)
	if gametype == GT_SRBZ and netgame
		hud.disable("score")
		hud.disable("time")
		hud.disable("lives")
		hud.disable("teamscores")
		hud.disable("rings")
	else 
		hud.enable("score")
		hud.enable("time")
		hud.enable("lives")
		hud.enable("teamscores")
		hud.enable("rings")
	end
end