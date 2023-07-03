SRBZ.CharacterConfg = {
	["default"] = {
		normalspeed = 17 * FRACUNIT,
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
})
