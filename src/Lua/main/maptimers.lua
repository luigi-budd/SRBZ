-- Custom timers for maps
-- Code by LeonardoTheMutant and Jisk

--AddMapTimer Function Parameters:
--
--	SRBZ.AddMapTimer(
--		name string, --name of the timer
--		map number, --map ID where it is meant to run
--		time number*TICRATE, --time
--		on_end function(timerID number, TimerName string), --function that executes at the end of the timer
--		extrainfo={ --allows for several events during runtime
--			color skincolor_t --optional, used for HUD to represent timer
--			[1]={
--				event_time = number*TICRATE, --time
--				event_func = function(timerID number, TimerName string) --something that should happen
--					chatprint("Hello world!")
--				end
--			}
--      }
--	)

-- Example:
--
--	SRBZ.AddMapTimer(
--		"Stonewood Timer1",
--		424, -- "MAPJ0"
--		5*TICRATE,
--		function(timernum,timername)
--			print("Timer done: "..timername.." [".. timernum .. "]")
--		end,
--		{
--			color = SKINCOLOR_BLUE
--			[1]={
--				event_time = 3*TICRATE
--				event_func = function(timerID, timerName)
--					chatprint(timerName.." with ID "..timerID.." has 3 seconds left!")
--				end
--			}
--			[2]={
--				event_time = 1*TICRATE
--				event_func = function(timerID, timerName)
--					chatprint("Timer with ID"..timerID.." ("..timerName..") has one second remaining!")
--				end
--			}
--		}
--  )

SRBZ.maptimerdebug = CV_RegisterVar({
	name = "z_maptimerdebug",
	defaultvalue = "Off",
	PossibleValue = CV_OnOff,
})

SRBZ.MapTimers = {}

SRBZ.AddMapTimer = function(timer_name,map_number,map_time,onend,extra)
	if (not timer_name) then 
		error("Name of the Timer is not specified") end
	if (not map_number) then 
		error("Map Number is not specified") end
	if (not map_time) then 
		error("Time is not specified") end

	if type(timer_name) ~= "string" then 
		error("Timer Name should be string") end
	if type(map_number) ~= "number" then 
		error("Map Number should be number (mapID)") end
	if type(map_time) ~= "number" then 
		error("Time should be number in ticks") end
	if onend and type(onend) ~= "function" then
		error("Onend should be a function") end
	if extra and type(extra) ~= "table" then
		error("Extra should be a table") end

	table.insert(SRBZ.MapTimers,{
		name = timer_name,
		map = map_number,
		time = map_time,
		on_end = onend,
		extrainfo = extra,
	})
	return #SRBZ.MapTimers
end

addHook("MapLoad", function()
	for i,v in ipairs(SRBZ.MapTimers) do
		table.remove(SRBZ.MapTimers,i)
	end
end)

addHook("ThinkFrame",do
	for i,timer in ipairs(SRBZ.MapTimers) do
		if (gamemap == timer.map)
			if (SRBZ.maptimerdebug.value) then
				print(timer.name..": "..(timer.time/35)) end

			timer.time = $ - 1

			if timer.extrainfo then
				for _,info in ipairs(timer.extrainfo) do
					if (info.event_time) and (info.event_func) then
						if (timer.time == info.event_time) then
							info.event_func(i, timer.name)
						end
					end
				end
				
				/*
					extrainfo::
					{
						[1] = {
							event_time = 5*TICRATE, -- This event activates when theres exactly 5 seconds left on a timer.
							event_func = function(i, timer.name) -- Same parameters as onend
								chatprint("\x86\Stone Platform \x80will leave in\x85 5 \x80seconds")
								-- Prints "Stone Platform will leave in 5 seconds"
							end
						}
					}
				*/
				
			end
			if ((timer.time <= 0) and (timer.on_end)) then 
				timer.on_end(i, timer.name)
			end
		end
		if timer.time <= 0 then
			table.remove(SRBZ.MapTimers,i)
		end
	end
end)
