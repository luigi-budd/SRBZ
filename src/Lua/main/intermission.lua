addHook("ThinkFrame", do
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end --stop the trolling
	
	if SRBZ.game_ended and SRBZ.win_tics == 10*TICRATE then
		for i=1,1035 do
			if mapheaderinfo[i] and (mapheaderinfo[i].typeoflevel & TOL_SRBZ) then
				print(mapheaderinfo[i].lvlttl)
			end
		end
		S_StartSound(nil,sfx_s3kb3)
	end
end)