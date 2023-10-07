SRBZ:CreateItem("Green Shell",  {
	object = MT_SHELL,
	icon = "SHELLIND",
	firerate = 2,
	fuse = 5*TICRATE,
	color = SKINCOLOR_GREEN,
	knockback = 15*FU,
	damage = 10,
	ammo = 15,
	onspawn = function(pmo, mo)
		mo.scale = ($*3)/2
	end,
	reload_time = 3*TICRATE,
	onhit = function(pmo, hit, shell)
		shell.fuse = 1
	end,
	price = 290,
})

addHook("MobjCollide", function(thing, tmthing)
	if gametype ~= GT_SRBZ then return end
	if thing.type == tmthing.type then
		return false
	end
end, MT_SHELL)