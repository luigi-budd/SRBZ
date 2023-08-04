local tx = CV_RegisterVar({
	name = "tx",
	defaultvalue = "0",
	PossibleValue = CV_Unsigned,
})
local ty = CV_RegisterVar({
	name = "ty",
	defaultvalue = "0",
	PossibleValue = CV_Unsigned,
})
SRBZ.intermissionhud = function(v, player)
	if not SRBZ.game_ended then return end
	
	local animlength = 3*TICRATE
	local x1 = {
		start = -400,
		stop = 50
	}
	local x2 = {
		start = 700,
		stop = 220
	}
	local bg = { -- background
		start = 9,
		stop = 6
	}	
	local bl = { -- bang lower's y
		start = 168+300,
		stop = 168
	}
	local bu = { -- bang upper's y
		start = -300,
		stop = 0
	}

	
	local z_team = v.cachePatch("Z_SURVIVORS")
	local z_w = v.cachePatch("Z_WIN")
	local z_bu = v.cachePatch("Z_BANG_UPPER_BLUE")
	local z_bl = v.cachePatch("Z_BANG_LOWER_BLUE")
	local z_bg = v.cachePatch("Z_BG_BLUE")
	
	if SRBZ.team_won == 2 then
		z_bu = v.cachePatch("Z_BANG_UPPER_RED")
		z_bl = v.cachePatch("Z_BANG_LOWER_RED")
		z_bg = v.cachePatch("Z_BG_RED")
		z_team = v.cachePatch("Z_ZOMBIES")
	end
	
	local scroll = (SRBZ.win_tics%128)
	
	x1.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),x1.start*FU,x1.stop*FU)
	x2.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),x2.start*FU,x2.stop*FU)
	bg.ese = bg.start-(FixedDiv(SRBZ.win_tics*FU, animlength*FU/2)*9/FU)
	bl.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),bl.start*FU,bl.stop*FU)
	bu.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),bu.start*FU,bu.stop*FU)
	
	
	if bg.ese > 5 then
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, bg.ese<<V_ALPHASHIFT)
	else
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, 5<<V_ALPHASHIFT)
	end
	
	
	if SRBZ.win_tics < animlength then
		
		v.drawScaled(x1.ese,100*FU, FU, z_team)
		v.drawScaled(x2.ese,100*FU, FU, z_w)
		for i=-5,5
			v.drawScaled((i*128*FU)+(scroll*FU),bl.ese,FU,z_bl,V_SNAPTOBOTTOM)
		end
		for i=-5,5
			v.drawScaled((i*128*FU)-(scroll*FU),bu.ese,FU,z_bu,V_SNAPTOTOP)
		end
	else
		v.drawScaled(x1.stop*FU,100*FU, FU, z_team)
		v.drawScaled(x2.stop*FU,100*FU, FU, z_w)
		for i=-5,5
			v.drawScaled((i*128*FU)+(scroll*FU),bl.stop*FU,FU,z_bl,V_SNAPTOBOTTOM)
		end
		for i=-5,5
			v.drawScaled((i*128*FU)-(scroll*FU),bu.stop*FU,FU,z_bu,V_SNAPTOTOP)
		end
		
	end

end