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

addHook("MapLoad", function()
	for player in players.iterate do
		player.choosing = true
		player.chosecharacter = false
	end
end)

SRBZ.characterselecthud = function(v, player, c)
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
        local sel = player.selection
        local x = (( (157) + (i*25) - (sel*25)  ) * FRACUNIT) -- +13 is the offset
		--- (skincount*25)
        local y = 20*FRACUNIT
		+ 16*FRACUNIT -- the extra 16 fracunit is the offset
        local scale = iconscale.value
        local skinpatch = v.getSprite2Patch(skinname, SPR2_LIFE)
        
        local flags = V_SNAPTOTOP
		local colormap = v.getColormap(skinname, skins[SRBZ.getSkinNums(player,true)[i]].prefcolor)
        v.drawScaled(x, y, scale, skinpatch, flags, colormap)
    end

	--Selection Square
    do
        local skincount = #SRBZ.getSkinNums(player,true)
        local x = ( (145) ) * FRACUNIT --- skincount*25
        local y = 20*FRACUNIT

        local scale = sel_iconscale.value
        
        local flags = V_SNAPTOTOP

        
        v.drawScaled(x, y, scale, cursorpatch, flags)
    end
	
	local the_color = skins[SRBZ.getSkinNames(player, true)[player.selection]].prefcolor
	local the_name = skins[SRBZ.getSkinNames(player, true)[player.selection]].realname
	customhud.CustomFontString(v, 160*FRACUNIT, 0, the_name, "STCFC", (V_SNAPTOTOP), "center" , 2*FRACUNIT, the_color )

end