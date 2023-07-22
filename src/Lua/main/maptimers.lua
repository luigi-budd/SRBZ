--Custom timers for maps
--Code by LeonardoTheMutant
--
--Functions:
--  SRBZ.AddMapTimer(name, mapID, time, active) - Create timer with the name [name] for map [mapID] (not extended map num!) that will work [time] ticks and is [active] on level startup
--  SRBZ.ToggleMapTimer(name) - toggle the state of the timer
--  SRBZ.ResetMapTimer(name) - Reset the timer to the original time value
--
--Access your timer:
--  SRBZ.MapTimers["Your_Timer_Name"].time - get the current time of your timer
--  SRBZ.MapTimers["Your_Timer_Name"].active - is timer active or not, true = is it counting down, false = it is paused
--
--How to actually use it on your map (ThinkFrame hook LUA example):
--  addHook("ThinkFrame", function(
--      local mytimer=SRBZ.MapTimers["MyTimer"]
--      if mytimer.time==105 then
--          print("3 SECONDS LEFT!")
--      elseif mytimer.time==70 then
--          print("2 SECONDS LEFT!!")
--      elseif mytimer.time==35 then
--          print("ONE SECOND!!!!")
--      elseif my.timer.time==0 and not mytimer.active then
--          print("TIME OVER!")
--          dosomethingelse()
--      end
--      if (not mytimer.active and mytimer.time ~= 0) print("WHY THE FUCK MY TIMER IS STOPPED") end --please ignore this line :skull:
--  end))

SRBZ.MapTimers={}

SRBZ.AddMapTimer=function(n,m,t,a)
	if n==nil error("Name of the Timer is not specified") end
	if m==nil error("Map ID is not specified") end
	if t==nil error("Time is not specified") end
	if type(n)!="string" error("Timer Name should be string") end
	if type(m)!="number" error("Map ID should be number") end
	if type(t)!="number" error("Time should be number in ticks") end
	--if type(timepoint)~="table" and type(timepoint)~="nil" error("TimePoint values must be a table") end
	if type(a)!="boolean" error ("Timer Activity value should be boolean") end
	SRBZ.MapTimers[n]={map=m,time=t,active=a,originaltime=t}
end
SRBZ.ToggleMapTimer=function(timer)
	if timer==nil error("Timer name is not specified") end
	if type(timer)!="string" error("Name of the Timer should be string") end
	SRBZ.MapTimers[timer].active = not SRBZ.MapTimers[timer].active
end
SRBZ.ResetMapTimer=function(timer)
	if timer==nil error("Timer name is not specified") end
	if type(timer)!="string" error("Name of the Timer should be string") end
	SRBZ.MapTimers[timer].time=SRBZ.MapTimers[timer].originaltime
end

addHook("ThinkFrame",do
	for timerName,timer in pairs(SRBZ.MapTimers)
		if gamemap==timer.map and timer.active timer.time=$-1 end
		if timer.time<=0 timer.active=false end
	end
end)