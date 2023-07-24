SRBZ.ChangeHealth = function(mobj, amount)
	if amount > mobj.maxhealth then
		mobj.health = mobj.maxhealth
	else
		mobj.health = $ + ammount
	end
end

SRBZ.LimitMobjHealth = function(mobj)
	if mobj.health and mobj.maxhealth then
		if mobj.health > mobj.maxhealth then
			mobj.health = mobj.maxhealth
		end
	end
end

addHook("MobjDamage", function(mo, inf, src, dmg)
	if (gametype ~= GT_SRBZ) return end
	if inf and inf.player and mo and mo.player then
		if mo.player.zteam == inf.player.zteam then
			return true
		end
	end
	
	if src and src.player and mo and mo.player then
		if mo.player.zteam == src.player.zteam then
			return true
		end
	end


	if mo.player then
		mo.player.powers[pw_flashing] = 35
		P_FlashPal(mo.player, PAL_NUKE, 2)
		S_StartSound(mo, sfx_s3kb9)
		mo.health = $ - dmg
	elseif mobjinfo[mo.type].npc_name
		--print(mobjinfo[mo.type].npc_name)
		P_Thrust(mo, R_PointToAngle2(inf.x, inf.y, mo.x, mo.y), 20*FRACUNIT)
		return
		--S_StartSound(mo, sfx_dmpain)
	end
	
	
	if dmg >= mo.health then
		P_KillMobj(mo,inf)
		return true
	end
	--sfx_dmpain
	--local speed1 = FixedHypot(FixedHypot(inf.momx, inf.momy), inf.momz)
	--P_SetObjectMomZ(mo, 5*FRACUNIT)
	--P_Thrust(mo, inf.angle, speed1*5)
	
	return true
end)

addHook("MobjMoveCollide", function(thing,tmthing)
	if (gametype ~= GT_SRBZ) return end
	if L_ZCollide(thing,tmthing) and tmthing.player and tmthing.player.zteam == 2 then
		local speed1 = FixedHypot(FixedHypot(tmthing.momx, tmthing.momy), tmthing.momz)
		local speed2 = FixedHypot(FixedHypot(thing.momx, thing.momy), thing.momz)
		
		if speed1 > speed2 and tmthing.player and tmthing.player.valid
		and not tmthing.player.powers[pw_flashing] then
			P_DamageMobj(thing, tmthing, nil, 10)
		end
	end
end)

addHook("MobjSpawn", function(mobj)
	if gametype ~= GT_SRBZ then return end
	if mobjinfo[mobj.type].npc_name then
		if mobjinfo[mobj.type].min_spawnhealth and mobjinfo[mobj.type].max_spawnhealth 
		and type(mobjinfo[mobj.type].min_spawnhealth) == "number" 
		and type(mobjinfo[mobj.type].max_spawnhealth) == "number" then
			local rng_health = P_RandomRange(mobjinfo[mobj.type].min_spawnhealth,mobjinfo[mobj.type].max_spawnhealth)
			mobj.health = rng_health
			mobj.maxhealth = mobj.health
		else
			mobj.maxhealth = mobj.health
		end
	end
end)


addHook("PreThinkFrame", function()
	if gametype ~= GT_SRBZ then return end
	for player in players.iterate do
		if player.zteam == 2 then continue end
		player["srbz_weps"] = $ or {
			inventory = {},
			weapondelay = 0,
		}
		
		local cmd = player.cmd
		if player["srbz_weps"].weapondelay then
			player["srbz_weps"].weapondelay = $ - 1
		end
		
		if (cmd.buttons & BT_ATTACK) and not player["srbz_weps"].weapondelay then
			local ring = P_SpawnPlayerMissile(player.mo, MT_REDRING, nil)
			if ring then		
				ring.color = SKINCOLOR_RED
			end
			player["srbz_weps"].weapondelay = 8
		end
	end
end)