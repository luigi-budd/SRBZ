SRBZ.killwhenchosen = CV_RegisterVar({
	name = "z_killwhenchosen",
	defaultvalue = "On",
	PossibleValue = CV_OnOff,
	flags = CV_NETVAR,
})

SRBZ.choosenotice = CV_RegisterVar({
	name = "z_choosenotice",
	defaultvalue = "On",
	PossibleValue = CV_OnOff,
	flags = CV_NETVAR,
})

function SRBZ:StartWin(team)
	self.game_ended = true
	self.team_won = team
	
	if team == 1 then
		S_ChangeMusic("SWIN", false)
		mapmusname = "SWIN"
	else
		S_ChangeMusic("ZWIN", false)
		mapmusname = "ZWIN"
	end
	
	for mobj in mobjs.iterate() do
		if (mobj.flags & MF_ENEMY) then
			P_KillMobj(mobj)
		end
	end
end

addHook("PlayerThink", function(player)
	player.waszombie = $ or false -- waszombie is to prevent repeating players
end)

addHook("ThinkFrame", function()
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end --stop the trolling
	
	if leveltime >= SRBZ.wait_time and not SRBZ.round_active then
		SRBZ.round_active = true
		S_StartSound(nil, sfx_rstart)
		local choosingnums = {}
		local amountchoosing = FixedCeil(FixedDiv(SRBZ.PlayerCount()*FU,4*FU))/FU -- lmao
		
		-- simpler than ze's rng for sure.
		for player in players.iterate do
			if player.choosing == true and player.chosecharacter == false then -- get tf out of character select
				local selection_name = SRBZ.getSkinNames(player, true)[player.selection]
				SRBZ.pickcharinselect(player,selection_name) 
			end
			if not player.waszombie then
				table.insert(choosingnums, #player)
			end
		end
		-- At this point, every player's playernum is sroted in choosingnums
		-- except for the players that were zombies last game.

		if SRBZ.PlayerCount() > 1 then
			for _I_=1,amountchoosing do
				local playernumindex = P_RandomRange(1,#choosingnums)
				local playernum = choosingnums[playernumindex]
				local player = players[playernum]
				
				if SRBZ.killwhenchosen.value then
					P_KillMobj(player.mo,nil,nil,DMG_INSTAKILL)
				else
					SRBZ.SetCChealth(player)
					SRBZ.SetCCtoplayer(player)
				end
				if SRBZ.choosenotice.value then
					print(string.format("\x83\%s\x83\ has risen from the dead!",player.name))
				end
				player.zteam = 2
				player.waszombie = true
				table.remove(choosingnums,playernumindex)
			end
		end

		for player in players.iterate do
			if player.waszombie and player.zteam == 1 then
				player.waszombie = false
			end
		end
		
		choosingnums = nil -- release memory idk wtf
	end
	if SRBZ.time_limit and SRBZ.game_time >= SRBZ.time_limit and not (SRBZ.game_ended) then
		SRBZ:StartWin(1)
	end
	
	for player in players.iterate do 
		if player.mo and player.mo.valid and (SRBZ.game_ended or player.mo.zteam == 2) then
			player.powers[pw_underwater] = 0
		end
	end
	
	if SRBZ.game_ended then SRBZ.win_tics = $ + 1 end
	if (SRBZ.round_active) and not (SRBZ.game_ended) then SRBZ.game_time = $ + 1 end
end)

/*
addHook("MobjThinker", function(mobj)
	if SRBZ.game_ended and leveltime then

		mobj.flags = $ | MF_NOTHINK
		return true
	end
end)
*/

COM_AddCommand("z_forcewin", function(player, arg1)
	local teamtowin = 1
 	if not arg1 or not tonumber(arg1) then return end
 	arg1 = tonumber(arg1)
	
	if (arg1>0 and arg1<3) then 
		SRBZ:StartWin(arg1) 
	end
	
end,COM_ADMIN)
