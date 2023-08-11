freeslot("S_POSS_PAIN","S_POSS_PAIN2","S_SPOS_PAIN","S_SPOS_PAIN2")

states[S_POSS_PAIN] = {
	sprite = SPR_POSS,
	frame = A,
	tics = 6,
	action = A_PlaySound,
	var1 = sfx_dmpain,
	var2 = 1,
	nextstate = S_POSS_PAIN2
}

states[S_POSS_PAIN2] = {
	sprite = SPR_POSS,
	frame = A,
	tics = 0,
	action = A_SetObjectFlags2,
	var1 = MF2_FRET,
	var2 = 1,
	nextstate = S_POSS_RUN1
}
states[S_SPOS_PAIN] = {
	sprite = SPR_SPOS,
	frame = A,
	tics = 4,
	action = A_PlaySound,
	var1 = sfx_dmpain,
	var2 = 1,
	nextstate = S_SPOS_PAIN2
}

states[S_SPOS_PAIN2] = {
	sprite = SPR_POSS,
	frame = A,
	tics = 0,
	var1 = MF2_FRET,
	var2 = 1,
	action = A_SetObjectFlags2,
	nextstate = S_SPOS_RUN1
}

SRBZ.playerfunc = function(player)
	if gametype ~= GT_SRBZ and leveltime then return end
	local pmo = player.mo
	
	if player and player.mo.valid then
		SRBZ.SetCCtoplayer(player)
		SRBZ.SetCChealth(player)
	end
end

mobjinfo[MT_BLUECRAWLA].npc_name = "Blue Crawla"
mobjinfo[MT_BLUECRAWLA].npc_spawnhealth = {12,23}
mobjinfo[MT_BLUECRAWLA].npc_name_color = SKINCOLOR_BLUE
mobjinfo[MT_BLUECRAWLA].rubydrop = {3,6}
mobjinfo[MT_BLUECRAWLA].painstate = S_POSS_PAIN
--
--S_POSS_PAIN2


mobjinfo[MT_REDCRAWLA].npc_name = "Red Crawla"
mobjinfo[MT_REDCRAWLA].npc_spawnhealth = {30,60}
mobjinfo[MT_REDCRAWLA].npc_name_color = SKINCOLOR_RED
mobjinfo[MT_REDCRAWLA].rubydrop = {6,10}
mobjinfo[MT_REDCRAWLA].painstate = S_SPOS_PAIN
