local ut_mapnum = G_FindMapByNameOrCode("MAPJ5")

freeslot(
"sfx_utatk",
"sfx_utdi",
"sfx_fwtlk",
"sfx_trtlk",
"sfx_utbtl",
"sfx_utdgr",
"sfx_utesc"
)

local function undertale_floweytalk()
	chatprint("\x82\<Flowey>\x80 Hey, why are you in a hurry- Wait!")
	S_StartSound(player, sfx_fwtlk)
end

local function undertale_floweytalk2()
	chatprint("\x82\<Flowey>\x80 Hmm you didn't die. This is for now. Hehehe")
	S_StartSound(player, sfx_fwtlk)
end


local function undertale_door1()
	chatprint("\x89\Door \x80will open in\x85 60 \x80seconds")
	S_StartSound(player, sfx_utdgr)
	
	SRBZ.AddMapTimer(
		"Door 1",
		ut_mapnum,
		60*TICRATE,
		function(timernum,timername)
			P_LinedefExecute(31)
			S_ChangeMusic("UTRNS",true,player)
		end
	)
end

local function undertale_Prebattle1()
	chatprint("\x8B\Zombies \x80will appear in\x82 20 \x80seconds")
	S_StartSound(player, sfx_utdgr)
	SRBZ.AddMapTimer(
		"Incoming Zombies",
		ut_mapnum,
		20*TICRATE,
		function(timernum,timername)
			P_LinedefExecute(31)
			S_ChangeMusic("UTRNS",true,player)
		end
	)
end

local function undertale_Startbattle1()
	chatprint("Survive for\x85 60 \x80seconds")
	S_StartSound(player, sfx_utdgr)
	undertale_battle1 = 1
	undertale_timer3 = 60*TICRATE
end

local function undertale_Startbattle2()
	undertale_battle2 = 1
	undertale_timer5 = 120*TICRATE
end

local function undertale_BattleTele1Surv()
	for player in players.iterate
		if (player.ctfteam == 2) then
			P_SetOrigin(player.mo, -7168*FRACUNIT, -6272*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele1Zm()
	for player in players.iterate
		if (player.ctfteam == 1) then
		  P_SetOrigin(player.mo, -7168*FRACUNIT, -6272*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele2Surv()
	for player in players.iterate
		if (player.ctfteam == 2) then
			P_SetOrigin(player.mo, 6976*FRACUNIT, 3008*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele2Zm()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, 5056*FRACUNIT, -2880*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function undertale_BattleTele3Surv()
	for player in players.iterate
		if (player.ctfteam == 2) then
			P_SetOrigin(player.mo, -2368*FRACUNIT, -5504*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele3Zm()
	for player in players.iterate
		if (player.ctfteam == 1) then
		P_SetOrigin(player.mo, -1088*FRACUNIT, -4736*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele4Surv()
	for player in players.iterate
		if (player.ctfteam == 2) then
			P_SetOrigin(player.mo, 17280*FRACUNIT, 7104*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_BattleTele4Zm()
	for player in players.iterate
		if (player.ctfteam == 1) then
			P_SetOrigin(player.mo, 5056*FRACUNIT, -2880*FRACUNIT, 0*FRACUNIT)
		end
	end
end

local function undertale_Prebattle2()
	  undertale_Prebattle2 = 1
	  undertale_timer4 = 20*TICRATE
end

addHook("LinedefExecute", undertale_floweytalk, "FWTLK1")
addHook("LinedefExecute", undertale_floweytalk2, "FWTLK2")

addHook("LinedefExecute", undertale_door1, "48DR1")
addHook("LinedefExecute", undertale_Prebattle1, "48BTL1")
addHook("LinedefExecute", undertale_Startbattle1, "48BTL2")
addHook("LinedefExecute", undertale_Prebattle2, "48PRE2")
addHook("LinedefExecute", undertale_Startbattle2, "48BTLT")