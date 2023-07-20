SRBZ.ChangeHealth = function(mobj, amount)
	if amount > mobj.maxhealth then
		mobj.health = mobj.maxhealth
	else
		mobj.health = $ + ammount
	end
end

SRBZ.LimitMobjHealth = function(mobj)
	if mobj.health and mobj.maxhealth then
		if mobj.health > mobj.maxhealth then
			mobj.health = mobj.maxhealth
		end
	end
end

addHook("MobjDamage", function(mo, inf, src, dmg)
	if (gametype ~= GT_SRBZ) return end
	if inf.player and mo.player then
		if mo.player.zteam == inf.player.zteam then
			return true
		end
	end
	if dmg >= mo.health then
		P_KillMobj(mo)
		return true
	end
	mo.player.powers[pw_flashing] = 35
	P_FlashPal(mo.player, PAL_NUKE, 2)
	if mo.player then
		S_StartSound(mo, sfx_s3kb9)
	end
	local speed1 = FixedHypot(FixedHypot(inf.momx, inf.momy), inf.momz)
	--P_SetObjectMomZ(mo, 5*FRACUNIT)
	--P_Thrust(mo, inf.angle, speed1*5)
	mo.health = $ - dmg
	return true
end, MT_PLAYER)

addHook("MobjMoveCollide", function(thing,tmthing)
	if (gametype ~= GT_SRBZ) return end
	if L_ZCollide(thing,tmthing) then
		local speed1 = FixedHypot(FixedHypot(tmthing.momx, tmthing.momy), tmthing.momz)
		local speed2 = FixedHypot(FixedHypot(thing.momx, thing.momy), thing.momz)
		
		if speed1 > speed2 and tmthing.player and tmthing.player.valid
		and not tmthing.player.powers[pw_flashing] then
			P_DamageMobj(thing, tmthing, nil, 10)
		end
	end
end)