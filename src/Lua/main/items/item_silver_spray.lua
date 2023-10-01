freeslot("sfx_thoklw")

SRBZ:CreateItem("Silver Spray",  {
	object = MT_THROWNAUTOMATIC,
	icon = "SILVERSPRAYIND",
	firerate = 20,
	color = SKINCOLOR_SILVER,
	damage = 13,
	knockback = 5*FRACUNIT,
	flags2 = MF2_AUTOMATIC,
	sound = sfx_thoklw,
	onspawn = function(pmo, mo)
		mo.scale = ($/3)*4
	end,
})