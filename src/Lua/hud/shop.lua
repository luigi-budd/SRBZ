SRBZ.shophud = function(v, player)
	if SRBZ.game_ended then return end
	if not player.shop_anim then return end
	
	local animlength = 1*TICRATE + TICRATE/2
	
	local bg = { -- background
		start = 9,
		stop = 6
	}	
	local bl = { -- bang lower's y
		start = 168+40,
		stop = 168
	}
	local bu = { -- bang upper's y
		start = -40,
		stop = 0
	}

	
	local z_bu = v.cachePatch("Z_BANG_UPPER_GRAY")
	local z_bl = v.cachePatch("Z_BANG_LOWER_GRAY")
	local z_bg = v.cachePatch("Z_BG_GRAY")
	
	
	local scroll = (leveltime%128)
	
	bg.ese = bg.start-(FixedDiv(player.shop_anim*FU, animlength*FU/2)*9/FU)
	bl.ese = ease.inoutsine(FixedDiv(player.shop_anim*FU, animlength*FU),bl.start*FU,bl.stop*FU)
	bu.ese = ease.inoutsine(FixedDiv(player.shop_anim*FU, animlength*FU),bu.start*FU,bu.stop*FU)
	
	
	if bg.ese > 5 then
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, bg.ese<<V_ALPHASHIFT)
	else
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, 5<<V_ALPHASHIFT)
	end
	
	for i=-5,5
		v.drawScaled((i*128*FU)+(scroll*FU),max(bl.ese,bl.stop*FU),FU,z_bl,V_SNAPTOBOTTOM)
	end
	for i=-5,5
		v.drawScaled((i*128*FU)-(scroll*FU),min(bu.ese,bu.stop*FU),FU,z_bu,V_SNAPTOTOP)
	end

end