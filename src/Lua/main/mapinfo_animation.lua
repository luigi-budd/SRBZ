SRBZ.TWRITE_COUNT = 0

SRBZ.TWRITE_MAPNAME_COUNT = 0

addHook("ThinkFrame", function()
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end
	local mapinfo = mapheaderinfo[gamemap]
	
	if mapinfo and leveltime > 20 then
		local lengthOfSubtitle = mapinfo.subttl:len()
		local lengthOfTitle = mapinfo.lvlttl:len()
		if SRBZ.TWRITE_MAPNAME_COUNT < lengthOfTitle then
			SRBZ.TWRITE_MAPNAME_COUNT = $ + 1
			S_StartSound(nil, sfx_oldrad)
			--print(mapinfo.lvlttl:sub(1,SRBZ.TWRITE_MAPNAME_COUNT))
		elseif SRBZ.TWRITE_COUNT < lengthOfSubtitle
			SRBZ.TWRITE_COUNT = $ + 1
			S_StartSound(nil, sfx_oldrad)
			--print(mapinfo.subttl:sub(1,SRBZ.TWRITE_COUNT))
		end
	end
end)


addHook("MapLoad", function()
	SRBZ.TWRITE_COUNT = 0 -- subtitle
	SRBZ.TWRITE_MAPNAME_COUNT = 0 -- title
end)