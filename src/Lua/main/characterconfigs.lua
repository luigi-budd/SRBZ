SRBZ.SetCCtoplayer = function(player)
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	
	if cc[pmo.skin] then
		if cc[pmo.skin].normalspeed
			player.normalspeed = cc[pmo.skin].normalspeed
		else
			player.normalspeed = cc["default"].normalspeed
		end
		
		if cc[pmo.skin].health
			pmo.health = cc[pmo.skin].health
		else
			pmo.health = cc["default"].health
		end
		if cc[pmo.skin].maxhealth
			pmo.maxhealth = cc[pmo.skin].maxhealth 
		else
			pmo.maxhealth = cc["default"].maxhealth 
		end
		if cc[pmo.skin].charability
			player.charability = cc[pmo.skin].charability
		else
			player.charability = cc["default"].charability
		end
		
		if cc[pmo.skin].charability2
			player.charability2 = cc[pmo.skin].charability2
		else
			player.charability2 = cc["default"].charability2
		end
		
		if cc[pmo.skin].jumpfactor
			player.jumpfactor = cc[pmo.skin].jumpfactor
		else
			player.jumpfactor = cc["default"].jumpfactor
		end
		
		if cc[pmo.skin].actionspd then
			player.actionspd = cc[pmo.skin].actionspd
		end
	end
end

SRBZ.CharacterConfig = {
	["default"] = {
		normalspeed = 19 * FRACUNIT,
		sprintspeed = 23 * FRACUNIT,
		health = 80,
		maxhealth = 80,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		jumpfactor = 17 * FRACUNIT / 19,
	},
}

SRBZ.AddConfig = function(charname, table)
	SRBZ.CharacterConfig[charname] = table
end

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

SRBZ.AddConfig("tails", {
	normalspeed = 21 * FRACUNIT,
	sprintspeed = 27 * FRACUNIT,
	health = 95,
	maxhealth = 95,
	charability = CA_FLY,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 10*FRACUNIT,
})

SRBZ.AddConfig("knuckles", {
	normalspeed = 17 * FRACUNIT,
	sprintspeed = 24 * FRACUNIT,
	health = 155,
	maxhealth = 155,
	charability = CA_GLIDEANDCLIMB,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 12*FRACUNIT,
})

SRBZ.AddConfig("amy", {
	normalspeed = 20 * FRACUNIT,
	sprintspeed = 27 * FRACUNIT,
	health = 75,
	maxhealth = 75,
	charability = CA_TWINSPIN,
	charability2 = CA2_MELEE,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("fang", {
	normalspeed = 18 * FRACUNIT,
	sprintspeed = 24 * FRACUNIT,
	health = 85,
	maxhealth = 85,
	charability = CA_BOUNCE,
	charability2 = CA2_GUNSLINGER,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("metalsonic", {
	normalspeed = 17 * FRACUNIT,
	sprintspeed = 24 * FRACUNIT,
	health = 105,
	maxhealth = 105,
	charability = CA_JUMPBOOST,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
})