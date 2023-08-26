SRBZ.mapinfohud = function(v, player)
	local mapinfo = mapheaderinfo[gamemap]
	if mapinfo and mapinfo.subttl then
		local timeToFinish = TICRATE*3
		local lengthOfSubtitle = mapinfo.subttl:len()
		print(lengthOfSubtitle)
		if leveltime <= timeToFinish then
			if (timeToFinish%lengthOfSubtitle) == 0  then
				S_StartSound(nil, sfx_oldrad)
			end
		end
	end
end