rawset(_G, "SRBZ", {});
/* Was meant for the ringslinger-esk system. Might use this name for separating 
what SRBZ has.

rawset(_G, "XSLINGER", {});
*/

freeslot("sfx_zdi1","sfx_zdi2","sfx_zish1","sfx_zpa1","sfx_zpa2")
freeslot("sfx_rstart", "sfx_secret", "sfx_cleva1")
freeslot("sfx_eatapl", "sfx_oyahx", "sfx_mnu1a")
freeslot("sfx_inf1","sfx_inf2","sfx_pipe")

freeslot("sfx_z_rel1", "sfx_z_rel2")

freeslot("sfx_oldrad")

rawset(_G, "srbz_modname", "srbz"); -- For customhud.


freeslot("TOL_SRBZ");

rawset(_G, "P_GivePlayerRubies", function(player, amount)
	if player.rubies == nil then
		player.rubies = 0
	end
	
	if amount > SRBZ.RubyLimit then
		player.rubies = SRBZ.RubyLimit
	else
		player.rubies = $ + amount
	end
end)

SRBZ.wait_time = 25*TICRATE;
SRBZ.MapVoteStartFrame = 10*TICRATE
SRBZ.VoteTimeLimit = 12*TICRATE

SRBZ.init_gamevars = function(map) -- Variables vary per game.
	SRBZ.round_active = false;
	SRBZ.game_ended = false;
	SRBZ.win_tics = 0; -- How many tics after a win screen. Resets on mapload.
	SRBZ.game_time = 0;
	SRBZ.time_limit = 0;
	SRBZ.team_won = 0;
	
	SRBZ.MapVoteList = {}
	SRBZ.MapVotes = {0,0,0}
	SRBZ.MapsOnVote = {
	{0,1},
	{0,1},
	{0,1}
	} -- votes, mapnumber
	
	SRBZ.NextMapVoted = 0
	
	if map then
		if mapheaderinfo[map].srbz_timelimit then
			local input = tonumber(mapheaderinfo[map].srbz_timelimit)
			SRBZ.time_limit = input*60*TICRATE
		end
	end
	
	for player in players.iterate do
		player.zteam = 1;
		if player["srbz_info"] then
			player["srbz_info"].ghostmode = false
			player["srbz_info"].vote_selection = 1
			player["srbz_info"].voted = false
		end
	end
end; SRBZ.init_gamevars();

-- http://lua-users.org/wiki/CopyTable
function SRBZ:Copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

SRBZ.teams = {"Survivors", "Zombies"}

G_AddGametype({
	name = "SRBZ Survival",
	identifier = "srbz",
	typeoflevel = TOL_SRBZ,
	rules = GTR_TIMELIMIT|GTR_ALLOWEXIT|GTR_RESPAWNDELAY|GTR_SPAWNENEMIES|GTR_CUTSCENES|GTR_SPECTATORS|GTR_NOSPECTATORSPAWN,
	intermissiontype = int_none, -- No intermission screen for possible inbuilt screen.
	--headerleftcolor = 152,
	--headerrightcolor = 40,
	description = "Escape from the Zombies! Don't get caught and eaten by them! They can catch up with you anytime..."
})

sfxinfo[sfx_zdi1].caption="Zombie scream"
sfxinfo[sfx_zdi2].caption="Zombie scream"
sfxinfo[sfx_zpa1].caption="Zombie pain"
sfxinfo[sfx_zpa2].caption="Zombie pain"
sfxinfo[sfx_zish1].caption="Swoop"

sfxinfo[sfx_rstart].caption="Zombies escaped..."
sfxinfo[sfx_secret].caption="Secret revealed!"
sfxinfo[sfx_cleva1].caption="\"Calling for transport!\""

sfxinfo[sfx_eatapl].caption="Num num num!"
sfxinfo[sfx_oyahx].caption="OHHH YEAH"
sfxinfo[sfx_mnu1a].caption="Selecting"

sfxinfo[sfx_inf1].caption="\"The zombies will be back\""
sfxinfo[sfx_inf2].caption="\"We've been enslaved\""
sfxinfo[sfx_pipe].caption="Pipe"

sfxinfo[sfx_oldrad].caption="Typewriter"
