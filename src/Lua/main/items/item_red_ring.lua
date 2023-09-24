SRBZ:CreateItem("Red Ring",  {
	object = MT_REDRING,
	icon = "RINGIND",
	firerate = 17,
	color = SKINCOLOR_RED,
	knockback = 55*FRACUNIT,
	damage = 15,
	onspawn = function(pmo, mo)
		--1.5*FU = FU+FU/2 = (3*FU)/2 = 98304
		mo.momx = FixedMul($,98304)
		mo.momy = FixedMul($,98304)
		mo.momz = FixedMul($,98304)
	end,
})