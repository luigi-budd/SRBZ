SRBZ.giveplayerflags = function(player)
	player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
	player.pflags = $ & ~PF_DIRECTIONCHAR
end