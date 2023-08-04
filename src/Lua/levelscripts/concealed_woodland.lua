local function mapw1_button1()
      chatprint("\x85\The next room is locked...")
	  chatprint("\x85\There's a\x82\ button \x85\in this room, it is covered with something somewhere, though.")
end

local function mapw1_button2()
      chatprint("\x8D\The mud \x85\might have something you are searching for.")
	  chatprint("\x85\Just wait for it...")
end

addHook("LinedefExecute", mapw1_button1, "W1LEAFS")
addHook("LinedefExecute", mapw1_button2, "W1MOOD")
