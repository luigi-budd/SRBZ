local modname = "srbz"

if not (rawget(_G, "customhud"))
	return;
end

customhud.SetupFont("STCFC", -1, 4);

local testhud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	customhud.CustomFontString(v, 0, 190, player.name.." as "..skins[player.mo.skin].name, "STCFC", (V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, player.skincolor) --
	customhud.CustomFontString(v, 0, 182, "Rubies: 10", "STCFC", (V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_CRIMSON)
end

local togglehud = function(v, player)
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

/*

*/
customhud.SetupItem("srbz_bottom", modname, testhud, "game", 0)
customhud.SetupItem("srbz_toggle", modname, togglehud, "game", 0)