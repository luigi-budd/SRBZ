SRBZ.infohud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	
	customhud.CustomFontString(v, 0, 190, 
	player.name.." as "..skins[player.mo.skin].name, "STCFC", 
	(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, player.skincolor)
	
	customhud.CustomFontString(v, 0, 182, "Rubies: 10", "STCFC", 
	(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_CRIMSON)
end
