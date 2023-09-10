freeslot("sfx_zjump")

SRBZ.giveplayerflags = function(player)
	if gametype == GT_SRBZ then
		player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
		player.pflags = $ & ~PF_DIRECTIONCHAR
		player.pflags = $ & ~PF_ANALOGMODE 
		if player.sprintmeter == nil then
			player.sprintmeter = 100*FRACUNIT
		end
		if player.sprintmeter < 0 then
			player.sprintmeter = 0
		end
		player.isSprinting = $ or false
		SRBZ.SetCCtoplayer(player)
		if mapheaderinfo[gamemap].srbz_noabilities then
			player.pflags = $ & ~PF_GLIDING
			player.pflags = $ & ~PF_BOUNCING
			player.powers[pw_tailsfly] = 0
		end
	else 
		if leveltime < 2 then
			SRBZ.RevertChars(player) 
		end
	end
end

SRBZ.sprint_thinker = function(player)
	if not (player.mo and player.mo.valid) return end
		
	local cmd = player.cmd
	
	local pmo = player.mo
	local cc = SRBZ.CharacterConfig
	
	local increment = FRACUNIT/4
	local decrement = FRACUNIT/2
	if player.zteam == 1 then
		if (player.speed > 5*FRACUNIT) and (cmd.buttons & BT_CUSTOM1) then
			
			player.sprintmeter = $ - decrement
			if player.sprintmeter - decrement < 0 then
				player.sprintmeter = 0
			end
			
			player.isSprinting = true
			if player.sprintmeter == 0 then
				player.runspeed = 32000*FRACUNIT
			else
				player.runspeed = 5*FRACUNIT
				if player.speed >= 5*FRACUNIT and P_IsObjectOnGround(pmo) then
					P_SpawnSkidDust(player, 20*FRACUNIT)
					/*
					if (leveltime % 5) == 0 and not (pmo.eflags & MFE_UNDERWATER) then
						S_StartSound(pmo,sfx_s3kcel)
					end
					*/
				end
			end
		else
			
			player.sprintmeter = $ + increment
			if player.sprintmeter > 100*FRACUNIT or player.sprintmeter + increment > 100*FRACUNIT then
				player.sprintmeter = 100*FRACUNIT
			end
			
			player.isSprinting = false
			player.runspeed = 32000*FRACUNIT
		end
	else
		player.isSprinting = false
	end
end

addHook("LinedefExecute", function(line, mobj, sector)
	if mobj and mobj.valid and mobj.player and mobj.player.valid then
		local player = mobj.player
		
		player.pflags = $ & ~PF_GLIDING
		player.pflags = $ & ~PF_BOUNCING
		player.powers[pw_tailsfly] = 0
	end
end, "NOABILITY")

addHook("PlayerThink", function(player) -- Limit for climbing characters.
	if gametype ~= GT_SRBZ then return end
    if player.mo and player.mo.valid then
        player.x_climbtime = $ or 0 
        if player.climbing then
            player.x_climbtime = $ + 1
        elseif player.x_climbtime then
            player.x_climbtime = $ - 1  
            player.pflags = $ | PF_THOKKED
        end

        if player.x_climbtime > 2*TICRATE + TICRATE/2 then
            player.climbing = 0
        end
    end
end)

addHook("MobjThinker", function(mobj)
	if gametype ~= GT_SRBZ then return end
	if S_SoundPlaying(mobj, sfx_jump) then
		S_StopSoundByID(mobj, sfx_jump)
		S_StartSound(mobj, sfx_zjump)
	end
end, MT_PLAYER)