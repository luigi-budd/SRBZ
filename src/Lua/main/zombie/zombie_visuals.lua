addHook("PlayerThink", function(player)
	if player.mo and player.mo.valid and player.ztype == "alpha" then
		if not (player.mo.alpha_thing and player.mo.alpha_thing.valid) then
			local alpha_effect = P_SpawnGhostMobj(player.mo)
			alpha_effect.color = P_RandomRange(SKINCOLOR_RED, SKINCOLOR_RUBY)
			alpha_effect.colorized = true
			alpha_effect.blendmode = AST_ADD
			alpha_effect.frame = $|FF_ADD
			alpha_effect.scale = 15*FRACUNIT/10
			alpha_effect.fuse = 12*TICRATE
			player.mo.alpha_thing = alpha_effect
			if alpha_effect.tracer
				alpha_effect.tracer.fuse = alpha_effect.fuse
			end
		else
			P_MoveOrigin(player.mo.alpha_thing, 
			player.mo.x + player.mo.momx,
			player.mo.y + player.mo.momy, 
			player.mo.z + player.mo.momz - 4*FRACUNIT)
			player.mo.alpha_thing.sprite = player.mo.sprite
			player.mo.alpha_thing.state = player.mo.state
			player.mo.alpha_thing.frame = player.mo.frame
			player.mo.alpha_thing.angle = player.drawangle
			player.mo.alpha_thing.dispoffset = 5
		end
	end
end)




