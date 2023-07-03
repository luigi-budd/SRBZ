addHook("PreThinkFrame", SRBZ.charselectlogic)

addHook("MobjThinker", SRBZ.nerfchars, MT_PLAYER)

addHook("MobjDeath", SRBZ.HitMegaHP, MT_MEGAHP)

addHook("MapLoad", do
	if gametype == GT_SRBZ then
		SRBZ.init_gamevars()
	end
end)
