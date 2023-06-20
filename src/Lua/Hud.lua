local modname = "srbz"

if not (rawget(_G, "customhud"))
	return;
end

customhud.SetupFont("STCFC", -1, 4);

local testhud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	customhud.CustomFontString(v, 160, 100, player.name, "STCFC", nil, "center", nil, player.skincolor) --(V_SNAPTOBOTTOM)
end

addHook("MapLoad", function()
	
end)


customhud.SetupItem("srbz_bottom", modname, testhud, "game", 0)