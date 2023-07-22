SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and player.mo.valid then
		SRBZ.SetCCtoplayer(player)
		SRBZ.SetCChealth(player)
	end
end

mobjinfo[MT_BLUECRAWLA].npc_name = "Blue Crawla"
mobjinfo[MT_BLUECRAWLA].min_spawnhealth = 2
mobjinfo[MT_BLUECRAWLA].max_spawnhealth = 7

mobjinfo[MT_REDCRAWLA].npc_name = "Red Crawla"
mobjinfo[MT_REDCRAWLA].min_spawnhealth = 5
mobjinfo[MT_REDCRAWLA].max_spawnhealth = 12