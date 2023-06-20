if not (rawget(_G, "customhud"))
	return;
end
local modname = "srbz"

customhud.SetupFont("STCFC", -1, 4);

local testhud = function(v, player)
	customhud.CustomFontString(v, 160, 100, player.name, "STCFC", nil, "center", nil, player.skincolor) --(V_SNAPTOBOTTOM)
end

customhud.SetupItem("srbz_bottom", modname, testhud, "game", 0)

addHook("MapLoad", function()
	if gametype == GT_SRBZ then
	
	else
	
	end
end)