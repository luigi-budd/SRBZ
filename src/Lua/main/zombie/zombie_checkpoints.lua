freeslot("MT_ZOMBIECHECKPOINT", "S_ZOMBIECHECKPOINT")
mobjinfo[MT_ZOMBIECHECKPOINT] = {
	doomednum = 862,
	spawnstate = S_ZOMBIECHECKPOINT,
	spawnhealth = 99999,
	flags = MF_NOBLOCKMAP|MF_NOCLIP|MF_NOGRAVITY|MF_NOCLIPHEIGHT,
}
states[S_ZOMBIECHECKPOINT] = {SPR_NULL, A, 1, nil, 0, 0, S_ZOMBIECHECKPOINT}

SRBZ.ZombieCheckpoints = {}
SRBZ.CurrentZombieCheckpoint = 0

SRBZ.CheckpointRally = function(checkpointnum)
	if SRBZ.ZombieCheckpoints[checkpointnum] then
		for player in players.iterate do
			if player.mo and player.mo.valid and player.valid and player.zteam == 2 then
				local destcheckpoint = SRBZ.ZombieCheckpoints[checkpointnum]
				P_SetOrigin(player.mo, destcheckpoint.x*FU, destcheckpoint.y*FU, destcheckpoint.z*FU)
				player.mo.angle = FixedAngle(destcheckpoint.angle*FRACUNIT)
			end
		end
	end
end

addHook("MapLoad", function()
	SRBZ.ZombieCheckpoints = {}
	SRBZ.CurrentZombieCheckpoint = 0
	for mapthing in mapthings.iterate do
		if mapthing.type ~= 862 then continue end
		
		SRBZ.ZombieCheckpoints[mapthing.pitch] = {
			x = mapthing.x,
			y = mapthing.y,
			z = mapthing.z,
			angle = mapthing.angle
		}
	end
end)

addHook("PlayerSpawn", function(player)
	if player.mo and player.mo.valid and player.zteam == 2 then
		if SRBZ.ZombieCheckpoints and SRBZ.CurrentZombieCheckpoint 
		and SRBZ.ZombieCheckpoints[SRBZ.CurrentZombieCheckpoint] and leveltime then
			local checkpoint = SRBZ.ZombieCheckpoints[SRBZ.CurrentZombieCheckpoint]
			
			P_SetOrigin(player.mo, checkpoint.x*FU, checkpoint.y*FU, checkpoint.z*FU)
			player.mo.angle = FixedAngle(checkpoint.angle*FRACUNIT)
		end
	end
end)

addHook("LinedefExecute", function(line, mobj, sector)
	if mobj and mobj.valid and mobj.player and mobj.player.valid then
		SRBZ.CurrentZombieCheckpoint = $ + 1
	end
end, "ZCHECKPOINT")