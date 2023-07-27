freeslot("MT_CRRUBY","S_CRRUBY","SPR_RBY1", "sfx_rbyhit") -- idk what CR means but i just slap it there

mobjinfo[MT_CRRUBY]= {
	doomednum = -1,
	spawnstate = S_CRRUBY,
	spawnhealth = 1,
	deathstate = S_SPRK1,
	deathsound = sfx_rbyhit,
	radius = 15*FU,
	height = 24*FU,
	flags = MF_SLIDEME|MF_SPECIAL,
}

states[S_CRRUBY] = {
	sprite = SPR_RBY1,
	frame = FF_FULLBRIGHT|A,
	tics = -1,
	nextstate = S_CRRUBY,
}

addHook("PlayerThink", function(player)
	player.rubies = $ or 0
	if player.rubies > 500 then
		player.rubies = 500
	end
end)

addHook("MobjDeath", function(mobj)

	if gametype ~= GT_SRBZ then return end
	
	if mobj.flags & MF_ENEMY then
	
		local ruby_count = P_RandomRange(1,5)
		
		for i=1,ruby_count do
			local the_ruby = P_SpawnMobjFromMobj(mobj,0,0,10*FU,MT_CRRUBY)
			
			P_SetObjectMomZ(the_ruby, P_RandomRange(5,10)<<16)
		
			if ruby_count > 1 then
				local angle = P_RandomRange(0, 255) * 256 * 65536
				P_InstaThrust(the_ruby, angle, 3*FU)
			end
		end
	end
end)



addHook("TouchSpecial", function(special, toucher)
	if toucher and toucher.valid and toucher.player then
		P_GivePlayerRubies(toucher.player, 1)
	end
end, MT_CRRUBY)

addHook("MobjThinker", function(mobj)
	if mobj.sprite == SPR_SPRK then
		mobj.color = SKINCOLOR_RUBY
		mobj.colorized = true
	end
	--P_RingZMovement(mobj)
	if mobj.eflags & MFE_JUSTHITFLOOR then
		P_SetObjectMomZ(mobj, abs(FixedDiv(mobj.lastmomz, P_RandomRange(2,3)*FRACUNIT)))
		if mobj.momz < FRACUNIT then
			mobj.momz = 0
		else
			S_StartSound(mobj, sfx_tink)
		end
	end
	mobj.lastmomz = mobj.momz
end, MT_CRRUBY)