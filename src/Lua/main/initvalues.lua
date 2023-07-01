SRBZ.nerfchars = function(mobj)
	local player = mobj.player
	
	player.pflags = $ & ~PF_DIRECTIONCHAR
	if player.charability2 then
		player.charability2 = 0
	end
	if player.mo.skin == "sonic" then
		if player.charability ~= CA_JUMPTHOK then
			player.charability = CA_JUMPTHOK
		end
		
		
		player.actionspd = 9 * FRACUNIT
	end
	player.jumpfactor = 17 * FRACUNIT / 19
end

--58637.4736842/65536