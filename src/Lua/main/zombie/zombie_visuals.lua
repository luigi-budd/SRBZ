addHook("PlayerThink", function(player)
	if player.mo and player.mo.valid and player.ztype == "alpha" then
		local alpha_effect = P_SpawnGhostMobj(player.mo)
		alpha_effect.color = P_RandomRange(SKINCOLOR_RED, SKINCOLOR_RUBY)
		alpha_effect.colorized = true
		alpha_effect.fuse = 4
		alpha_effect.blendmode = AST_ADD
		P_MoveOrigin(alpha_effect, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
		alpha_effect.frame = $|FF_ADD
		alpha_effect.scale = 15*FRACUNIT/10
		if alpha_effect.tracer
			alpha_effect.tracer.fuse = alpha_effect.fuse
		end
	end
end)




