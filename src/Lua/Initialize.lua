rawset(_G, "SRBZ", {})
rawset(_G, "XSLINGER", {})
freeslot("TOL_SRBZ")
SRBZ.survivaltime = (60*10)*TICRATE
SRBZ.swarmtime = (60*5)*TICRATE
SRBZ.onwinscreen = false
SRBZ.wintics = 0 -- How many tics after a win screen. Resets on mapload.

G_AddGametype({
	name = "SRBZ",
	identifier = "srbz",
	typeoflevel = TOL_SRBZ,
	rules = GTR_HURTMESSAGES|GTR_TIMELIMIT|GTR_ALLOWEXIT|GTR_RESPAWNDELAY|GTR_SPAWNENEMIES|GTR_CUTSCENES,
	intermissiontype = int_teammatch,
	--headerleftcolor = 152,
	--headerrightcolor = 40,
	description = "Escape from the Zombies! Don't get caught and eaten by them! They can catch up with you anytime..."
})