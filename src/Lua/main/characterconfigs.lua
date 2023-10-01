-- health and maxhealth are identical values, I see no sense in declaring two of them
-- (perhaps players starting with lower hp?)

SRBZ.MobjTouchingPolyObj = function(mobj)
	for polyobj in polyobjects.iterate do
		if polyobj:mobjTouching(mobj) or polyobj:pointInside(mobj.x, mobj.y) then
			return true
		end
	end
	return false
end

SRBZ.SetCCtoplayer = function(player)
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	
	if pmo and pmo.valid and cc[pmo.skin] then
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
		
		if (cc[pmo.skin].speedcap) and not SRBZ.MobjTouchingPolyObj(pmo) then 
			local sprintboost = cc[pmo.skin].sprintboost or cc["default"].sprintboost
			if (sprintboost) and (player.isSprinting and player.sprintmeter > 0) and (player.zteam == 1) then
				L_SpeedCap(pmo,cc[pmo.skin].speedcap + sprintboost)
			else
				L_SpeedCap(pmo,cc[pmo.skin].speedcap)
			end
		end
	end
end

SRBZ.SetCChealth = function(player)
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	if pmo and pmo.valid then
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
end

SRBZ.SetZCtoplayer = function(player)
	local pmo = player.mo
	local zc = SRBZ.ZombieConfig
	local cc = SRBZ.CharacterConfig
	local ztype = player.ztype
	
	if pmo and pmo.valid then
		if zc[ztype] then
			if (zc[ztype].charability) then
				player.charability = zc[ztype].charability
			else
				player.charability = cc["default"].charability -- cc isnt a typo
			end
			
			if (zc[ztype].charability2) then 
				player.charability2 = zc[ztype].charability2
			else
				player.charability2 = cc["default"].charability2
			end
			
			if (zc[ztype].jumpfactor) then 
				player.jumpfactor = zc[ztype].jumpfactor
			else
				player.jumpfactor = cc["default"].jumpfactor
			end
			
			if (zc[ztype].actionspd) then 
				player.actionspd = zc[ztype].actionspd 
			end

			if (zc[ztype].charflags) then 
				player.charflags = $|zc[ztype].charflags 
			end
		else
			player.ztype = "normal"
		end
	end
end

SRBZ.SetZChealth = function(player)
	local pmo = player.mo
	local zc = SRBZ.ZombieConfig
	local cc = SRBZ.CharacterConfig
	local ztype = player.ztype
	
	if pmo and pmo.valid then
		if zc[ztype] then
			if (zc[ztype].health) then
				pmo.health = zc[ztype].health
				pmo.maxhealth = pmo.health
			else
				pmo.health = cc["default"].health -- cc still isnt a typo
				pmo.maxhealth = pmo.health
			end
		else
			pmo.health = cc["default"].health
			pmo.maxhealth = pmo.health
		end
	end
end

SRBZ.SetZCscale = function(player)
	local pmo = player.mo
	local zc = SRBZ.ZombieConfig
	local ztype = player.ztype
	
	if pmo and pmo.valid then
		if ztype and zc[ztype] then
			pmo.scale = zc[ztype].scale or FRACUNIT
		end
	end
end

SRBZ.SetZCinventory = function(player)
	local pmo = player.mo
	local zc = SRBZ.ZombieConfig
	local ztype = player.ztype
	
	if pmo and pmo.valid then
		if ztype and zc[ztype] and player["srbz_info"] then
			player["srbz_info"].zombie_inventory = zc[ztype].inventory or {}
			player["srbz_info"].zombie_inventory_limit = zc[ztype].inventory_limit or 2
		end
	end
end

SRBZ.ZombieConfig = {
	["normal"] = {
		skincolor = SKINCOLOR_MOSS,
		normalspeed = 22 * FRACUNIT,
		health = 90,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		jumpfactor = 25 * FRACUNIT / 19,
		actionspd = 9*FRACUNIT,
		inventory_limit = 1,
		inventory = {
			SRBZ:CopyItemFromID(ITEM_INSTA_BURST)
		},
		
	},
	["alpha"] = {
		skincolor = SKINCOLOR_ALPHAZOMBIE,
		normalspeed = 25 * FRACUNIT,
		health = 150,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		jumpfactor = 26 * FRACUNIT / 19,
		actionspd = 9*FRACUNIT,
		scale = 13*FRACUNIT/10,
		killaward = 10,
		inventory_limit = 2,
		inventory = {},
	},
}

SRBZ.CharacterConfig = {
	["default"] = {
		normalspeed = 19 * FRACUNIT,
		health = 80,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		jumpfactor = 17 * FRACUNIT / 19,
		sprintboost = 13 * FRACUNIT,
	},
}

SRBZ.AddConfig = function(charname, table)
	SRBZ.CharacterConfig[charname] = table
	print("Added chararacter config: ".. charname)
end

SRBZ.AddConfig("zzombie", {
	normalspeed = 20 * FRACUNIT,
	health = 90,
	charability = CA_NONE,
	charability2 = CA2_NONE,
	jumpfactor = 24 * FRACUNIT / 19,
	actionspd = 9*FRACUNIT,
})

SRBZ.AddConfig("sonic", {
	normalspeed = 19 * FRACUNIT,
	health = 50,
	charability = CA_JUMPTHOK,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 12*FRACUNIT,
})

SRBZ.AddConfig("tails", {
	normalspeed = 15 * FRACUNIT,
	health = 95,
	charability = CA_FLY,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 35*FRACUNIT,
})

SRBZ.AddConfig("knuckles", {
	normalspeed = 13 * FRACUNIT,
	health = 130,
	charability = CA_GLIDEANDCLIMB,
	charability2 = CA2_NONE,
	jumpfactor = 17 * FRACUNIT / 19,
	actionspd = 12*FRACUNIT,
})

SRBZ.AddConfig("amy", {
	normalspeed = 17 * FRACUNIT,
	health = 75,
	charability = CA_TWINSPIN,
	charability2 = CA2_MELEE,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("fang", {
	normalspeed = 16 * FRACUNIT,
	health = 85,
	charability = CA_BOUNCE,
	charability2 = CA2_GUNSLINGER,
	jumpfactor = 20 * FRACUNIT / 19,
})

SRBZ.AddConfig("metalsonic", {
	normalspeed = 14 * FRACUNIT,
	health = 105,
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