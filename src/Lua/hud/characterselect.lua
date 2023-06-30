local blacklisted = {}
local iconscale = CV_RegisterVar({
	name = "iconscale" ,
	defaultvalue = "1.25",
	flags = CV_FLOAT|CV_HIDDEN, 
	PossibleValue = CV_Natural,
})

local sel_iconscale = CV_RegisterVar({
	name = "sel_iconscale" ,
	defaultvalue = "1.25",
	flags = CV_FLOAT|CV_HIDDEN,
	PossibleValue = CV_Natural,
})

local round_active = false

local function getSkinNames(player, getunlockables, timesrepeated)
    local list = {}
	local tr_real = 1
	if timesrepeated and timesrepeated > 0 then
		tr_real = timesrepeated
	end
	for tr=1,tr_real do
		for i=0,31 do
			if not skins[i] then
				continue
			end
			local isblacklisted = false
			for _,v in ipairs(blacklisted) do
				if v == skins[i].name then
					isblacklisted = true
				end
			end
			if isblacklisted then
				continue
			end
			if getunlockables then
				table.insert(list, skins[i].name)
			else -- Default 
				if R_SkinUsable(player, skins[i].name) then
					table.insert(list, skins[i].name)
				end
			end
		end
	end
    return list
end

local function getSkinNums(player, getunlockables, timesrepeated)
    local list = {}
	local tr_real = 1
	if timesrepeated and timesrepeated > 0 then
		tr_real = timesrepeated
	end
	for tr=1,tr_real do
		for i=0,31 do
			if not skins[i] then
				continue
			end
			local isblacklisted = false
			for _,v in ipairs(blacklisted) do
				if v == skins[i].name then
					isblacklisted = true
				end
			end
			if isblacklisted then
				continue
			end
			if getunlockables then
				table.insert(list, i)
			else -- Default 
				if R_SkinUsable(player, skins[i].name) then
					table.insert(list, i)
				end
			end
		end
	end
    return list
end

addHook("MapLoad", function()
	for player in players.iterate do
		player.choosing = true
		player.chosecharacter = false
	end
end)

SRBZ.charselectmenu = function()
	for player in players.iterate do
		if player.mo and player.mo.valid then
			local cmd = player.cmd
			local buttons = cmd.buttons
			local left = cmd.sidemove < -40
			local right = cmd.sidemove > 40
			local skincount = #getSkinNames(player, true) + 1
			local selection_name = getSkinNames(player, true)[player.selection]
			
			if (buttons & BT_JUMP) and player.choosing and not player.chosecharacter then
				buttons = 0
				player.choosing = false
				player.chosecharacter = true
				if R_SkinUsable(player, selection_name) then
					R_SetPlayerSkin(player, selection_name)
				else
					R_SetPlayerSkin(player, "sonic")
					
				end
				
				S_StartSound(nil, sfx_strpst, player)
			end
			
			if round_active then
				player.choosing = false
				player.chosecharacter = true
			end
			
			if not round_active and not player.choosing and not player.chosecharacter then -- Where's your stats?
				player.choosing = true
				player.chosecharacter = false
				player.selection = 1		
			elseif not round_active and player.choosing and not player.chosecharacter then -- Stay Still while you're choosing and have not chosen
				player.pflags = $|PF_FULLSTASIS
			
				buttons = 0
			end
			


			if player.selection <= 0 then
				player.selection = 1
			elseif player.selection > skincount then
				player.selection = skincount
			end
			
			if player.choosing and not player.chosecharacter then
				if left then
					if not player.pressedleft then
						if player.selection - 1 > 0 then
							player.selection = $ - 1
							S_StartSound(nil, sfx_s3kb7, player)
						else
							player.selection = skincount - 1
							S_StartSound(nil, sfx_s3kb7, player)
						end
					end
					player.pressedleft = true
				else
					player.pressedleft = false
				end
				
				
				if right then
					if not player.pressedright then
						if player.selection + 1 < skincount then
							player.selection = $ + 1
						else
							player.selection = 1
						end
						S_StartSound(nil, sfx_s3kb7, player)
					end
					player.pressedright = true
				else
					player.pressedright = false
				end
			end
			
		end
	end
end

SRBZ.characterselecthud = function(v, player, c)
    local pmo = player.mo 
    if not pmo then 
        return
    end
    local cursorpatch = v.cachePatch("CURWEAP")
	local barpatch = v.cachePatch("DABARR")
    local skincount = #getSkinNums(player,true)
	
	if player.chosecharacter then
		return
	end
	
	--Blue Bar
	v.drawStretched(0, 20*FRACUNIT-3*FRACUNIT, 1500*FRACUNIT, FRACUNIT*3, barpatch, V_SNAPTOTOP|V_SNAPTOLEFT)
	
	--Icons
    for i,skinname in ipairs(getSkinNames(player,true)) do
        local sel = player.selection
        local x = (( (157) + (i*25) - (sel*25)  ) * FRACUNIT) -- +13 is the offset
		--- (skincount*25)
        local y = 20*FRACUNIT
		+ 16*FRACUNIT -- the extra 16 fracunit is the offset
        local scale = iconscale.value
        local skinpatch = v.getSprite2Patch(skinname, SPR2_LIFE)
        
        local flags = V_SNAPTOTOP
		local colormap = v.getColormap(skinname, skins[getSkinNums(player,true)[i]].prefcolor)
        v.drawScaled(x, y, scale, skinpatch, flags, colormap)
    end

	--Selection Square
    do
        local skincount = #getSkinNums(player,true)
        local x = ( (145) ) * FRACUNIT --- skincount*25
        local y = 20*FRACUNIT

        local scale = sel_iconscale.value
        
        local flags = V_SNAPTOTOP

        
        v.drawScaled(x, y, scale, cursorpatch, flags)
    end
	
	local the_color = skins[getSkinNames(player, true)[player.selection]].prefcolor
	local the_name = skins[getSkinNames(player, true)[player.selection]].realname
	customhud.CustomFontString(v, 160*FRACUNIT, 0, the_name, "STCFC", (V_SNAPTOTOP), "center" , 2*FRACUNIT, the_color )

end