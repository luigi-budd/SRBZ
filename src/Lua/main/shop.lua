freeslot("MT_SHOPKEEPER")

mobjinfo[MT_SHOPKEEPER] = {
    doomednum = -1,
    spawnstate = S_PLAY_STND,
    spawnhealth = 1,
    radius = 32*FRACUNIT,
    height = 48*FRACUNIT,
    flags = MF_SOLID,
}
mobjinfo[MT_SHOPKEEPER].npc_name = "Shop Keeper"
mobjinfo[MT_SHOPKEEPER].npc_spawnhealth = {100,100}

SRBZ.Shops = {
    ["sonic"] = {
        SRBZ:SafeCopyItemFromID(1),
    },
    ["tails"] = {


    },
    ["knuckles"] = {


    },
    ["amy"] = {


    },
    ["fang"] = {


    },
    ["metalsonic"] = {


    },
    ["w"] = {


    },
    ["bob"] = {


    },
}

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
        mobj.alias = "Tails"
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

    mobj.dontshowhealth = true

end,MT_SHOPKEEPER)

addHook("PlayerThink", function(player)
    if player.mo and player.mo.valid then
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



    end
end)

addHook("PreThinkFrame", do
    for player in players.iterate do
        if player.mo and player.mo.valid and player["srbz_info"] then
            local szi = player["srbz_info"]
            local cmd = player.cmd

            if player.shop_open then
                if cmd.sidemove < -40 then
                    if not player["srbz_info"].shop_leftpressed then
                        S_StartSound(nil, sfx_s3kb7, player)
                        if player["srbz_info"].shop_selection - 1 <= 0 then
                            player["srbz_info"].shop_selection = 3
                        else
                            player["srbz_info"].shop_selection = $ - 1
                        end
                        player["srbz_info"].shop_leftpressed  = true
                    end
                else
                    player["srbz_info"].shop_leftpressed = false
                end
                
                if cmd.sidemove > 40 then
                    if not player["srbz_info"].shop_rightpressed then
                        S_StartSound(nil, sfx_s3kb7, player)
                        if player["srbz_info"].shop_selection + 1 > 3 then
                            player["srbz_info"].shop_selection = 1
                        else
                            player["srbz_info"].shop_selection = $ + 1
                        end
                        player["srbz_info"].shop_rightpressed  = true
                    end
                else
                    player["srbz_info"].shop_rightpressed = false
                end

                cmd.buttons = 0
                cmd.forwardmove = 0
                cmd.sidemove = 0      
            end
        end
    end
end)

addHook("PlayerSpawn", function(player)
    player.shop_open = false
    player.shop_anim = 0
end)

COM_AddCommand("z_toggleshop", function(player)
    if player.mo and player.mo.valid then
        player.shop_open = not $
    end
end)