
addHook("PlayerSpawn", SRBZ.playerfunc)

addHook("TouchSpecial", SRBZ.HitMegaHP, MT_MEGAHP)

addHook("PlayerThink", SRBZ.sprint_thinker)

addHook("PlayerThink", SRBZ.giveplayerflags)

addHook("MobjThinker", SRBZ.LimitMobjHealth)

addHook("MapLoad", function(map)
	if gametype == GT_SRBZ then
		SRBZ.init_gamevars(map)
	end
end)
