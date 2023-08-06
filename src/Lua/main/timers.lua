
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

addHook("ThinkFrame", function()
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end --stop the trolling
	
	if leveltime >= SRBZ.wait_time and not SRBZ.round_active then
		SRBZ.round_active = true
		S_StartSound(nil, sfx_rstart)
		local choosingnums = {}
		local amountchoosing = FixedCeil(FixedDiv(SRBZ.PlayerCount()*FU,4*FU))/FU -- lmao
		
		-- simpler than ze's rng for sure.
		for player in players.iterate do
			if player.choosing == true and player.chosecharacter == false then
				local selection_name = SRBZ.getSkinNames(player, true)[player.selection]
				SRBZ.pickcharinselect(player,selection_name) -- get tf out of character select	
			end
			table.insert(choosingnums, #player)
		end
		
		if SRBZ.PlayerCount() > 1 and #choosingnums > 1 then
			for _I_=1,amountchoosing do
				local playernumindex = P_RandomRange(1,#choosingnums)
				local playernum = choosingnums[playernumindex]
				local player = players[playernum]
				
				
				P_KillMobj(player.mo,nil,nil,DMG_INSTAKILL)
				player.zteam = 2
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
	
	if arg1 and tonumber(arg1) and tonumber(arg1) > 0 and tonumber(arg1) < 3 then
		SRBZ:StartWin(tonumber(arg1))
	end
	
end,1)
