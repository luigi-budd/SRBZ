local function maptf_wall1()
      chatprint("\x8D\The Stone Wall \x80will open in\x82\ 25 \x80seconds")
end

local function maptf_wall2()
      chatprint("\x8D\The Stone Wall \x80will open in\x82\ 30 \x80seconds")
end

local function maptf_risingplatform()
      chatprint("\x85\Watch out for the rising platform at the center of the stage")
end

local function maptf_platformfaillaughatthissurvivor()
      chatprint("Nobody stood long enough in the platform")
	  chatprint("Truly sucks to suck")
end

addHook("LinedefExecute", maptf_wall1, "FARWAL1")
addHook("LinedefExecute", maptf_wall2, "FARWAL2")
addHook("LinedefExecute", maptf_risingplatform, "RISINGP")
addHook("LinedefExecute", maptf_platformfaillaughatthissurvivor, "PLTFAIL")