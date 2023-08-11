freeslot("MT_SHOPKEEPER")

mobjinfo[MT_SHOPKEEPER] = {
    doomednum = 861,
    spawnstate = S_PLAY_STND,
    spawnhealth = 1,
    radius = 32*FRACUNIT,
    height = 48*FRACUNIT,
    flags = MF_SOLID,
}

mobjinfo[MT_SHOPKEEPER].npc_name = "Shop Keeper"
mobjinfo[MT_SHOPKEEPER].npc_spawnhealth = {100,100}

addHook("MobjCollide", function(mo,pmo)
    if not pmo.player then
        return
    end
	if pmo.skin == "zzombie" then
        return
    end

    if not pmo.player.shop_open and not pmo.player.shop_delay then
        pmo.player.shop_open = true
        pmo.player.shop_person = mo
        pmo.player["srbz_info"].shop_selection = 1
    end
end, MT_SHOPKEEPER)


addHook("MobjSpawn", function(mobj)
    mobj.state = S_PLAY_STND

    local rand = P_RandomRange(1,8)

    -- due to srb2 limitations im just gonna elseif this
    -- and this is pretty wip so im gonna just clean this up later
    if rand == 1 then
        mobj.skin = "sonic"
        mobj.alias = "Sonic"
        mobj.color = SKINCOLOR_BLUE
    elseif rand == 2 then
        mobj.skin = "tails"
        mobj.alias = "Tail-less"
        mobj.color = SKINCOLOR_ORANGE
    elseif rand == 3 then
        mobj.skin = "knuckles"
        mobj.alias = "Knuckles"
        mobj.color = SKINCOLOR_RED
    elseif rand == 4 then
        mobj.skin = "amy"
        mobj.alias = "Amy"
        mobj.color = SKINCOLOR_ROSY
    elseif rand == 5 then
        mobj.skin = "fang"
        mobj.alias = "Fang"
        mobj.color = SKINCOLOR_LAVENDER
    elseif rand == 6 then
        mobj.skin = "metalsonic"
        mobj.alias = "Metal Sonic"
        mobj.color = SKINCOLOR_COBALT
    elseif rand == 7 then
        mobj.skin = "sonic"
        mobj.alias = "W"
        mobj.color = SKINCOLOR_WHITE
    elseif rand == 8 then
        mobj.skin = "fang"
        mobj.alias = "Bob"
        mobj.color = SKINCOLOR_YELLOW
    end
    mobj.shop = {}
    local shopitemcount = P_RandomRange(3,4)
    local itemlist = {1,2,3,6,7,8}
    for i=1,shopitemcount do
        local rng = P_RandomRange(1,#itemlist) 
        local choseitem = itemlist[rng]
        local item = SRBZ:CopyItemFromID(choseitem)

        table.remove(itemlist,rng) -- no repeating items

        local offset = P_SignedRandom()/16
        for tt=1,i do -- more rng?
            offset = P_SignedRandom()/16
        end
        mobj.shop[i] = {}
        mobj.shop[i][1] = item.price 
        mobj.shop[i][2] = item 
    end
    mobj.dontshowhealth = true

end,MT_SHOPKEEPER)

addHook("PlayerThink", function(player)
    if player.mo and player.mo.valid then
        if player.shop_person then
            local itemchoosing = player.shop_person.shop[player["srbz_info"].shop_selection][2]

            if not itemchoosing and player["srbz_info"].shop_confirmscreen then
                player["srbz_info"].shop_confirmscreen = false
                S_StartSound(nil, sfx_notadd, player)
            end
        end
        if player.shop_open == nil then
            player.shop_open = false
        end
        if player.shop_anim == nil then
            player.shop_anim = 0
        end

        if player.shop_open and player.shop_anim <= (35 + 35/2) then
            player.shop_anim = $ + 1
        elseif not player.shop_open and player.shop_anim then
            player.shop_anim = $ - 1
        end

        if SRBZ.game_ended then
            player.shop_anim = 0
            player.shop_open = false
        end

        if player.shop_anim == 0 then
            player.shop_person = nil
        end


    end
end)

addHook("PreThinkFrame", do
    for player in players.iterate do
        if player.mo and player.mo.valid and player["srbz_info"] then
            local szi = player["srbz_info"]
            local cmd = player.cmd

            if player.shop_open and not player.shop_delay and player.shop_person then
                if cmd.sidemove < -40 and not player["srbz_info"].shop_confirmscreen then
                    if not player["srbz_info"].shop_leftpressed then
                        S_StartSound(nil, sfx_s3kb7, player)
                        if player["srbz_info"].shop_selection - 1 <= 0 then
                            player["srbz_info"].shop_selection = #player.shop_person.shop
                        else
                            player["srbz_info"].shop_selection = $ - 1
                        end
                        player["srbz_info"].shop_leftpressed  = true
                    end
                else
                    player["srbz_info"].shop_leftpressed = false
                end
                
                if cmd.sidemove > 40 and not player["srbz_info"].shop_confirmscreen then
                    if not player["srbz_info"].shop_rightpressed then
                        S_StartSound(nil, sfx_s3kb7, player)
                        if player["srbz_info"].shop_selection + 1 > #player.shop_person.shop then
                            player["srbz_info"].shop_selection = 1
                        else
                            player["srbz_info"].shop_selection = $ + 1
                        end
                        player["srbz_info"].shop_rightpressed = true
                    end
                else
                    player["srbz_info"].shop_rightpressed = false
                end

                if (cmd.buttons & BT_SPIN) then
                    if not player["srbz_info"].shop_exitpressed then
                        --S_StartSound(nil, sfx_s3kb7, player)

                        if player["srbz_info"].shop_confirmscreen then
                            player["srbz_info"].shop_confirmscreen = false
                            S_StartSound(nil, sfx_notadd, player)
                        else
                            player.shop_open = false
                            player.shop_delay = TICRATE*2
                            player["srbz_info"].shop_exitpressed  = true
                        end
                    end
                else
                    player["srbz_info"].shop_exitpressed = false
                end

                if (cmd.buttons & BT_JUMP) and player.shop_person.shop and player.shop_person.shop[player["srbz_info"].shop_selection][2] then
                    if not player["srbz_info"].shop_selectpressed then
                        local hasrequiredrubies = player.rubies >= player.shop_person.shop[player["srbz_info"].shop_selection][1]

                        if hasrequiredrubies and not player["srbz_info"].shop_confirmscreen then
                            S_StartSound(nil, sfx_s3kb8, player)
                            player["srbz_info"].shop_confirmscreen = true
                        elseif player["srbz_info"].shop_confirmscreen and hasrequiredrubies then
                            player.rubies = $ - player.shop_person.shop[player["srbz_info"].shop_selection][1]
                            -- copied from SRBZ:FetchInventory()
                            if player["srbz_info"].survivor_inventory and player.zteam == 1 then
                                player["srbz_info"].survivor_inventory[player["srbz_info"].inventory_selection] = player.shop_person.shop[player["srbz_info"].shop_selection][2]
                            elseif player["srbz_info"].zombie_inventory and player.zteam == 2 then
                                player["srbz_info"].zombie_inventory[player["srbz_info"].inventory_selection] = player.shop_person.shop[player["srbz_info"].shop_selection][2]
                            else
                                error("Could not fetch inventory.",2)
                            end
                            S_StartSound(nil, sfx_s3kb8, player)
                            player["srbz_info"].shop_confirmscreen = false
                            player.shop_person.shop[player["srbz_info"].shop_selection][2] = nil
                        else
                            S_StartSound(nil, sfx_lose, player)
                        end
                        
                        player["srbz_info"].shop_selectpressed  = true
                    end
                else
                    player["srbz_info"].shop_selectpressed = false
                end

                cmd.buttons = 0
                cmd.forwardmove = 0
                cmd.sidemove = 0      
            end
            if player.shop_delay then
                player.shop_delay = $ - 1
            end
            
        end
    end
end)

addHook("PlayerSpawn", function(player)
    player.shop_open = false
    player.shop_anim = 0
end)
