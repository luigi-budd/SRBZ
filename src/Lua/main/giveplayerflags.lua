SRBZ.giveplayerflags = function(player)
	if gametype == GT_SRBZ then
		player.fixautomatic = $ or false
		player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
		player.pflags = $ & ~PF_DIRECTIONCHAR
		if player.fixautomatic then
			player.pflags = $ & PF_FORCESTRAFE
		end
		SRBZ.SetCCtoplayer(player)
		if mapheaderinfo[gamemap].srbz_noabilities then
			player.pflags = $ & ~PF_GLIDING
			player.pflags = $ & ~PF_BOUNCING
			player.powers[pw_tailsfly] = 0
		end
	else 
		if leveltime < 2 then
			SRBZ.RevertChars(player) 
		end
	end
end

addHook("LinedefExecute", function(line, mobj, sector)
	if mobj and mobj.valid and mobj.player and mobj.player.valid then
		local player = mobj.player
		
		player.pflags = $ & ~PF_GLIDING
		player.pflags = $ & ~PF_BOUNCING
		player.powers[pw_tailsfly] = 0
	end
end, "NOABILITY")

addHook("PlayerThink", function(player) -- Limit for climbing characters.
	if gametype ~= GT_SRBZ then return end
    if player.mo and player.mo.valid then
        player.x_climbtime = $ or 0 
        if player.climbing then
            player.x_climbtime = $ + 1
        elseif player.x_climbtime then
            player.x_climbtime = $ - 1  
            player.pflags = $ | PF_THOKKED
        end

        if player.x_climbtime > 2*TICRATE + TICRATE/2 then
            player.climbing = 0
        end
    end
end)

COM_AddCommand("z_fixautocam", function(player)
	player.fixautomatic = not $
	CONS_Printf(player, "z_fixautocam is now "..tostring(player.fixautomatic))
end)

addHook("PlayerMsg", function(source, ctype, target, msg)
	if ctype == 0 then
		if msg == "!autocam" then
			COM_BufInsertText(server, "say If your camera is bugged. Congratulations! You're a dumbass that uses the automatic camera option LMAO. Type z_fixautocam in console, and its fixed. But too bad! No abilities you dumb fuck.")
		end
	end
end)