freeslot("sfx_gulpy")

freeslot(
	"MT_INSTABURST",
	"S_INSTABURST",
	"S_INSTABURST1A",
	"S_INSTABURST1B",
	"S_INSTABURST2A",
	"S_INSTABURST2B",
	"S_INSTABURST3A",
	"S_INSTABURST3B",
	"S_INSTABURST4A",
	"S_INSTABURST4B",
	"S_INSTABURST5A",
	"S_INSTABURST5B",
	"S_INSTABURST6A",
	"S_INSTABURST6B",
	"SPR_ZMSH"
)

freeslot("MT_PROPWOOD","S_PROP1","S_PROP1_BREAK","SPR_WPRP")
freeslot("MT_MIRRORCLONE", "sfx_mrr12")
sfxinfo[sfx_mrr12].caption="W's Mirror"
freeslot(
"MT_SRBZ_THROWNSCATTER",
"S_SRBZ_THROWNSCATTER1",
"S_SRBZ_THROWNSCATTER2",
"S_SRBZ_THROWNSCATTER3",
"S_SRBZ_THROWNSCATTER4",
"S_SRBZ_THROWNSCATTER5",
"S_SRBZ_THROWNSCATTER6",
"S_SRBZ_THROWNSCATTER7"
)
freeslot("sfx_shgn")
sfxinfo[sfx_shgn].caption="Shotgun"
-- RSNEO slap
mobjinfo[MT_SRBZ_THROWNSCATTER] = { 
	spawnstate = S_SRBZ_THROWNSCATTER1,
	--activesound = sfx_shgn,
	deathstate = S_SPRK1,
	xdeathstate = S_SPRK1,
	speed = 60*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SRBZ_THROWNSCATTER1] = {
	nextstate = S_SRBZ_THROWNSCATTER2,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER2] = {
	nextstate = S_SRBZ_THROWNSCATTER3,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER3] = {
	nextstate = S_SRBZ_THROWNSCATTER4,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER4] = {
	nextstate = S_SRBZ_THROWNSCATTER5,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER5] = {
	nextstate = S_SRBZ_THROWNSCATTER6,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER6] = {
	nextstate = S_SRBZ_THROWNSCATTER7,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}
states[S_SRBZ_THROWNSCATTER7] = {
	nextstate = S_SRBZ_THROWNSCATTER1,
	sprite = SPR_TSCR,
	frame = FF_FULLBRIGHT,
	tics = 1,
}

mobjinfo[MT_MIRRORCLONE] = {
    doomednum = -1,
    spawnstate = S_PLAY_STND,
    spawnhealth = 1,
    radius = 32*FRACUNIT,
    height = 48*FRACUNIT,
	flags = MF_SOLID,
}
mobjinfo[MT_MIRRORCLONE].npc_name = "Mirror Clone"
mobjinfo[MT_MIRRORCLONE].npc_spawnhealth = {100,100}

mobjinfo[MT_PROPWOOD] = {
    sprite = SPR_WPRP,
	spawnstate = S_PROP1,
	painstate = S_PROP1,
	painsound = sfx_dmpain,
	deathstate = S_PROP1_BREAK,
	deathsound = sfx_wbreak,
	spawnhealth = 50,
	speed = 0,
	radius = 96*FRACUNIT,
	height = 138*FRACUNIT,
	flags = MF_SHOOTABLE|MF_SOLID,
}
mobjinfo[MT_PROPWOOD].npc_name = "Wood Fence"
mobjinfo[MT_PROPWOOD].npc_spawnhealth = {5,15}
mobjinfo[MT_PROPWOOD].npc_name_color = SKINCOLOR_BROWN

states[S_PROP1] = {
	nextstate = S_PROP1,
	sprite = SPR_WPRP,
	frame = FF_FULLBRIGHT,
	tics = 2
}

states[S_PROP1_BREAK] = {
	nextstate = S_NULL,
	sprite = SPR_WPRP,
	action = A_Scream,
	frame = B,
	tics = 2
}

addHook("MobjCollide", function(mo,pmo)
	if pmo.skin ~= "zzombie" then
		P_SetObjectMomZ(mo,mo.scale*0)
		return false
	else
		P_SetObjectMomZ(mo,mo.scale*-128)
	end
end, MT_PROPWOOD)

mobjinfo[MT_INSTABURST] = {
	doomednum = -1,
	spawnhealth = 1,
	spawnstate = S_INSTABURST,
	radius = 72*FRACUNIT,
	height = 16*FRACUNIT,
	flags = MF_NOGRAVITY|MF_NOBLOCKMAP
}

states[S_INSTABURST] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST1A}
states[S_INSTABURST1A] = {SPR_ZMSH, 0|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST1B}
states[S_INSTABURST1B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST2A}
states[S_INSTABURST2A] = {SPR_ZMSH, 1|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST2B}
states[S_INSTABURST2B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST3A}
states[S_INSTABURST3A] = {SPR_ZMSH, 2|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST3B}
states[S_INSTABURST3B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST4A}
states[S_INSTABURST4A] = {SPR_ZMSH, 3|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST4B}
states[S_INSTABURST4B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST5A}
states[S_INSTABURST5A] = {SPR_ZMSH, 4|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST5B}
states[S_INSTABURST5B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_INSTABURST6A}
states[S_INSTABURST6A] = {SPR_ZMSH, 5|FF_FULLBRIGHT, 1, A_CapeChase, 0, 0, S_INSTABURST6B}
states[S_INSTABURST6B] = {SPR_NULL, 0, 1, A_CapeChase, 0, 0, S_NULL}

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

SRBZ:CreateItem("Automatic Ring",  {
	object = MT_THROWNAUTOMATIC,
	icon = "AUTOIND",
	firerate = 4,
	color = SKINCOLOR_GREEN,
	damage = 9,
	knockback = 30*FRACUNIT,
	flags2 = MF2_AUTOMATIC,
	price = 150,
})

SRBZ:CreateItem("Apple", {
	icon = "APPLEIND",
	iconscale = FU>>1,
	firerate = 50,
	sound = sfx_eatapl,
	limited = true,
	count = 5,
	ontrigger = function(player)
		SRBZ:ChangeHealth(player.mo, 16)
	end,
	price = 60,
})

SRBZ:CreateItem("Milk", {
	icon = "MILKIND",
	iconscale = FU>>1,
	firerate = 32,
	sound = sfx_gulpy,
	limited = true,
	count = 12,
	ontrigger = function(player)
		SRBZ:ChangeStamina(player, 25*FRACUNIT)
		SRBZ:ChangeHealth(player.mo, 4)
	end,
	price = 110,
})

SRBZ:CreateItem("I want summa that", {
	icon = "SUMMAIND",
	iconscale = FU/2,
	firerate = 70,
	sound = sfx_oyahx,	
})

SRBZ:CreateItem("Insta Burst", {
	icon = "ZMISHIND",
	firerate = 42,
	sound = sfx_zish1,
	damage = 25,
	ontrigger = function(player)
		local brange = 256*FU
		local range = 160*FU
		local instaburst = P_SpawnMobjFromMobj(player.mo, 0, 0, 0, MT_INSTABURST)
		instaburst.target = player.mo
		instaburst.spritexscale = $*2
		instaburst.spriteyscale = $*2
		instaburst.scale = $*3/2
		instaburst.forcedamage = SRBZ:FetchInventorySlot(player).damage
		
		searchBlockmap("objects", function(refmobj,foundmobj)
			if not L_ZCollide(foundmobj,instaburst) then 
				return false
			end
			
			if (foundmobj.valid and ((foundmobj.flags & (MF_SHOOTABLE)) or foundmobj.player)) and R_PointToDist2(foundmobj.x,foundmobj.y, instaburst.x, instaburst.y) < range then
				P_DamageMobj(foundmobj, instaburst, instaburst.target)
			end
		end, 
		instaburst, 
		instaburst.x-brange,instaburst.x+brange,
		instaburst.y-brange,instaburst.y+brange)
	end,
})
SRBZ:CreateItem("W's mirror", {
	icon = "MIRRORIND",
	firerate = TICRATE*5,
	sound = sfx_mrr12,
	limited = true,
	count = 5,
	price = 230,
	ontrigger = function(player)
		local mirrorclone = P_SpawnMobjFromMobj(player.mo,0,0,0,MT_MIRRORCLONE)
		mirrorclone.target = player.mo
		mirrorclone.skin = player.mo.skin
		mirrorclone.color = player.mo.color
		mirrorclone.health = player.mo.health
		mirrorclone.maxhealth = player.mo.maxhealth
		mirrorclone.alias = player.name
		mirrorclone.angle = player.mo.angle
		mirrorclone.forcedamage = SRBZ:FetchInventorySlot(player).damage
	end
})

addHook("MobjCollide", function(mo,pmo)
	if pmo.player then
		if pmo.skin == "zzombie" then
			local thok = P_SpawnMobjFromMobj(mo,0,0,0,MT_THOK)
			thok.color = mo.color
			thok.fuse = 17
			P_FlashPal(pmo.player, 3, 5*TICRATE)
			P_Thrust(pmo, mo.angle, 180*FRACUNIT)
			S_StartSound(pmo, sfx_bewar2)
			P_SetScale(thok,thok.scale*3)
			P_RemoveMobj(mo)
		else
			return false
		end
	end
end, MT_MIRRORCLONE)

SRBZ:CreateItem("Tails' fence", {
	icon = "FENCEIND",
	firerate = TICRATE*8,
	limited = true,
	count = 5,
	ontrigger = function(player)
		local wood = P_SpawnMobj(player.mo.x+FixedMul(128*FRACUNIT, cos(player.mo.angle)),
					             player.mo.y+FixedMul(128*FRACUNIT, sin(player.mo.angle)), 
								 player.mo.z, MT_PROPWOOD)
		wood.angle = player.mo.angle+ANGLE_90
		S_StartSound(player.mo, sfx_jshard)
		wood.renderflags = $|RF_PAPERSPRITE
		wood.target = player.mo
	end,
	price = 110,
})

SRBZ:CreateItem("Explosion Ring", {
	object = MT_THROWNEXPLOSION,
	icon = "BOMBIND",
	firerate = TICRATE*3,
	color = SKINCOLOR_BLACK,
	damage = 29,
	knockback = 90*FRACUNIT,
	price = 240,
})

SRBZ:CreateItem("Negative Ring",  {
	object = MT_REDRING,
	icon = "NEGATIVERINGIND",
	firerate = 25,
	color = SKINCOLOR_WHITE,
	knockback = 80*FRACUNIT,
	damage = 27,
	onhit = function(mo, hit)
		P_SetObjectMomZ(hit, 15*FU)
		if hit.player then
			P_FlashPal(hit.player, 3, 5)
		end
	end,
	onspawn = function(pmo, mo)
		mo.momx = $>>2
		mo.momy = $>>2
		mo.momz = $>>2
		mo.scale = $*2
	end,
	price = 650,
})

SRBZ:CreateItem("Blue Spring",  {
	icon = "BLUESPRINGIND",
	firerate = 2*TICRATE,
	limited = true,
	count = 5,
	ontrigger = function(player)
		local spring = P_SpawnMobj(player.mo.x+FixedMul(128*FRACUNIT, cos(player.mo.angle)),
					             player.mo.y+FixedMul(128*FRACUNIT, sin(player.mo.angle)), 
								 player.mo.z, MT_BLUESPRING)
		spring.angle = player.mo.angle+ANGLE_90
		S_StartSound(player.mo, sfx_jshard)
		spring.target = player.mo
	end,
	price = 120,
})

SRBZ:CreateItem("Bounce Ring",  {
	object = MT_THROWNBOUNCE,
	icon = "BNCEIND",
	firerate = 8,
	knockback = 20*FRACUNIT,
	damage = 11,
	fuse = 10*TICRATE,
	flags2 = MF2_BOUNCERING,
	price = 220,
})

SRBZ:CreateItem("Scatter Ring",  {
	icon = "SCATIND",
	firerate = TICRATE,
	sound = sfx_shgn,
	knockback = 13*FRACUNIT,
	damage = 11,
	fuse = TICRATE>>1,
	color = SKINCOLOR_PURPLE,
	price = 250,
	ontrigger = function(player)
		local mt = MT_SRBZ_THROWNSCATTER
		local mo = player.mo
		local spread = 4
		--S_StartSound(mo, sfx_shgn)
		for i = -1, 1
			local shot = P_SPMAngle(mo, mt, mo.angle + i * ANG1*spread, 1, 0)
			if shot and shot.valid
				shot.color = SRBZ:FetchInventorySlot(player).color
				shot.fuse = SRBZ:FetchInventorySlot(player).fuse
				shot.forcedamage = SRBZ:FetchInventorySlot(player).damage
				shot.forceknockback = SRBZ:FetchInventorySlot(player).knockback
				
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = SRBZ:FetchInventorySlot(player).color
				shot.fuse = SRBZ:FetchInventorySlot(player).fuse
				shot.forcedamage = SRBZ:FetchInventorySlot(player).damage
				shot.forceknockback = SRBZ:FetchInventorySlot(player).knockback

				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		if not P_IsObjectOnGround(mo)
			local aim = max(-FRACUNIT, min(FRACUNIT, -player.aiming/13000))
			if P_MobjFlip(mo) * aim > 0
				aim = ($ * 2)>>3
			end
			mo.momz = $ + FixedMul(mo.scale, aim)
			P_Thrust(mo, mo.angle, -FRACUNIT*9)
		end
	end
})

SRBZ:CreateItem("Green Shell",  {
	object = MT_SHELL,
	icon = "SHELLIND",
	firerate = 20,
	fuse = 5*TICRATE,
	color = SKINCOLOR_GREEN,
	knockback = 15*FU,
	damage = 12,
	onspawn = function(pmo, mo)
		mo.scale = $*2
	end,
	onhit = function(pmo, hit, shell)
		shell.fuse = 1
	end,
	price = 340,
})

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

SRBZ:CreateItem("Scatra",  {
	icon = "SCATRAIND",
	firerate = TICRATE/3,
	sound = sfx_shgn,
	knockback = 30*FRACUNIT,
	damage = 9,
	fuse = TICRATE>>3,
	color = SKINCOLOR_DUSK,
	price = 850,
	ontrigger = function(player)
		local mt = MT_SRBZ_THROWNSCATTER
		local mo = player.mo
		local spread = 4
		--S_StartSound(mo, sfx_shgn)
		for i = -1, 1
			local shot = P_SPMAngle(mo, mt, mo.angle + i * ANG1*spread, 1, 0)
			if shot and shot.valid
				shot.color = SRBZ:FetchInventorySlot(player).color
				shot.fuse = SRBZ:FetchInventorySlot(player).fuse
				shot.forcedamage = SRBZ:FetchInventorySlot(player).damage
				shot.forceknockback = SRBZ:FetchInventorySlot(player).knockback
				shot.colorized = true
				
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = SRBZ:FetchInventorySlot(player).color
				shot.fuse = SRBZ:FetchInventorySlot(player).fuse
				shot.forcedamage = SRBZ:FetchInventorySlot(player).damage
				shot.forceknockback = SRBZ:FetchInventorySlot(player).knockback
				shot.colorized =  true
				
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		if not P_IsObjectOnGround(mo)
			local aim = max(-FRACUNIT, min(FRACUNIT, -player.aiming/13000))
			if P_MobjFlip(mo) * aim > 0
				aim = ($ * 2)>>3
			end
			mo.momz = $ + FixedMul(mo.scale, aim)
			P_Thrust(mo, mo.angle, -FRACUNIT*9)
		end
	end
})

addHook("MobjCollide", function(thing, tmthing)
	if gametype ~= GT_SRBZ then return end
	if thing.type == tmthing.type then
		return false
	end
end, MT_SHELL)
