freeslot("MT_CRRUBY","S_CRRUBY","SPR_RBY1", "sfx_rbyhit") -- idk what CR means but i just slap it there

SRBZ.RubyLimit = 500000;

function A_RubyDrop(actor, var1)
	for i=1,var1 do
		local the_ruby = P_SpawnMobjFromMobj(actor,0,0,10*FU,MT_CRRUBY)
		the_ruby.fuse = 16*TICRATE
		P_SetObjectMomZ(the_ruby, P_RandomRange(5,7)<<16)

		if var1 > 1 then
			local angle = P_RandomFixed() * FU
			P_InstaThrust(the_ruby, angle, 2*FU)
		end
	end
end

mobjinfo[MT_CRRUBY]= {
	doomednum = -1,
	spawnstate = S_CRRUBY,
	spawnhealth = 1,
	deathstate = S_SPRK1,
	deathsound = sfx_rbyhit,
	radius = 25*FU,
	height = 45*FU,
	flags = MF_SLIDEME|MF_SPECIAL,
}

states[S_CRRUBY] = {
	sprite = SPR_RBY1,
	frame = FF_FULLBRIGHT|A,
	tics = -1,
	nextstate = S_CRRUBY,
}

sfxinfo[sfx_rbyhit].caption="Ruby"

addHook("PlayerThink", function(player)
	player.rubies = $ or 0
	if player.rubies > SRBZ.RubyLimit then
		player.rubies = SRBZ.RubyLimit
	end
end)

addHook("MobjDeath", function(mobj)
	if gametype ~= GT_SRBZ return end
	
	if mobj.rubiesholding then
		A_RubyDrop(mobj,mobj.rubiesholding)
		mobj.rubiesholding = 0
	end
end)

addHook("MobjSpawn", function(mobj)
	if gametype ~= GT_SRBZ then return end
	
	if mobjinfo[mobj.type].rubydrop and type(mobjinfo[mobj.type].rubydrop) == "table" 
	and #mobjinfo[mobj.type].rubydrop == 2 then
		local ruby_count = P_RandomRange(mobjinfo[mobj.type].rubydrop[1],mobjinfo[mobj.type].rubydrop[2])
		mobj.rubiesholding = ruby_count
	end
end)


addHook("TouchSpecial", function(special, toucher)
	if toucher and toucher.valid and toucher.player then
		if toucher.player.rubies + 1 > SRBZ.RubyLimit then
			return true
		end
		P_GivePlayerRubies(toucher.player, 1)
	end
end, MT_CRRUBY)

addHook("MobjThinker", function(mobj)
	if mobj.sprite == SPR_SPRK then
		mobj.color = SKINCOLOR_RED
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
	
	if mobj.fuse < 3*TICRATE then
		mobj.flags2 = $^^MF2_DONTDRAW
	end
	local findrange = 255*FRACUNIT
	searchBlockmap("objects", function(refmobj, foundmobj)
		if foundmobj and abs(mobj.z-foundmobj.z) < 150*FU and foundmobj.valid and foundmobj.player then
			P_FlyTo(mobj,foundmobj.x,foundmobj.y,foundmobj.z,2*FRACUNIT,true)
		end
	end,mobj,
	mobj.x-findrange,mobj.x+findrange,
	mobj.y-findrange,mobj.y+findrange)
end, MT_CRRUBY)

COM_AddCommand("z_sendrubies", function(player, player2, rubies)
	local function giveinstructions()
		CONS_Printf(player, "z_sendrubies <receivingplayernum> <rubies>: gives rubies to a player")
	end
	if (not player2) or (not rubies) or (not tonumber(rubies)) then
		giveinstructions()
		return
	end
	
	rubies = tonumber($)
	player2 = tonumber($)
	if not players[player2] then
		CONS_Printf(player, "\x85This player does not exist.")
		return
	end
	
	if rubies > player.rubies then
		CONS_Printf(player, "\x85You don't have enough rubies to do this.")
		return
	end
	
	if rubies <= 0 then 
		CONS_Printf(player, "\x85Rubies must be positive value.")
		return
	end
	
	player.rubies = $ - rubies 
	players[player2].rubies = $ + rubies
	
	CONS_Printf(player, "\x82You sent "..rubies.." rubies to "..players[player2].name)
	CONS_Printf(
	players[player2], 
	string.format("\x82%s\x82 sent you %s rubies", players[player2].name, tostring(rubies))
	)
	
	
end)