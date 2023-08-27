SRBZ.mapinfohud = function(v, player)
	
	local mapinfo = mapheaderinfo[gamemap]
	
	if gametype ~= GT_SRBZ then return end
	customhud.CustomFontString(v,0,46*FU, mapinfo.lvlttl:sub(1,SRBZ.TWRITE_MAPNAME_COUNT), "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE)
	customhud.CustomFontString(v,0,54*FU, mapinfo.subttl:sub(1,SRBZ.TWRITE_COUNT), "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE)

end