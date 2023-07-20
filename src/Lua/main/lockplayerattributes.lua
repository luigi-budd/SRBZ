addHook("PlayerThink", function(player)	
	if gametype ~= GT_SRBZ then return end
	
	if player.mo and player.mo.valid then
		if player.zteam == 2 and player.skin ~= "zzombie" then
			R_SetPlayerSkin(player, "zzombie")
			player.mo.color = SKINCOLOR_MOSS
		elseif player.zteam == 1 and player.skin == "zzombie" then
			R_SetPlayerSkin(player, "sonic")
			player.mo.color = player.skincolor
		end
	end
end)