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
	"SPR_ZMSH",
	"SFX_ZISH1"
)

freeslot("MT_PROPWOOD","S_PROP1","S_PROP1_BREAK","SPR_WPRP")
freeslot("MT_MIRRORCLONE")

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
	firerate = 19,
	color = SKINCOLOR_RED,
	knockback = 45*FRACUNIT,
	damage = 17,
	price = 50,
})

SRBZ:CreateItem("Automatic Ring",  {
	object = MT_THROWNAUTOMATIC,
	icon = "AUTOIND",
	firerate = 4,
	color = SKINCOLOR_GREEN,
	damage = 9,
	knockback = 30*FRACUNIT,
	flags2 = MF2_AUTOMATIC,
	price = 130,
})

SRBZ:CreateItem("Apple", {
	icon = "APPLEIND",
	firerate = 50,
	sound = sfx_eatapl,
	limited = true,
	count = 5,
	ontrigger = function(player)
		if player.mo.health == player.mo.maxhealth then
			return true
		end
		SRBZ:ChangeHealth(player.mo, 8)
	end,
	price = 60,
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
	sound = sfx_oyahx,
	limited = true,
	count = 3,
	price = 200,
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
	price = 190,
})

SRBZ:CreateItem("Explosion Ring", {
	object = MT_THROWNEXPLOSION,
	icon = "BOMBIND",
	firerate = TICRATE*3,
	color = SKINCOLOR_BLACK,
	damage = 29,
	knockback = 90*FRACUNIT,
	price = 230,
})
