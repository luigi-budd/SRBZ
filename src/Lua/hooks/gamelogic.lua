addHook("PreThinkFrame", SRBZ.charselectlogic)
addHook("MobjThinker", SRBZ.nerfchars, MT_PLAYER)

addHook("MapLoad", do
	if gametype == GT_SRBZ then
		SRBZ.init_gamevars()
	end
end)
