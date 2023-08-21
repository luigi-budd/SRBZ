dofile "init/gametype.lua"

dofile "libraries/customhudlib.lua"
dofile "libraries/countingplayers.lua"
dofile "libraries/getcharacterlist.lua"
dofile "libraries/mtimeconv.lua"
dofile "libraries/basexx.lua" -- https://github.com/aiq/basexx

dofile "main/netvars.lua"
dofile "main/characterconfigs.lua"
dofile "main/enemies.lua"
dofile "main/init_values.lua"
dofile "main/init_team.lua"
dofile "main/intermission.lua"
dofile "main/capitalism.lua"
dofile "main/characterselect_logic.lua"
dofile "main/megahp.lua"
dofile "main/giveplayerflags.lua"
dofile "main/exiting.lua"
dofile "main/healthncombat.lua"
dofile "main/weapons.lua"
dofile "main/lockplayerattributes.lua" -- keep player as zombie if team 2 and vice versa
dofile "main/timers.lua"
dofile "main/shop.lua"
dofile "main/name_tags.lua"
dofile "main/maptimers.lua"
dofile "main/zombiecheckpoints.lua"

dofile "hud/characterselect.lua"
dofile "hud/info.lua"
dofile "hud/shop.lua"
dofile "hud/inventory.lua"
dofile "hud/toggle.lua"
dofile "hud/intermission.lua"

dofile "hooks/gamelogic.lua"
dofile "hooks/hud.lua"

dofile "levelscripts/concealed_woodland.lua"
