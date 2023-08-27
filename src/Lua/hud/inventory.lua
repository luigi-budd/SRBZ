SRBZ.inventoryhud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	if player.choosing then return end
	if SRBZ.game_ended then return end
	
	if player["srbz_info"].ghostmode then return end
	
	if player and not player.mo then return end
	
	local s_patch = v.cachePatch("CURWEAP")
	local cyan_patch = v.cachePatch("Z_CYANSQUARE")
	local sel = player["srbz_info"].inventory_selection
	local sel_x = 116*FU
	if sel > 1 then
		sel_x = $ + ((sel-1)*20*FU)
	end
	local sel_y = 176*FU
	
	for i=1,SRBZ:FetchInventoryLimit(player) do
		local x = 116*FU
		local y = 176*FU
		local overone_xpos = ((i-1)*20)*FU
		local iconscale = FU
		
		if player.shop_open then 
			y = 146*FU
			sel_y = y
		end
		local patch
		
		if i > 1 then
			x = $ + overone_xpos
		end
		
		if SRBZ:FetchInventory(player)[i]
			if SRBZ:FetchInventory(player)[i].icon then
				patch = v.cachePatch(SRBZ:FetchInventory(player)[i].icon)
			else
				patch = v.cachePatch("BLANKIND")
			end
			if SRBZ:FetchInventory(player)[i].iconscale then
				iconscale = SRBZ:FetchInventory(player)[i].iconscale
			end
		else
			patch = v.cachePatch("BLANKIND")
		end
		
		-- weapon icons
		if SRBZ:FetchInventory(player)[i] then
			v.drawStretched(x, y, iconscale, iconscale, patch, V_SNAPTOBOTTOM)
		else
			v.drawStretched(x, y, iconscale, iconscale, patch, V_SNAPTOBOTTOM|V_TRANSLUCENT)
		end

		if SRBZ:FetchInventory(player)[i] and SRBZ:FetchInventory(player)[i].count and SRBZ:FetchInventory(player)[i].limited then
			v.drawString(x, y, tostring(SRBZ:FetchInventory(player)[i].count), V_SNAPTOBOTTOM, "thin-fixed")
		end
	end
	
	if SRBZ:FetchInventorySlot(player) and SRBZ:FetchInventorySlot(player).displayname then
		local iteminfo = ""
		if SRBZ:FetchInventorySlot(player).damage then
			iteminfo = $ + "\x85".."DMG: "..SRBZ:FetchInventorySlot(player).damage.." "
		end
		if SRBZ:FetchInventorySlot(player).firerate then
			local firerate = SRBZ:FetchInventorySlot(player).firerate
			iteminfo = $ + "\x84".."RATE: "..G_TicsToSeconds(firerate).."."..G_TicsToCentiseconds(firerate).." "
		end
		if SRBZ:FetchInventorySlot(player).knockback then
			iteminfo = $ + "\x83".."KB: "..SRBZ:FetchInventorySlot(player).knockback/FU.." "
		end
		v.drawString(115*FU, sel_y-(9*FU), SRBZ:FetchInventorySlot(player).displayname, V_SNAPTOBOTTOM|V_TRANSLUCENT,"thin-fixed")
		v.drawString(115*FU, sel_y-(17*FU), iteminfo, V_SNAPTOBOTTOM|V_TRANSLUCENT,"thin-fixed")
	else
		v.drawString(115*FU, sel_y-(9*FU), "EMPTY", V_SNAPTOBOTTOM|V_TRANSLUCENT,"thin-fixed")
	end
	-- weapon selection 
	v.drawStretched(sel_x-(2*FU), sel_y-(2*FU), FU, FU, s_patch, V_SNAPTOBOTTOM)

	if player["srbz_info"].weapondelay and SRBZ:FetchInventorySlot(player) then
		local slotdelay = SRBZ:FetchInventorySlot(player).firerate
		local delaydiv = min(FixedDiv(player["srbz_info"].weapondelay, slotdelay),FU)
		v.drawStretched(sel_x, sel_y, delaydiv, FU, cyan_patch, V_SNAPTOBOTTOM|V_50TRANS)
	end
end