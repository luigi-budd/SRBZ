SRBZ.inventoryhud = function(v, player)
	if gametype ~= GT_SRBZ then return end
	if not player.chosecharacter or player.choosing then return end
	local x = 116*FU
	local y = 176*FU
	local hscale = FU
	local vscale = FU
	local patch = v.cachePatch("RINGIND")
	v.drawStretched(x, y, hscale, vscale, patch, V_SNAPTOLEFT|V_SNAPTOBOTTOM)
end