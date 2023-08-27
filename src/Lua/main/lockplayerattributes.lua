addHook("PlayerThink", function(player)	
	if gametype ~= GT_SRBZ or not player.mo return end
	
	if player.zteam == 2 and player.mo.skin ~= "zzombie" then
		R_SetPlayerSkin(player, "zzombie")
		player.mo.color = SKINCOLOR_MOSS
	elseif player.zteam == 1 and player.mo.skin == "zzombie" then
		R_SetPlayerSkin(player, "sonic")
		player.mo.color = player.skincolor
	end
		
	if (player.zteam == 2 and player.mo.color ~= SKINCOLOR_MOSS) then 
		player.mo.color = SKINCOLOR_MOSS 
	end
end)