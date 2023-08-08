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