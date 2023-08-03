

SRBZ.intermissionhud = function(v, player)
	if not SRBZ.game_ended then return end
	
	local animlength = 3*TICRATE
	local x1,x2 = {
		start = -400,
		stop = 50
	},
	{
		start = 700,
		stop = 220
	}
	
	local z_s = v.cachePatch("Z_SURVIVORS")
	local z_z = v.cachePatch("Z_ZOMBIES")
	local z_w = v.cachePatch("Z_WIN")
	
	x1.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU), x1.start*FU,x1.stop*FU)
	x2.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU), x2.start*FU,x2.stop*FU)

	if SRBZ.win_tics < animlength then
		v.drawScaled(x1.ese,100*FU, FU, z_s)
		v.drawScaled(x2.ese,100*FU, FU, z_w)
	else
		v.drawScaled(x1.stop*FU,100*FU, FU, z_s)
		v.drawScaled(x2.stop*FU,100*FU, FU, z_w)
	end
	

	

end