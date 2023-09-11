addHook("PlayerSpawn", function(player)
	if gametype ~= GT_SRBZ then
		return 
	end
	
	if (SRBZ.round_active and SRBZ.PlayerCount() > 1) then 
		player.zteam = 2
	else 
		player.zteam = 1
	end
	
	if player.zteam == 2 then 
		R_SetPlayerSkin(player, "zzombie") 
	end
	
	player.sprintmeter = 100*FRACUNIT
end)

addHook("ViewpointSwitch", function(player, nextplayer)
	if player.spectator then
		return
	end
	if nextplayer.zteam ~= player.zteam then
		return false
	end
end)

addHook("MobjDeath", function(mobj)
	if SRBZ.round_active and not SRBZ_game_ended and 
	((SRBZ.PlayerCount() > 1) or (mapheaderinfo[gamemap].srbz_solofail)) then
		mobj.player.zteam = 2
	end
end,MT_PLAYER)
