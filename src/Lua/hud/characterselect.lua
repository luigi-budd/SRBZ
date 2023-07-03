local round_active = false
local hud_icon_scale = FU+(FU/4)

addHook("MapLoad", function()
	for player in players.iterate do
		player.choosing = true
		player.chosecharacter = false
	end
end)

SRBZ.characterselecthud = function(v, player, c)

	if gametype ~= GT_SRBZ then return end
    local pmo = player.mo 
    if not pmo then 
        return
    end

    local cursorpatch = v.cachePatch("CURWEAP")
	local barpatch = v.cachePatch("DABARR")
    local skincount = #SRBZ.getSkinNums(player,true)
	
	if player.chosecharacter then
		return
	end
	
	--Blue Bar
	v.drawStretched(0, 20*FRACUNIT-3*FRACUNIT, 1500*FRACUNIT, FRACUNIT*3, barpatch, V_SNAPTOTOP|V_SNAPTOLEFT)
	
	--Icons
    for i,skinname in ipairs(SRBZ.getSkinNames(player,true)) do
        local sel = player.selection or 1
		local x
		if player.selection_anim ~= nil and player.prevselection then
			local ese = ease.outexpo(FixedDiv(player.selection_anim*FRACUNIT, ((TICRATE/2)*FRACUNIT)), 
			 (player.prevselection*25)*FRACUNIT, (player.selection*25)*FRACUNIT)
			x = (( (157) + (i*25) ) * FRACUNIT) - (ese) --(sel*25)*FRACUNIT
		else
			x = (( (157) + (i*25) ) * FRACUNIT) - ((sel*25)*FRACUNIT) 
		end
		--- (skincount*25)
        local y = 20*FRACUNIT
		+ 16*FRACUNIT -- the extra 16 fracunit is the offset
        local scale = hud_icon_scale
        local skinpatch = v.getSprite2Patch(skinname, SPR2_LIFE)
        
        local flags = V_SNAPTOTOP
		local colormap = v.getColormap(skinname, skins[SRBZ.getSkinNums(player,true)[i]].prefcolor)
        v.drawScaled(x, y, scale, skinpatch, flags, colormap)
		
		--
    end

	--Selection Square
    do
        local skincount = #SRBZ.getSkinNums(player,true)
		
        local x = ( (145) ) * FRACUNIT --- skincount*25
        local y = 20*FRACUNIT

        local scale = hud_icon_scale
        
        local flags = V_SNAPTOTOP

        
        v.drawScaled(x, y, scale, cursorpatch, flags)
    end
	
	local the_color = skins[SRBZ.getSkinNames(player, true)[player.selection]].prefcolor
	local the_name = skins[SRBZ.getSkinNames(player, true)[player.selection]].realname
	customhud.CustomFontString(v, 160*FRACUNIT, 0, the_name, "STCFC", (V_SNAPTOTOP), "center" , 2*FRACUNIT, the_color )
	if leveltime > SRBZ.charselect_waittime	then
		local x = 160
		local y = 50
		local text = "Press FORWARD to continue."
		customhud.CustomFontString(v,x,y,text, "STCFC", (V_SNAPTOTOP|V_TRANSLUCENT), "center" , nil, SKINCOLOR_GREY)
	end
end