-- health and maxhealth are identical values, I see no sense in declaring two of them
-- (perhaps players starting with lower hp?)

SRBZ.SetCCtoplayer = function(player)
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	
	if pmo and cc[pmo.skin] then
		if cc[pmo.skin].normalspeed then 
			player.normalspeed = cc[pmo.skin].normalspeed or cc["default"].normalspeed
			local sprintboost = cc[pmo.skin].sprintboost or cc["default"].sprintboost
			if (sprintboost) and (player.isSprinting and player.sprintmeter > 0) and (player.zteam == 1) then
				player.normalspeed = $ + sprintboost
			end
		end
		
		if (cc[pmo.skin].charability) then
			player.charability = cc[pmo.skin].charability
		else
			player.charability = cc["default"].charability 
		end
		
		if (cc[pmo.skin].charability2) then 
			player.charability2 = cc[pmo.skin].charability2
		else
			player.charability2 = cc["default"].charability2
		end
		
		if (cc[pmo.skin].jumpfactor) then 
			player.jumpfactor = cc[pmo.skin].jumpfactor
		else
			player.jumpfactor = cc["default"].jumpfactor
		end
		
		if (cc[pmo.skin].actionspd) then 
			player.actionspd = cc[pmo.skin].actionspd 
		end

		if (cc[pmo.skin].charflags) then 
			player.charflags = $|cc[pmo.skin].charflags 
		end
		
		if (cc[pmo.skin].speedcap) then 
			L_SpeedCap(pmo,cc[pmo.skin].speedcap)
		end
	end
end

SRBZ.SetCChealth = function(player)
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	if cc[pmo.skin] then
		if (cc[pmo.skin].health) then
			pmo.health = cc[pmo.skin].health
			pmo.maxhealth = pmo.health
		else
			pmo.health = cc["default"].health
			pmo.maxhealth = pmo.health
		end
	else
		pmo.health = cc["default"].health
		pmo.maxhealth = pmo.health
	end
end

SRBZ.CharacterConfig = {
	["default"] = {
		normalspeed = 19 * FRACUNIT,
		sprintspeed = 23 * FRACUNIT,
		health = 80,
		--maxhealth = 80,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		jumpfactor = 17 * FRACUNIT / 19,
		sprintboost = 6 * FRACUNIT,
	},
}

SRBZ.AddConfig = function(charname, table)
	SRBZ.CharacterConfig[charname] = table
	print("Added chararacter config: ".. charname)
end

SRBZ.AddConfig("zzombie", {
	normalspeed = 20 * FRACUNIT,
	health = 90,
	--maxhealth = 90,
	charability = CA_NONE,
	charability2 = CA2_NONE,
	jumpfactor = 22 * FRACUNIT / 19,
	actionspd = 9*FRACUNIT,
})

SRBZ.AddConfig("sonic", {
	normalspeed = 22 * FRACUNIT,
	health = 80,
	--maxhealth = 80,
	charability = CA_JUMPTHOK,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 9*FRACUNIT,
})

SRBZ.AddConfig("tails", {
	normalspeed = 21 * FRACUNIT,
	health = 95,
	--maxhealth = 95,
	charability = CA_FLY,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 35*FRACUNIT,
})

SRBZ.AddConfig("knuckles", {
	normalspeed = 17 * FRACUNIT,
	health = 120,
	--maxhealth = 120,
	charability = CA_GLIDEANDCLIMB,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 12*FRACUNIT,
})

SRBZ.AddConfig("amy", {
	normalspeed = 20 * FRACUNIT,
	health = 75,
	--maxhealth = 75,
	charability = CA_TWINSPIN,
	charability2 = CA2_MELEE,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("fang", {
	normalspeed = 18 * FRACUNIT,
	health = 85,
	--maxhealth = 85,
	charability = CA_BOUNCE,
	charability2 = CA2_GUNSLINGER,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("metalsonic", {
	normalspeed = 17 * FRACUNIT,
	health = 105,
	--maxhealth = 105,
	charability = CA_JUMPBOOST,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	charflags = SF_MACHINE
})

SRBZ.RevertChars = function(p)
	if not p.realmo then return end
	local s = p.realmo.skin
	p.charability=skins[s].ability
	p.charability2=skins[s].ability2
	p.actionspd=skins[s].actionspd
	p.charflags=skins[s].flags
	p.actionspd=skins[s].actionspd
	p.normalspeed=skins[s].normalspeed
	p.runspeed=skins[s].runspeed
	p.jumpfactor=skins[s].jumpfactor
	p.mindash=skins[s].mindash
	p.maxdash=skins[s].maxdash
end