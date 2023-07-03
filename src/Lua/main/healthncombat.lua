SRBZ.ChangeHealth = function(mobj, amount)
	if amount > mobj.maxhealth then
		mobj.health = mobj.maxhealth
	else
		mobj.health = $ + ammount
	end
end

SRBZ.LimitMobjHealth = function(mobj)
	if mobj.health and mobj.maxhealth then
		if mobj.maxhealth > mobj.health then
			mobj.health = mobj.maxhealth
		end
	end
end