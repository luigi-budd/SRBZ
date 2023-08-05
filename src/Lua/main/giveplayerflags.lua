SRBZ.giveplayerflags = function(player)
	if gametype == GT_SRBZ then
		player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
		player.pflags = $ & ~PF_DIRECTIONCHAR
		SRBZ.SetCCtoplayer(player)
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