SRBZ.infohud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	local skinpatch = v.getSprite2Patch(player.mo.skin, SPR2_XTRA)
	local hppatch = v.cachePatch("SRBZHPBAR1")
	
	local colormap = v.getColormap(skinname, player.mo.color)
	
	local health = player.mo.health
	local maxhealth = player.mo.maxhealth

	/* Unused health bar for health point type system.
	for i=1,health do
		if i > 1 then
			v.drawStretched( (12*FRACUNIT)+ (12*FRACUNIT)*i, 176*FRACUNIT, FRACUNIT*1, FRACUNIT*3, hppatch, (V_SNAPTOBOTTOM|V_SNAPTOLEFT))
		else
			v.drawStretched( (24*FRACUNIT), 176*FRACUNIT, FRACUNIT*1, FRACUNIT*3, hppatch, (V_SNAPTOBOTTOM|V_SNAPTOLEFT))
		end
	end
	*/
	if player.chosecharacter or not player.choosing then
		-- [Player Icon] --
	
		v.drawScaled(0, 176*FRACUNIT, FixedDiv(3*FRACUNIT, 4*FRACUNIT),
		skinpatch, (V_SNAPTOBOTTOM|V_SNAPTOLEFT), colormap)
		-- [Player Name] --
		customhud.CustomFontString(v, 24, 192, 
		skins[player.mo.skin].realname, "STCFC", 
		(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, player.skincolor)
		
		-- [Rings] --
		customhud.CustomFontString(v, 24, 184, "Rings: "..player.rings, "STCFC", 
		(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_YELLOW)
		
		-- [Health] --
		local healthstring = "+ "..health.."/"..maxhealth
		customhud.CustomFontString(v, 24, 176, healthstring, "STCFC", 
		(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_GREEN)
	end
end
