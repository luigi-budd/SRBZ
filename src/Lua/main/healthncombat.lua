SRBZ.ItemPresets = {

}


function SRBZ:CreateItem(name,table)
	local temp_table
	if not name then
		error("Name not included.")
	end
	if type(name) ~= "string" then
		error("Arg1 is not a string.")
	end
	if not table then
		error("Table not found.")
	end
	if type(table) ~= "table" then
		error("Arg2 is not a table.")
	end
	temp_table = SRBZ:Copy(table) -- temp_table is supposed to add extra info before shipping.

	temp_table.item_id = #self.ItemPresets + 1
	temp_table.displayname = name
	local idname = ("WP_"..name:upper()):gsub(" ","_"):gsub("'","")
	local idglobal = rawset(_G, idname, #self.ItemPresets + 1)
	self.ItemPresets[#self.ItemPresets + 1] = temp_table
	
	print("\x84\SRBZ:".."\x82\ Weapon ".."\""..name.." ("..idname..")".."\" included ["..(#self.ItemPresets).."]")
	return idglobal
end


function SRBZ:FetchInventory(player)
	if player and player.valid then
		if player["srbz_info"] then
			if player["srbz_info"].survivor_inventory and player.zteam == 1 then
				return player["srbz_info"].survivor_inventory
			elseif player["srbz_info"].zombie_inventory and player.zteam == 2 then
				return player["srbz_info"].zombie_inventory
			else
				error("Could not fetch inventory.",2)
			end
		end
	end
end

function SRBZ:FetchInventoryLimit(player)
	if player and player.valid then
		if player["srbz_info"] then
			if player.zteam == 1 then
				return player["srbz_info"].survivor_inventory_limit
			elseif player.zteam == 2 then
				return player["srbz_info"].zombie_inventory_limit
			else
				error("Could not fetch inventory limit.",2)
			end
		end
	end
end

function SRBZ:FetchInventorySlot(player)
	if player and player.valid then
		if player["srbz_info"] then
			return SRBZ:FetchInventory(player)[player["srbz_info"].inventory_selection] 
		end
	end
end

function SRBZ:ChangeHealth(mobj, amount)
	if amount > mobj.maxhealth then
		mobj.health = mobj.maxhealth
	else
		mobj.health = $ + amount
	end
end

function SRBZ:IsInventoryFull(player)
	if player and player.valid then
		if player["srbz_info"] and SRBZ:FetchInventory(player) then
			if #SRBZ:FetchInventory(player) >= SRBZ:FetchInventoryLimit(player) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function SRBZ:SafeCopyItemFromID(item_id)
	local item = SRBZ.ItemPresets[item_id] or error("Invalid item_id.")
	for i,v in pairs(item) do -- You can't archive functions in netgame.
		if type(v) == "function" then
			v = nil
		end
	end
	return item
end

function SRBZ:GiveItem(player, item_id, count, slot) 
	if player and player.valid then
		if not item_id or not SRBZ.ItemPresets[item_id] then
			CONS_Printf(player, "\x85\Invalid item! ["..item_id.."]")
		elseif player["srbz_info"] and SRBZ:FetchInventory(player) then
			local item = SRBZ:Copy(SRBZ.ItemPresets[item_id])
			item.ontrigger = nil -- ontrigger not needed. we already fetch from SRBZ.ItemPresets
			for i,v in pairs(item) do -- You can't archive functions in netgame.
				if type(v) == "function" then
					v = nil
				end
			end
			if count ~= nil then
				item.count = count
				item.limited = true
			end
			if slot then
				SRBZ:FetchInventory(player)[slot] = item
			else
				if not SRBZ:IsInventoryFull(player) then
					table.insert(SRBZ:FetchInventory(player), item)
				else
					CONS_Printf(player, "\x85\Inventory full!")
				end
			end
		elseif not SRBZ:FetchInventory(player) then
			CONS_Printf(player, "\x85\Invalid inventory!")
		end
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
	if SRBZ.game_ended then return true end
	
	local knockback = 0
	
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
	
	if inf.forceknockback ~= nil then
		knockback = inf.forceknockback
	end
	
	if inf.weaponinfo and SRBZ.ItemPresets[inf.weaponinfo.item_id] and SRBZ.ItemPresets[inf.weaponinfo.item_id].onhit and inf.target then
		SRBZ.ItemPresets[inf.weaponinfo.item_id].onhit(inf.target, mo)
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
				P_Thrust(mo, inf.angle, 20*FRACUNIT)
			end
			
			
			S_StartSound(mo, chosen_hurtsound)
		end
	elseif mobjinfo[mo.type].npc_name
		--print(mobjinfo[mo.type].npc_name)
		mo.state = mobjinfo[mo.type].painstate
		P_Thrust(mo, inf.angle, knockback)
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

addHook("MobjDeath", function(mobj)
	if SRBZ.round_active and not SRBZ_game_ended and SRBZ.PlayerCount() > 1 then
		local player = mobj.player
		
		player.zteam = 2
	end
end,MT_PLAYER)

--ram into players as zombie
addHook("MobjMoveCollide", function(thing,tmthing)
	if (gametype ~= GT_SRBZ) return end
	if (SRBZ.game_ended) then return end
	if L_ZCollide(thing,tmthing) and tmthing.player and tmthing.player.zteam == 2 and thing.player
	and thing.player.zteam ~= 2 then
		local speed1 = FixedHypot(FixedHypot(tmthing.momx, tmthing.momy), tmthing.momz)
		local speed2 = FixedHypot(FixedHypot(thing.momx, thing.momy), thing.momz)
		
		if speed1 > speed2 and tmthing.player and tmthing.player.valid
		and not tmthing.player.powers[pw_flashing] then
			P_DamageMobj(thing, tmthing, nil, 15)
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
			inventory_selection = 1,

			survivor_inventory_limit = 5,
			zombie_inventory_limit = 3,
			
			survivor_inventory = {

			},
			zombie_inventory = {

			},
			
			weapondelay = 0,
			ghostmode = false,
			
			vote_selection = 1,
			voted = false,
			vote_leftpressed = false,
			vote_rightpressed = false,
			vote_selectpressed = false,
			vote_deselectpressed = false,

			shop_selection = 1,
			shop_leftpressed = false,
			shop_rightpressed = false,
			shop_selectpressed = false,
			shop_exitpressed = false,
		}
		
		if #SRBZ:FetchInventory(player) == 0 then
			if player.zteam == 1 then
				SRBZ:GiveItem(player, 1) 
				SRBZ:GiveItem(player, 3, 5) 
			elseif player.zteam == 2 then
				SRBZ:GiveItem(player, 5)
			end
		end
		
		if #SRBZ:FetchInventory(player) > SRBZ:FetchInventoryLimit(player) then
			table.remove(SRBZ:FetchInventory(player),#SRBZ:FetchInventory(player))
		end

		if player["srbz_info"].inventory_selection > SRBZ:FetchInventoryLimit(player) then
			player["srbz_info"].inventory_selection = SRBZ:FetchInventoryLimit(player)
		end
		
		-- decrement
		if player["srbz_info"].weapondelay then
			player["srbz_info"].weapondelay = $ - 1
		end
		
		if not SRBZ.game_ended and not player["srbz_info"].ghostmode then 
			if (cmd.buttons & BT_WEAPONPREV) and not player.choosing then
				if not player["srbz_info"].pressedprev then
					if player["srbz_info"].inventory_selection - 1 <= 0 then
						player["srbz_info"].inventory_selection = SRBZ:FetchInventoryLimit(player)
					else
						player["srbz_info"].inventory_selection = $ - 1
					end
					
					S_StartSound(nil,sfx_mnu1a,player)
				end
			
				player["srbz_info"].pressedprev = true
			else
				player["srbz_info"].pressedprev = false
			end
		
			if (cmd.buttons & BT_WEAPONNEXT) and not player.choosing then
				if not player["srbz_info"].pressednext then
				
					if player["srbz_info"].inventory_selection + 1 > SRBZ:FetchInventoryLimit(player) then
						player["srbz_info"].inventory_selection = 1
					else
						player["srbz_info"].inventory_selection = $ + 1
					end

					S_StartSound(nil,sfx_mnu1a,player)
				end
				
				player["srbz_info"].pressednext = true
			else
				player["srbz_info"].pressednext = false	
			end
			
			-- TryShoot
			
			if (cmd.buttons & BT_ATTACK) and not player["srbz_info"].weapondelay 
			and SRBZ:FetchInventorySlot(player) and player.playerstate ~= PST_DEAD then
				
				local weaponinfo = SRBZ:FetchInventorySlot(player)
				local ring
				
				if SRBZ.game_ended or player.choosing then 
					continue
				end

				if weaponinfo.object
					ring = P_SPMAngle(player.mo, weaponinfo.object, player.mo.angle, 1, weaponinfo.flags2)
				end
				
				if SRBZ.ItemPresets[weaponinfo.item_id].ontrigger and SRBZ.ItemPresets[weaponinfo.item_id].ontrigger(player,weaponinfo) == true then
					continue
				end
				
				player["srbz_info"].weapondelay = weaponinfo.firerate
				
				if weaponinfo.count ~= nil and weaponinfo.count > 0 and weaponinfo.limited == true then
					weaponinfo.count = $ - 1
				elseif weaponinfo.count ~= nil and weaponinfo.count <= 0 and weaponinfo.limited == true then
					continue
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
					
					if weaponinfo.knockback ~= nil then
						ring.forceknockback = weaponinfo.knockback
					end

					if SRBZ.ItemPresets[weaponinfo.item_id].onspawn then
						SRBZ.ItemPresets[weaponinfo.item_id].onspawn(ring.target,ring,weaponinfo)
					end
					
					local temp_weaponinfo = SRBZ:Copy(weaponinfo)

					for i,v in pairs(temp_weaponinfo) do -- You can't archive functions in netgame.
						if type(v) == "function" then
							v = nil
						end
					end

					ring.weaponinfo = temp_weaponinfo
				end

				
			end	
			
			-- clear items below 0 count
			for i=1,SRBZ:FetchInventoryLimit(player) do
				if SRBZ:FetchInventory(player)[i] then
					if SRBZ:FetchInventory(player)[i].limited and SRBZ:FetchInventory(player)[i].count <= 0 then
						table.remove(SRBZ:FetchInventory(player),i)
					end
				end
			end
			
		end
	end
end)

addHook("MobjThinker", function(mobj)
	if mobj and mobj.valid and mobj.weaponinfo and SRBZ.ItemPresets[mobj.weaponinfo.item_id] 
	and SRBZ.ItemPresets[mobj.weaponinfo.item_id].thinker and mobj.target then
		SRBZ.ItemPresets[mobj.weaponinfo.item_id].thinker(mobj.target,mobj)
	end
end)

COM_AddCommand("z_giveitem", function(player, item_id, count, slot)
	if player.mo and player.mo.valid and player["srbz_info"] and SRBZ:FetchInventory(player) then
		if item_id then
			item_id = tonumber($)
		else
			CONS_Printf(player, "z_giveitem <item_id> <count> <slot>: gives an item to yourself.")
			return
		end

		if count then
			count = tonumber($)
		end

		if slot then 
			slot = tonumber($)
		end

		SRBZ:GiveItem(player,item_id,count,slot)
	end
end, COM_ADMIN)