SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	if player and player.mo.valid then
		player.pflags = $ & ~PF_DIRECTIONCHAR

		
		player.normalspeed = cc[pmo.skin].normalspeed or cc["default"].normalspeed
		pmo.health = cc[pmo.skin].health or cc["default"].health
		pmo.maxhealth = cc[pmo.skin].maxhealth or cc["default"].maxhealth
		player.charability = cc[pmo.skin].charability or cc["default"].charability
		player.jumpfactor = cc[pmo.skin].jumpfactor or cc["default"].jumpfactor
		
		if cc[pmo.skin] and cc[pmo.skin].actionspd then
			player.actionspd = cc[pmo.skin].actionspd
		end
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