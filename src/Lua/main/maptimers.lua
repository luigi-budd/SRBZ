-- Custom timers for maps
-- Code by LeonardoTheMutant and Jisk
-- Example
/*
SRBZ.AddMapTimer(
	"Stonewood Timer1",
	424, -- "MAPJ0"
	5*TICRATE,
	true,
	function(timernum,timername)
		print("Timer done: "..timername.." [".. timernum .. "]")
	end
)
*/


rawset(_G, "G_BuildMapNum", function(str)
  str = string.gsub($, "MAP", "") -- Remove "MAP" from the string
  local x = string.sub(str, 1, 1)
  local y = string.sub(str, 2)

  x = tonumber($) and tonumber($) or R_Char2Frame($)
  y = tonumber($) and tonumber($) or R_Char2Frame($) + 10

  return 36 * x + y + 100
end)

SRBZ.MapTimers = {}

SRBZ.AddMapTimer = function(timer_name,map_number,map_time,active,onend)
	if timer_name == nil then 
		error("Name of the Timer is not specified") end
	if map_number == nil then 
		error("Map Number is not specified") end
	if map_time == nil then 
		error("Time is not specified") end

	if timer_name and type(timer_name) ~= "string" then 
		error("Timer Name should be string") end
	if map_number and type(map_number) ~= "number" then 
		error("Map Number should be number") end
	if map_time and type(map_time) ~= "number" then 
		error("Time should be number in ticks") end
	if active and type(active) ~= "boolean" then 
		error("Timer Activity value should be boolean") end
	if onend and type(onend) ~= "function" then
		error("Onend should be a function") end

	table.insert(SRBZ.MapTimers,{
		name = timer_name,
		map = map_number,
		time = map_time,
		active = active,
		originaltime = map_time,
		on_end = onend,
	})
	return #SRBZ.MapTimers
end
SRBZ.ResetMapTimer=function(timernum)
	if timernum == nil then 
		error("Timer number is not specified")
	end
	if type(timernum) ~= "string" then
		error("Name of the timer should be a string")
	end
	SRBZ.MapTimers[timernum].time = SRBZ.MapTimers[timernum].originaltime
end

addHook("ThinkFrame",do
	for i,timer in ipairs(SRBZ.MapTimers) do
		if gamemap == timer.map and timer.active then
			timer.time = $ - 1
			if timer.time <= 0 and timer.on_end then
				timer.on_end(i, timer.name)
			end
		end
		if timer.time <= 0 then
			timer.active = false
		end
	end
end)