rawset(_G, 'L_ZCollide', function(mo1,mo2)
	if mo1.z > mo2.height+mo2.z then return false end
	if mo2.z > mo1.height+mo1.z then return false end
	return true
end)

-- code by buggiethebug
rawset(_G, "P_FlyTo", function(mo, fx, fy, fz, sped, addques) --A very useful command honestly.
    if mo.valid
        local flyto = P_AproxDistance(P_AproxDistance(fx - mo.x, fy - mo.y), fz - mo.z)
        if flyto < 1
            flyto = 1
        end
        --local anglesucc = R_PointToAngle2(mo.x, mo.y, fx, fy)
        
        if addques
            mo.momx = $ + FixedMul(FixedDiv(fx - mo.x, flyto), sped)
            mo.momy = $ + FixedMul(FixedDiv(fy - mo.y, flyto), sped)
            mo.momz = $ + FixedMul(FixedDiv(fz - mo.z, flyto), sped)
        else
            mo.momx = FixedMul(FixedDiv(fx - mo.x, flyto), sped)
            mo.momy = FixedMul(FixedDiv(fy - mo.y, flyto), sped)
            mo.momz = FixedMul(FixedDiv(fz - mo.z, flyto), sped)
        end    
    end    
end)

rawset(_G,'L_DoBrakes', function(mo,factor)
	mo.momx = FixedMul($,factor)
	mo.momy = FixedMul($,factor)
	mo.momz = FixedMul($,factor)
end)

rawset(_G,'L_SpeedCap', function(mo,limit,factor)
	local spd_xy = R_PointToDist2(0,0,mo.momx,mo.momy)
	local spd, ang =
		R_PointToDist2(0,0,spd_xy,mo.momz),
		R_PointToAngle2(0,0,mo.momx,mo.momy)
	if spd > limit
		if factor == nil
			factor = FixedDiv(limit,spd)
		end
		L_DoBrakes(mo,factor)
		return factor
	end
end)