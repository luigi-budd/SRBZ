SRBZ.mapinfohud = function(v, player)
	if not player.choosing then return end
	if gametype ~= GT_SRBZ then return end
	local mapinfo = mapheaderinfo[gamemap]

	local lvlttlY = 64*FU
	local subttlY = 72*FU
	
	if (SRBZ.TWRITE_MAPNAME_COUNT < mapinfo.lvlttl:len() and leveltime>10) then 
		customhud.CustomFontString(v,0,lvlttlY, mapinfo.lvlttl:sub(1,SRBZ.TWRITE_MAPNAME_COUNT).."_", "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_BLUE)
	elseif (leveltime>10) then
		customhud.CustomFontString(v,0,lvlttlY, mapinfo.lvlttl, "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_BLUE)
	end
	if (SRBZ.TWRITE_COUNT < mapinfo.subttl:len()) then
		customhud.CustomFontString(v,0,subttlY, mapinfo.subttl:sub(1,SRBZ.TWRITE_COUNT), "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE)
	else
		if ((leveltime%16)<8) then customhud.CustomFontString(v,0,subttlY, mapinfo.subttl.."_", "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE)
		else customhud.CustomFontString(v,0,subttlY, mapinfo.subttl, "STCFC", V_SNAPTOLEFT|V_SNAPTOTOP, nil, FU, SKINCOLOR_WHITE) end
	end
end