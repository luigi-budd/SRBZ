SRBZ.mapinfohud = function(v, player)
	if not player.choosing then return end
	if gametype ~= GT_SRBZ then return end
	local mapinfo = mapheaderinfo[gamemap]
	
	customhud.CustomFontString(v,0,46*FU, mapinfo.lvlttl:sub(1,SRBZ.TWRITE_MAPNAME_COUNT), "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_BLUE)
	customhud.CustomFontString(v,0,54*FU, mapinfo.subttl:sub(1,SRBZ.TWRITE_COUNT), "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE)
end