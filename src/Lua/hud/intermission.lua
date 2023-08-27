local tx = CV_RegisterVar({
	name = "tx",
	defaultvalue = "0",
	PossibleValue = CV_Unsigned,
})
local ty = CV_RegisterVar({
	name = "ty",
	defaultvalue = "0",
	PossibleValue = CV_Unsigned,
})
SRBZ.intermissionhud = function(v, player)
	if not SRBZ.game_ended then return end
	
	local animlength = 3*TICRATE
	local x1 = {
		start = -400,
		stop = 50
	}
	local x2 = {
		start = 700,
		stop = 220
	}
	local bg = { -- background
		start = 9,
		stop = 6
	}	
	local bl = { -- bang lower's y
		start = 168+300,
		stop = 168
	}
	local bu = { -- bang upper's y
		start = -300,
		stop = 0
	}

	
	local z_team = v.cachePatch("Z_SURVIVORS")
	local z_w = v.cachePatch("Z_WIN")
	local z_bu = v.cachePatch("Z_BANG_UPPER_BLUE")
	local z_bl = v.cachePatch("Z_BANG_LOWER_BLUE")
	local z_bg = v.cachePatch("Z_BG_BLUE")
	
	if SRBZ.team_won == 2 then
		z_bu = v.cachePatch("Z_BANG_UPPER_RED")
		z_bl = v.cachePatch("Z_BANG_LOWER_RED")
		z_bg = v.cachePatch("Z_BG_RED")
		z_team = v.cachePatch("Z_ZOMBIES")
	end
	
	local scroll = (SRBZ.win_tics%128)
	
	x1.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),x1.start*FU,x1.stop*FU)
	x2.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),x2.start*FU,x2.stop*FU)
	bg.ese = bg.start-(FixedDiv(SRBZ.win_tics*FU, animlength*FU/2)*9/FU)
	bl.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),bl.start*FU,bl.stop*FU)
	bu.ese = ease.outquart(FixedDiv(SRBZ.win_tics*FU, animlength*FU),bu.start*FU,bu.stop*FU)
	
	
	if bg.ese > 5 then
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, bg.ese<<V_ALPHASHIFT)
	else
		v.drawScaled(-500*FU,-500*FU, FU*1000, z_bg, 5<<V_ALPHASHIFT)
	end
	if not SRBZ.NextMapVoted then
		if SRBZ.win_tics < SRBZ.MapVoteStartFrame then
			v.drawScaled(min(x1.ese, x1.stop*FU),100*FU, FU, z_team)
			v.drawScaled(max(x2.ese, x2.stop*FU),100*FU, FU, z_w)
		elseif SRBZ.MapsOnVote and #SRBZ.MapsOnVote >= 3 then
			local selection = player["srbz_info"].vote_selection
			local cursor_patch = v.cachePatch("SLCT1LVL")
			local map_y = 75*FU

			v.drawString(160*FU,42*FU,"\x82VOTE:\x80 JUMP    \x82 CANCEL:\x80 SPIN", V_SNAPTOTOP, "thin-fixed-center")
			
			for i=1,-1,-1 do
				local numonlist = i+2
				local map_patch = v.cachePatch(G_BuildMapName(SRBZ.MapsOnVote[4-numonlist][2]).."P")
				local levelname = (mapheaderinfo[SRBZ.MapsOnVote[4-numonlist][2]].lvlttl)
				local map_votes = SRBZ.MapsOnVote[4-numonlist][1]
				
				if levelname:len() > 16 then
					levelname = $:sub(1,16)..".."
				end
				local map_x = 120*FU-(i*100*FU)
				--SRBZ.MapVotes
				
				v.drawScaled(map_x,map_y,FU>>1,map_patch)
				v.drawString(map_x,map_y-(8*FU),levelname, nil, "thin-fixed")
				v.drawString(map_x+(38*FU),map_y+(60*FU),map_votes, nil, "thin-fixed")
			end
			v.drawScaled(-80*FU+((selection)*100*FU),map_y,FU>>1,cursor_patch)
			
			
			v.drawString(160*FU,50*FU,"\x82"..((SRBZ.MapVoteStartFrame + SRBZ.VoteTimeLimit) - SRBZ.win_tics)/TICRATE, (V_SNAPTOTOP), "fixed-center")
		end
	else
		local map_patch = v.cachePatch(G_BuildMapName(SRBZ.NextMapVoted).."P")
		local levelname = (mapheaderinfo[SRBZ.NextMapVoted].lvlttl)
		v.drawScaled(120*FU,75*FU,FU>>1,map_patch)
		v.drawString(160*FU,50*FU,"\x82"..levelname.." Was picked as the next map!", (V_SNAPTOTOP), "fixed-center")
	end
	for i=-5,5
		v.drawScaled((i*128*FU)+(scroll*FU),max(bl.ese,bl.stop*FU),FU,z_bl,V_SNAPTOBOTTOM)
	end
	for i=-5,5
		v.drawScaled((i*128*FU)-(scroll*FU),min(bu.ese,bu.stop*FU),FU,z_bu,V_SNAPTOTOP)
	end

end