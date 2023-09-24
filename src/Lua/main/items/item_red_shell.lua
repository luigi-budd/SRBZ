SRBZ:CreateItem("Red Shell",  {
	object = MT_SHELL,
	icon = "REDSHELLIND",
	firerate = 19,
	fuse = 7*TICRATE,
	color = SKINCOLOR_RED,
	knockback = 0,
	damage = 18,
	onspawn = function(pmo, mo)
		mo.scale = $*3
	end,
	onhit = function(pmo, hit, shell)
		shell.fuse = 1
	end,
	price = 630,
})
