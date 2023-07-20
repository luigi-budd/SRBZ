addHook("PreThinkFrame", SRBZ.charselectlogic)

addHook("PlayerSpawn", SRBZ.playerfunc)

addHook("TouchSpecial", SRBZ.HitMegaHP, MT_MEGAHP)

addHook("PlayerThink", SRBZ.giveplayerflags)

addHook("ThinkFrame", SRBZ.GameLogic_Timers)

addHook("MobjThinker", SRBZ.LimitMobjHealth)

addHook("MapLoad", do
	if gametype == GT_SRBZ then
		SRBZ.init_gamevars()
	end
end)
