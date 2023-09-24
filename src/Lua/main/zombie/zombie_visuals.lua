addHook("PlayerThink", function(player)
	if player.mo and player.mo.valid and player.ztype == "alpha" then
		if not (player.mo.alpha_thing and player.mo.alpha_thing.valid) then
			local alpha_effect = P_SpawnGhostMobj(player.mo)
			alpha_effect.color = P_RandomRange(SKINCOLOR_RED, SKINCOLOR_RUBY)
			alpha_effect.colorized = true
			alpha_effect.blendmode = AST_ADD
			alpha_effect.frame = $|FF_ADD
			alpha_effect.scale = 15*FRACUNIT/10
			player.mo.alpha_thing = alpha_effect
			if alpha_effect.tracer
				alpha_effect.tracer.fuse = alpha_effect.fuse
			end
		else
			P_MoveOrigin(player.mo.alpha_thing, 
			player.mo.x + player.mo.momx,
			player.mo.y + player.mo.momy, 
			player.mo.z + player.mo.momz - 4*FRACUNIT)
		end
		

		


	end
end)




