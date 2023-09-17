-- dont overlook this script. you will get ignored

--[[
    Todo:

    Write rubies when making an account
    Auto Log in when walking
]]--
local _rchars_ = "abcdefghijklmnopqrstuvwxyz1234567890"
local commandtoken = P_RandomKey(FRACUNIT)

addHook("NetVars", function(net)
    commandtoken = net($)
end)

local function genRNGUsername(pname)
    if type(pname) == "string" then
        local extra = ""
        local extranum = 8

        for i=1,extranum do
            local nc = P_RandomKey(#_rchars_)+1
            local chartoget = _rchars_:sub(nc,nc)
            extra = $ + chartoget
        end

        return pname.."_"..extra
    end

    return
end

local function genRNGPassword()
    local extra = ""
    local extranum = 25

    for i=1,extranum do
        local nc = P_RandomKey(#_rchars_)+1
        local chartoget = _rchars_:sub(nc,nc)
        extra = $ + chartoget
    end
    return extra
end

local function usernameLoggedIn(username)
	for player in players.iterate do
		if player.registered_user == username then
			print(player.name)
			return true
		end
	end
	
	return false
end

COM_AddCommand("z_registeraccount", function(player, tplayer)
	if player ~= server and tplayer then
		if player == consoleplayer then
			print("illegal parameter")
		end
		return 
	end	
	
	local target_player = player
	
	if tplayer and players[tonumber(tplayer)] and players[tonumber(tplayer)].valid then
		target_player = players[tonumber(tplayer)] 
	end
	
    if (target_player.valid) and ((gamestate == GS_LEVEL) or (gamestate == GS_INTERMISSION)) then
        if not (target_player.registered) then
		
			
            local gen_username = genRNGUsername(target_player.name):gsub(" ","_")
            local gen_password = genRNGPassword()
            if (isserver) or (isdedicatedserver) then -- Server
                local server_passpath = "SRBZDATA/"..gen_username.."/password.sav2"
                local server_rubypath = "SRBZDATA/"..gen_username.."/rubies.sav2"
				
                local passfile = io.openlocal(server_passpath, "w+")
                local rubyfile = io.openlocal(server_rubypath, "w+")
				
				if passfile then
					passfile:write(gen_password)
					passfile:close()
				end
				
				if rubyfile then
					rubyfile:write(player.rubies)
					rubyfile:close()
				end
            end

            if (target_player == consoleplayer) then -- Client
                local clientpath = "client/SRBZ/account.sav2"
                local file = io.openlocal(clientpath, "w+")

                local clientpath_content = ('z_loginaccount '.. '"'.. gen_username ..'" '.. '"'.. gen_password ..'"')
				if file then
					file:write(clientpath_content)
					file:close()
				end
            end

            target_player.registered_user = gen_username
            target_player.registered = true
			print(target_player.name.." created an account ("..gen_username..")")
        end
    end
end)

COM_AddCommand("z_loginaccount", function(player, username, password)
    if (player.valid) and ((gamestate == GS_LEVEL) or (gamestate == GS_INTERMISSION)) then
        if (not (player.registered) or not (player.registered_user)) and (username and password) then
			if usernameLoggedIn(username) then
				if player == consoleplayer then
					print("Someone is already logged in this account. Try again. ".."("..username..")")
				end
				return
			end
			
            if (isserver) or (isdedicatedserver) then
			
				local passpath = "SRBZDATA/"..username.."/password.sav2"
				local passfile = io.openlocal(passpath)
				
				if passfile then
					local passcontent = passfile:read("*a")
					if passcontent and (passcontent == password) then
						COM_BufInsertText(server, "z_importdata "..#player.." "..username.." "..commandtoken)
					end
					passfile:close()
				else
					print(player.name.." tried to login as an invalid account. Registering the user.")
					COM_BufInsertText(server, "z_registeraccount "..#player)
				end

			end
			
        end
    end
end)

COM_AddCommand("z_importdata", function(player, playernum, username, token) -- make data server side
    if playernum ~= nil and username ~= nil and token ~= nil and ((gamestate == GS_LEVEL) or (gamestate == GS_INTERMISSION)) then
        if (tonumber(token) == commandtoken) and players[tonumber(playernum)] and players[tonumber(playernum)].valid then
			local target_player = players[tonumber(playernum)]
			
            if ((isserver) or (isdedicatedserver)) then
                local rubypath = "SRBZDATA/"..username.."/rubies.sav2"
                local rubyfile = io.openlocal(rubypath, "r")
				
                if rubyfile then
                    local rubyread = rubyfile:read("*a")
                    if rubyread then 
						COM_BufInsertText(server, "z_forcerubies "..#target_player.." "..rubyread.." "..commandtoken)
                    end
					rubyfile:close()
                end
			end
        end
    end
	
	if playernum and username and player == server then
		local target_player = players[tonumber(playernum)]
		
		target_player.registered_user = username
		target_player.registered = true
		print(target_player.name.." logged in as "..username)
	end
end, 1)

addHook("PlayerQuit", function(player)
	if ((isserver) or (isdedicatedserver)) then
		if player.registered_user and player.registered then
			local rubypath = "SRBZDATA/"..player.registered_user.."/rubies.sav2"
			local rubyfile = io.openlocal(rubypath, "w+")
			if rubyfile then
				rubyfile:write(player.rubies)
				rubyfile:close()
			end
		end
	end
end)

COM_AddCommand("z_forcerubies", function(player, playernum, rubies, token)
	if player == server and rubies ~= nil and token ~= nil and 
	playernum ~= nil and (tonumber(token) == commandtoken) then
		if players[tonumber(playernum)] then
			local target_player = players[tonumber(playernum)]
			target_player.rubies = tonumber(rubies)
		end
	end
end, 1)

addHook("PlayerCmd", function(player,cmd) -- auto login / register
	if (cmd.buttons or cmd.forwardmove) and (not (player.registered) and not (player.registered_user)) then
		local clientpath = "client/SRBZ/account.sav2"
        local file = io.openlocal(clientpath, "r")
		if file then
			COM_BufInsertText(player, file:read("*a"))
			file:close()
		else
			COM_BufInsertText(player, "z_registeraccount")
		end
	end
end)