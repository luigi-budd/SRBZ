freeslot("MT_SHOPKEEPER")
freeslot("SPR_TAK1")

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
mobjinfo[MT_SHOPKEEPER].disablehealthhud = true

SRBZ.ShopkeeperList={
    {
        ["name"]="Sonic", --Shopkeeper's name, this string is also shown when you come close to him
        ["skin"]="sonic", --mobj_t.skin
        ["color"]=SKINCOLOR_BLUE, --mobj_t.color
        ["phrases"]={ --phrases, these supposed to appear when you do shoping
            "Escaping from Zombies, huh?",
            "Hope these items will help", --I suck at making quotes
            "Remember, never step back!"
        }
    },
    {
        ["name"]="Tail-less",
        ["skin"]="tails",
        ["color"]=SKINCOLOR_ORANGE,
        ["phrases"]={
            "Yes, I am the Tail-less fox",
            "Awwww... I am afraid of Zomibes...",
            "Let's look what I have..."
        }
    },
    {
        ["name"]="Knuckles",
        ["skin"]="knuckles",
        ["color"]=SKINCOLOR_RED,
        ["phrases"]={
            "I feel some strange energy around...",
            "Take any of these, they will help you",
            "Found these goodies on my treasure hunting..."
        }
    },
    {
        ["name"]="Amy",
        ["skin"]="amy",
        ["color"]=SKINCOLOR_ROSY,
        ["phrases"]={
            "Have no fear. Amy Rose is here!",
            "These items will definetly help you",
            "I wonder what happened to my darling Sonic..."
        }
    },
    {
        ["name"]="Fang",
        ["skin"]="fang",
        ["color"]=SKINCOLOR_LAVENDER,
        ["phrases"]={
            "Naghhhhh...! I hate these Zombies!",
            "Good defence never hurts",
            "Undeads will beg for mercy with these items"
        }
    },
    {
        ["name"]="Metal Sonic",
        ["skin"]="metalsonic",
        ["color"]=SKINCOLOR_COBALT,
        ["phrases"]={
            "*CLIENT DETECTED. ACTIVATING SHOP*",
            "*ENTRING SELLING MODE*",
            "*I AM THE REAL SONIC!*"
        }
    },
    {
        ["name"]="W",
        ["skin"]="sonic",
        ["color"]=SKINCOLOR_WHITE,
        ["phrases"]={
            "Hey! Welcome to my shop!",
            "W?",
            "Some idiot made phrases for me, they have to be replaced..."
        }
    },
    {
        ["name"]="Bob",
        ["skin"]="fang",
        ["color"]=SKINCOLOR_YELLOW,
        ["phrases"]={
            "Ahoy stranger!",
            "Take any of these and get out of this place!",
            "I hope you have enough rupies to take something with you..."
        }
    },
	{
        ["name"]="Takis",
        ["skin"]="sonic",
        ["color"]=SKINCOLOR_GREEN,
        ["phrases"]={
			"Cheap items for high prices.",
			"I'm not gonna say the line, dork!",
			"It's Sale Hour!",
			"i want summa dat"
        },
		["forcesprite"] = SPR_TAK1,
    }
}

SRBZ.AddShopkeeper = function(name, skin, color, phrases)
    if (not name) then error("Shopkeeper needs a name!") end
    if (not skin) then error("Shopkeeper's skin is not specified") end
    if (not color) then error("Shopkeeper's SKINCOLOR_* color is not specified") end
    if (type(name)!="string") then error("Name should be a string") end
    if (type(skin)!="string") then error("Skin should be a string name of a skin") end
    if (not skins[skin]) then error("Shopkeeper's specified skin does not exist!") end
    if (type(color)!="number") then error("Color should be a SKINCOLOR_* value") end
    if (phrases and type(phrases)!="table") error("phrases should be a table of strings") end
    table.insert(SRBZ.ShopkeeperList, {
        ["name"]=name,
        ["skin"]=skin,
        ["color"]=color,
        ["phrases"]=phrases
    })
    print("Added \""..name.."\" ("..skincolors[color].name.." "..skin..") as a Shopkeeper to the SRBZ")
end

addHook("MobjCollide", function(mo,pmo)
    if not pmo.player then
        return
    end
	if pmo.skin == "zzombie" then
        return
    end
    if not pmo.player.shop_open and not pmo.player.shop_delay then
        pmo.player.shop_open = true
        mo.phrase=P_RandomKey(#mo.phrases)+1 --random phrase to be shown on the screen
        pmo.player.shop_person = mo
        pmo.player["srbz_info"].shop_selection = 1
    end
end, MT_SHOPKEEPER)

addHook("MobjThinker", function(mobj)
	if mobj.shopid and SRBZ.ShopkeeperList[mobj.shopid]["forcesprite"] then
		mobj.sprite = SRBZ.ShopkeeperList[mobj.shopid]["forcesprite"]
		mobj.tics = 2500000 -- dont be cringe
	end
end, MT_SHOPKEEPER)

addHook("MobjSpawn", function(mobj)
    mobj.state = S_PLAY_STND

    local rand = P_RandomRange(1,#SRBZ.ShopkeeperList)

	mobj.shopid = rand
    mobj.alias=SRBZ.ShopkeeperList[rand]["name"]
    mobj.skin=SRBZ.ShopkeeperList[rand]["skin"]
    mobj.color=SRBZ.ShopkeeperList[rand]["color"]
    mobj.phrases=SRBZ.ShopkeeperList[rand]["phrases"]

    mobj.shop = {}
    local itemlist = {}
	for i=1,#SRBZ.ItemPresets do
		if SRBZ.ItemPresets[i] and SRBZ.ItemPresets[i].price then
			table.insert(itemlist, i)
		end
	end
    for i=1,P_RandomRange(3,4) do
        local rng = P_RandomRange(1,#itemlist) 
        local choseitem = itemlist[rng]
        local item = SRBZ:CopyItemFromID(choseitem)

        table.remove(itemlist,rng) -- no repeating items

        --local offset = P_SignedRandom()>>4 --unused idea I guess?
        --for tt=1,i do -- more rng?
        --    offset = P_SignedRandom()>>4
        --end
        mobj.shop[i] = {}
        mobj.shop[i][1] = item.price 
        mobj.shop[i][2] = item
    end
end,MT_SHOPKEEPER)

addHook("PlayerThink", function(player)
    if player.mo and player.mo.valid then
        if player.shop_person and player.shop_person.shop then
            local itemchoosing = player.shop_person.shop[player["srbz_info"].shop_selection][2]

            if not itemchoosing and player["srbz_info"].shop_confirmscreen then
                player["srbz_info"].shop_confirmscreen = false
                S_StartSound(nil, sfx_notadd, player)
            end
        end
        if not player.shop_open then
            player.shop_open = false
        end
        if not player.shop_anim then
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
                        if (player["srbz_info"].shop_selection - 1 <= 0) then player["srbz_info"].shop_selection = #player.shop_person.shop
                        else player["srbz_info"].shop_selection = $ - 1 end
                        player["srbz_info"].shop_leftpressed  = true
                    end
                else player["srbz_info"].shop_leftpressed = false end
                
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
                else player["srbz_info"].shop_rightpressed = false end

                if (cmd.buttons & BT_SPIN) then
                    if not player["srbz_info"].shop_exitpressed then
                        --S_StartSound(nil, sfx_s3kb7, player)

                        if player["srbz_info"].shop_confirmscreen then
                            player["srbz_info"].shop_confirmscreen = false
                            S_StartSound(nil, sfx_notadd, player)
                        else
                            player.shop_open = false
                            player.shop_delay = TICRATE*2   
                        end
                        player["srbz_info"].shop_exitpressed  = true
                    end
                else player["srbz_info"].shop_exitpressed = false end

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
                                if SRBZ:IsInventoryFull(player) then
                                    player["srbz_info"].survivor_inventory[player["srbz_info"].inventory_selection] =  player.shop_person.shop[player["srbz_info"].shop_selection][2]
                                else
                                    table.insert(player["srbz_info"].survivor_inventory, player.shop_person.shop[player["srbz_info"].shop_selection][2])
                                end
                            elseif player["srbz_info"].zombie_inventory and player.zteam == 2 then
                                if SRBZ:IsInventoryFull(player) then
                                    player["srbz_info"].zombie_inventory[player["srbz_info"].inventory_selection] = player.shop_person.shop[player["srbz_info"].shop_selection][2]
                                else
                                    table.insert(player["srbz_info"].zombie_inventory, player.shop_person.shop[player["srbz_info"].shop_selection][2])
                                end
                            else error("Could not fetch inventory.",2) end
                            S_StartSound(nil, sfx_s3kb8, player)
                            player["srbz_info"].shop_confirmscreen = false
                            player.shop_person.shop[player["srbz_info"].shop_selection][2] = nil
                        else S_StartSound(nil, sfx_lose, player) end
                        
                        player["srbz_info"].shop_selectpressed  = true
                    end
                else player["srbz_info"].shop_selectpressed = false end

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

addHook("PlayerSpawn", function(p)
    p.shop_open = false
    p.shop_anim = 0
end)