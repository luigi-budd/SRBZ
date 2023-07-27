SRBZ.infohud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	local skinpatch = v.getSprite2Patch(player.mo.skin, SPR2_XTRA)
	local hppatch = v.cachePatch("SRBZHPBAR1")
	local timeemb = v.cachePatch("NGRTIMER")
	local the_time 
	local colormap = v.getColormap(skinname, player.mo.color)
	
	local health = player.mo.health
	local maxhealth = player.mo.maxhealth
	
	if SRBZ.round_active then
		the_time = G_TicsToMTIME(SRBZ.game_time)
	else
		the_time = G_TicsToMTIME(SRBZ.wait_time - leveltime)
	end
	
	if player.chosecharacter or not player.choosing then
		-- [Player Icon] --
	
		v.drawScaled(0, 176*FRACUNIT, FixedDiv(3*FRACUNIT, 4*FRACUNIT),
		skinpatch, (V_SNAPTOBOTTOM|V_SNAPTOLEFT), colormap)
		-- [Player Name] --
		customhud.CustomFontString(v, 24, 192, 
		skins[player.mo.skin].realname, "STCFC", 
		(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, player.skincolor)
		
		-- [Rubies] --
		if player.rubies ~= nil then
			customhud.CustomFontString(v, 24, 184, "Rubies: "..player.rubies, "STCFC", 
			(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_RUBY)
		end
		
		-- [Health] --
		local healthstring = "+ "..health.."/"..maxhealth
		customhud.CustomFontString(v, 24, 176, healthstring, "STCFC", 
		(V_SNAPTOBOTTOM|V_SNAPTOLEFT), nil , nil, SKINCOLOR_GREEN)
		
		-- [Timer] --
		if the_time ~= nil then
			customhud.CustomFontString(v, 150, 1, the_time, "STCFC", 
			(V_SNAPTOTOP), nil , nil, SKINCOLOR_BEIGE)
			
			v.drawScaled(138*FRACUNIT, 0, FRACUNIT,
			timeemb, (V_SNAPTOTOP))
			--SKINCOLOR_BEIGE
		end
		
	end
end
