SRBZ.giveplayerflags = function(player)
	if gametype ~= GT_SRBZ then return end
	player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
	player.pflags = $ & ~PF_DIRECTIONCHAR
	SRBZ.SetCCtoplayer(player)
end