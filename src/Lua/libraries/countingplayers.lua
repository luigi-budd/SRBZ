SRBZ.SurvivorCount = function()
	local c = 0 
	
	for player in players.iterate do
		if player.zteam ~= nil and player.zteam == 1 then
			c = $ + 1
		end
	end
	
	return c;
end

SRBZ.ZombieCount = function()
	local c = 0 
	
	for player in players.iterate do
		if player.zteam ~= nil and player.zteam == 2 then
			c = $ + 1
		end
	end
	
	return c;
end


SRBZ.PlayerCount = function()
	local c = 0 
	
	for player in players.iterate do
		c = $ + 1
	end
	
	return c;
end