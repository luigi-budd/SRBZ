
-- ThinkFrame pls
SRBZ.GameLogic_Timers = function()
	
	if gametype ~= GT_SRBZ or gamestate ~= GS_LEVEL then return end --stop the trolling
	
	if leveltime >= SRBZ.wait_time and not SRBZ.round_active then
		SRBZ.round_active = true
		S_StartSound(nil, sfx_rstart)
		
		for player in players.iterate do
			if player.choosing == true and player.chosecharacter == false then
				local selection_name = SRBZ.getSkinNames(player, true)[player.selection]
				
				SRBZ.pickcharinselect(player,selection_name) -- get tf out of character select
			end
		end
		
		
	end
	

	if SRBZ.round_active then
		SRBZ.game_time = $ + 1;
	end
	
end