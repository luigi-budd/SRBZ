addHook("PlayerThink", function(player)	
	if gametype ~= GT_SRBZ or not player.mo return end
	
	if player.zteam == 2 and player.mo.skin ~= "zzombie" then
		R_SetPlayerSkin(player, "zzombie")
		player.mo.color = SKINCOLOR_MOSS
	elseif player.zteam == 1 and player.mo.skin == "zzombie" then
		R_SetPlayerSkin(player, "sonic")
		player.mo.color = player.skincolor
	end
		
	if (player.zteam == 2 and player.mo.color ~= SKINCOLOR_MOSS) player.mo.color = SKINCOLOR_MOSS end
		
	-- [ Keep Players From Exiting ] -- 
		
	/*
	if (not SRBZ.round_active and player.zteam == 2) player.exiting = 1
	else player.exiting = 0 end
	*/
end)