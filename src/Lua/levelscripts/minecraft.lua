freeslot("MT_MCTORCH","S_MCTORCH","SPR_MCTR")
freeslot("MT_CREEPER","S_CREEPER","SPR_CRPR")


mobjinfo[MT_MCTORCH] = {
	doomednum = 2308,
	spawnstate = S_MCTORCH,
	spawnhealth = 100,
	reactiontime = 8,
	radius = 8*FRACUNIT,
	height = 16*FRACUNIT,
	flags =	MF_NOBLOCKMAP|MF_NOGRAVITY|MF_SCENERY,
	seestate = S_MCTORCH,
}

states[S_MCTORCH] = {
	sprite = SPR_MCTR,
	frame = A,
	tics = 0,
	nextstate = S_MCTORCH,
}

mobjinfo[MT_CREEPER] = {
	doomednum = 2308,
	spawnstate = S_CREEPER,
	spawnhealth = 100,
	reactiontime = 8,
	radius = 48*FRACUNIT,
	height = 85*FRACUNIT,
	flags =	MF_NOBLOCKMAP|MF_NOGRAVITY|MF_SCENERY,
	seestate = S_CREEPER,
}

states[S_CREEPER] = {
	sprite = SPR_CRPR,
	frame = A,
	tics = 0,
	nextstate = S_CREEPER,
}

/*
Object MT_MCTORCH
MapThingNum = 2308
SpawnState = S_MCTORCH
SpawnHealth = 100
ReactionTime = 8
SeeState = S_NULL
SeeSound = 0
AttackSound = sfx_None
PainState = S_NULL
PainChance = 0
PainSound = sfx_None
Speed = 1
MeleeState = S_NULL
MissileState = S_NULL
DeathState = S_NULL
XDeathState = S_NULL
DeathSound = sfx_None
Radius = 8*FRACUNIT
Height = 16*FRACUNIT
Mass = 0
Damage = 0
ActiveSound = sfx_None
Flags =	MF_NOBLOCKMAP|MF_NOGRAVITY|MF_SCENERY
RaiseState = S_NULL
*/