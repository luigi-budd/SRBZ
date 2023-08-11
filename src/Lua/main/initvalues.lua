SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and player.mo.valid then
		SRBZ.SetCCtoplayer(player)
		SRBZ.SetCChealth(player)
	end
end

mobjinfo[MT_BLUECRAWLA].npc_name = "Blue Crawla"
mobjinfo[MT_BLUECRAWLA].npc_spawnhealth = {12,23}
mobjinfo[MT_BLUECRAWLA].npc_name_color = SKINCOLOR_BLUE
mobjinfo[MT_BLUECRAWLA].rubydrop = {3,6}
mobjinfo[MT_BLUECRAWLA].painsound = sfx_dmpain

mobjinfo[MT_REDCRAWLA].npc_name = "Red Crawla"
mobjinfo[MT_REDCRAWLA].npc_spawnhealth = {30,60}
mobjinfo[MT_REDCRAWLA].npc_name_color = SKINCOLOR_RED
mobjinfo[MT_REDCRAWLA].rubydrop = {6,10}
mobjinfo[MT_REDCRAWLA].painsound = sfx_dmpain

mobjinfo[MT_GOLDBUZZ].npc_name = "Gold Buzz"
mobjinfo[MT_GOLDBUZZ].npc_spawnhealth = {3,8}
mobjinfo[MT_GOLDBUZZ].npc_name_color = SKINCOLOR_GOLD
mobjinfo[MT_GOLDBUZZ].rubydrop = {1,5}
mobjinfo[MT_GOLDBUZZ].painsound = sfx_dmpain

mobjinfo[MT_REDBUZZ].npc_name = "Red Buzz"
mobjinfo[MT_REDBUZZ].npc_spawnhealth = {10,17}
mobjinfo[MT_REDBUZZ].npc_name_color = SKINCOLOR_RED
mobjinfo[MT_REDBUZZ].rubydrop = {5,7}
mobjinfo[MT_REDBUZZ].painsound = sfx_dmpain
