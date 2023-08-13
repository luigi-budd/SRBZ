SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and pmo and pmo.valid then
		SRBZ.SetCCtoplayer(player)
		SRBZ.SetCChealth(player)
	end
end

addHook("PlayerSpawn", function(player)
	local spawnsounds = {sfx_inf1,sfx_inf2}
	if player.mo and player.mo.valid and player.zteam == 2 and SRBZ.round_active and leveltime then
		local soundrng = P_RandomRange(1,#spawnsounds)
		S_StartSound(player.mo,spawnsounds[soundrng])
	end
end)

addHook("MobjSpawn", function(mobj)
	if mobjinfo[mobj.type].disablehealthhud then
		mobj.dontshowhealth = true
	end
end)