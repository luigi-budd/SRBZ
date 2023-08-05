freeslot("MT_CRRING","S_CRRING") 

mobjinfo[MT_CRRING]= {
	doomednum = 860,
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
	frame = FF_FULLBRIGHT|FF_ANIMATE|FF_ADD|A,
	tics = -1,
	var1 = 23,
	var2 = 1,
	nextstate = S_CRRUBY,
}

addHook("MobjSpawn", function(mobj)
	mobj.scale = $ * 4
	mobj.colorized = true
	mobj.color = SKINCOLOR_BLUE
end, MT_CRRING)

addHook("TouchSpecial", function(special,toucher)
	if toucher and toucher.valid and toucher.player and toucher.player.valid then
		local player = toucher.player
		
		if not player["srbz_info"].ghostmode and not SRBZ.game_ended and SRBZ.round_active then
			player["srbz_info"].ghostmode = true
			for d=0,16 do
				P_SpawnParaloop(toucher.x, toucher.y, toucher.z+toucher.height, FixedMul(192*FRACUNIT, toucher.scale), 16, MT_NIGHTSPARKLE, i*ANGLE_22h, S_NULL, true)
			end
			S_StartSound(nil,sfx_s3kb3)
			SRBZ.StartWin(player.zteam)
		end
		
		return true
	end
end, MT_CRRING)

addHook("ThinkFrame", function()
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end --stop the trolling
	if SRBZ.PlayerCount() > 1 and SRBZ.SurvivorCount() == 0 and not SRBZ.game_ended then
		SRBZ.StartWin(2)
	end
end)