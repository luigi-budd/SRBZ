freeslot("sfx_eatapl")

SRBZ.WeaponPresets = {
	red_ring = {
		displayname = "Red Ring",
		object = MT_REDRING,
		icon = "RINGIND",
		firerate = 17,
		color = SKINCOLOR_RED,
		damage = 14,
	},
	auto_ring = {
		displayname = "Automatic Ring",
		object = MT_THROWNAUTOMATIC,
		icon = "AUTOIND",
		firerate = 5,
		color = SKINCOLOR_GREEN,
		damage = 3,
		flags2 = MF2_AUTOMATIC,
	},
	apple = {
		displayname = "Apple",
		icon = "APPLEIND",
		firerate = 35,
		color = SKINCOLOR_RED,
		sound = sfx_eatapl,
		onfire = function(player)
			SRBZ.ChangeHealth(player.mo, 5)
		end
	},
}

SRBZ.ChangeHealth = function(mobj, amount)
	if amount > mobj.maxhealth then
		mobj.health = mobj.maxhealth
	else
		mobj.health = $ + amount
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

	if inf.forcedamage ~= nil then
		dmg = inf.forcedamage
	end
	
	if mo.player then
		if mo.player.zteam == 1 then
			mo.player.powers[pw_flashing] = 35
			P_FlashPal(mo.player, PAL_NUKE, 2)
			S_StartSound(mo, sfx_s3kb9)
		elseif mo.player.zteam == 2 then
			local zombie_hurtsounds = {
				sfx_zpa1,
				sfx_zpa2,
			}
			local chosen_hurtsound = zombie_hurtsounds[P_RandomRange(1,2)]
			if inf and inf.valid then
				P_Thrust(mo, R_PointToAngle2(inf.x, inf.y, mo.x, mo.y), 20*FRACUNIT)
			end
			
			
			S_StartSound(mo, chosen_hurtsound)
		end
	elseif mobjinfo[mo.type].npc_name
		--print(mobjinfo[mo.type].npc_name)
		mo.state = mobjinfo[mo.type].painstate
		P_Thrust(mo, R_PointToAngle2(inf.x, inf.y, mo.x, mo.y), 20*FRACUNIT)
		--S_StartSound(mo, sfx_dmpain)
	end
	

	
	
	if dmg >= mo.health then
		P_KillMobj(mo,inf)
		return true
	end
	mo.health = $ - dmg -- fake damage i guess

	
	--sfx_dmpain
	--local speed1 = FixedHypot(FixedHypot(inf.momx, inf.momy), inf.momz)
	--P_SetObjectMomZ(mo, 5*FRACUNIT)
	--P_Thrust(mo, inf.angle, speed1*5)
	
	return true
end)

--ram into players as zombie
addHook("MobjMoveCollide", function(thing,tmthing)
	if (gametype ~= GT_SRBZ) return end
	if L_ZCollide(thing,tmthing) and tmthing.player and tmthing.player.zteam == 2 and thing.player
	and thing.player.zteam ~= 2 then
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
		if mobjinfo[mobj.type].spawnhealth and type(mobjinfo[mobj.type].npc_spawnhealth) == "table" then
			local rng_health = P_RandomRange(mobjinfo[mobj.type].npc_spawnhealth[1],mobjinfo[mobj.type].npc_spawnhealth[2])
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
		local cmd = player.cmd
		player["srbz_info"] = $ or {
			inventory_limit = 5,
			inventory_selection = 1,
			inventory = {
				[1] = SRBZ.WeaponPresets.red_ring,
				[2] = SRBZ.WeaponPresets.auto_ring,
				[3] = SRBZ.WeaponPresets.apple,
			},
			weapondelay = 0,
		}
		
		if #player["srbz_info"].inventory > player["srbz_info"].inventory_limit then
			table.remove(player["srbz_info"].inventory,#player["srbz_info"].inventory)
		end
		
		-- decrement
		if player["srbz_info"].weapondelay then
			player["srbz_info"].weapondelay = $ - 1
		end
		
		if player.zteam == 1 then 
			if (cmd.buttons & BT_WEAPONPREV) then
				if not player["srbz_info"].pressedprev then
					if player["srbz_info"].inventory_selection - 1 <= 0 then
						player["srbz_info"].inventory_selection = player["srbz_info"].inventory_limit
					else
						player["srbz_info"].inventory_selection = $ - 1
					end
					
					S_StartSound(nil,sfx_wepchg,player)
				end
			
				player["srbz_info"].pressedprev = true
			else
				player["srbz_info"].pressedprev = false
			end
		
			if (cmd.buttons & BT_WEAPONNEXT) then
				if not player["srbz_info"].pressednext then
				
					if player["srbz_info"].inventory_selection + 1 > player["srbz_info"].inventory_limit then
						player["srbz_info"].inventory_selection = 1
					else
						player["srbz_info"].inventory_selection = $ + 1
					end

					S_StartSound(nil,sfx_wepchg,player)
				end
				
				player["srbz_info"].pressednext = true
			else
				player["srbz_info"].pressednext = false	
			end
			
			-- TryShoot
			if (cmd.buttons & BT_ATTACK) and not player["srbz_info"].weapondelay 
			and player["srbz_info"].inventory[player["srbz_info"].inventory_selection] then
				
				-- Red Ring.
				local weaponinfo = player["srbz_info"].inventory[player["srbz_info"].inventory_selection]
				local ring
				
				if weaponinfo.object
					ring = P_SPMAngle(player.mo, weaponinfo.object, player.mo.angle, 1, weaponinfo.flags2)
				end
				
				if weaponinfo.onfire then
					weaponinfo.onfire(player,weaponinfo)
				end
				
				if weaponinfo.sound then
					S_StartSound(player.mo, weaponinfo.sound)
				end
				
				if ring then
					if weaponinfo.color ~= nil then
						ring.color = weaponinfo.color
					end 
					
					if weaponinfo.damage ~= nil then
						ring.forcedamage = weaponinfo.damage
					end
					
					if weaponinfo.thinker then
						ring.ringthinker = weaponinfo.thinker
					end
					
					if weaponinfo.onspawn then
						weaponinfo.onspawn(ring.target,ring,weaponinfo)
					end
					
					ring.weaponinfo = weaponinfo
				end

				player["srbz_info"].weapondelay = weaponinfo.firerate
			end	
		end
	end
end)

addHook("MobjThinker", function(mobj)
	if mobj and mobj.valid and mobj.ringthinker and mobj.target then
		mobj.ringthinker(mobj.target,mobj)
	end
end)