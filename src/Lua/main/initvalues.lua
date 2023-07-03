SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and player.mo.valid then
		
		SRBZ.SetCCtoplayer(player)
	end
end

--58637.4736842/65536


/*
SRBZ.CharacterConfg
SRBZ.AddConfig("sonic", {
	normalspeed = 22 * FRACUNIT,
	sprintspeed = 29 * FRACUNIT,
	health = 80,
	maxhealth = 80,
	charability = CA_JUMPTHOK,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 9*FRACUNIT,
})
*/