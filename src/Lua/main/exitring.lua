freeslot("MT_CRRING","S_CRRING") 

mobjinfo[MT_CRRING]= {
	doomednum = -1,
	spawnstate = S_CRRING,
	spawnhealth = 1,
	deathstate = S_SPRK1,
	deathsound = sfx_itemup,
	radius = 32*FU,
	height = 48*FU,
	flags = MF_SLIDEME|MF_SPECIAL|MF_NOGRAVITY|MF_NOCLIPHEIGHT,
}

states[S_CRRING] = {
	sprite = SPR_RING,
	frame = FF_FULLBRIGHT|FF_ANIMATE|A,
	tics = -1,
	var1 = 23,
	var2 = 1,
	nextstate = S_CRRUBY,
}

addHook("MobjSpawn", function(mobj)
	mobj.scale = $ * 4
end, MT_CRRING)

addHook("TouchSpecial", function(special,toucher)
	if toucher and toucher.valid and toucher.player and toucher.player.valid then
		print("Hit end ring")
		return true
	end
end, MT_CRRING)