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

addHook("PlayerSpawn", function(player)
    player.shop_open = false
    player.shop_anim = 0
end)

COM_AddCommand("z_toggleshop", function(player)
    if player.mo and player.mo.valid then
        player.shop_open = not $
    end
end)