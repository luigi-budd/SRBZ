SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and player.mo.valid then
		SRBZ.SetCCtoplayer(player)
		SRBZ.SetCChealth(player)
	end
end
