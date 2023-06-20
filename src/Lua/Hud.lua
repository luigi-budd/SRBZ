local modname = "srbz"

if not (rawget(_G, "customhud"))
	return;
end

customhud.SetupFont("STCFC", -1, 4);

local testhud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	customhud.CustomFontString(v, 0, 190, player.name, "STCFC", (V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, player.skincolor) --
end

addHook("MapLoad", function()
	if gametype == GT_SRBZ
		customhud.disable("score")
		customhud.disable("time")
		customhud.disable("lives")
		customhud.disable("teamscores")
		customhud.disable("rings")
	else 
		customhud.enable("score")
		customhud.enable("time")
		customhud.enable("lives")
		customhud.enable("teamscores")
		customhud.enable("rings")
	end
end)


customhud.SetupItem("srbz_bottom", modname, testhud, "game", 0)