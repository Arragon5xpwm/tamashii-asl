// AstridTheHorrorGirl's favorite platformer 
state("TAMASHII") {
	uint roomID: "TAMASHII.exe", 0x64E608;
	uint pausedState: "TAMASHII.exe", 0x0043DD44, 0x0, 0x8C4, 0x2C, 0xCC; // not used atm
	uint xPos:  "TAMASHII.exe", 0x0043DD3C, 0x37C, 0xD4, 0x8, 0x17C, 0x178, 0xE8;
}

startup {
	vars.checkpoints = new Dictionary<string, uint>() {
		{"mainMenuID", 6},
		{"introCutsceneID", 8}, 	// Start of Run
		{"boss1DeadID", 44},    	// Dangly Boi
		{"boss2DeadID", 65},		// a.k.a Meat Room, End of Autoscroller #1
		{"boss3DeadID", 83},		// BigScared's Waifu
		{"boss4DeadID", 102},		// End of Autoscroller #2
		{"mistressDoneID", 117},	// Mistress
		{"guardianDeadID", 120},	// SHMUPS Baby
		{"endingID", 147}			// Womb Raider
	};	
}

split {
	// Are we in the End of Game room
	if (current.roomID == vars.checkpoints["endingID"]) {
		// once the player collision with fetus is detected, he is moved to xPos=720
		if (current.xPos == 720) {
			// this may split repeatedly till ending timer 
			return true;
		}
		// player is still traversing the room
		return false;
	}
	// room has changed
	if (current.roomID != old.roomID) {
		// is it any of our checkpoints?
		if (vars.checkpoints.ContainsValue(current.roomID)) {
			// we rather want to reset the run?
			if (current.roomID == vars.checkpoints["mainMenuID"]) {
				return false;
			}
			// we just strarted
			if (current.roomID == vars.checkpoints["introCutsceneID"]) {
				return false;
			}
			return true;
		}
	}
	return false; 
}

start { 
	if ((current.roomID != old.roomID) && (current.roomID == vars.checkpoints["introCutsceneID"])) {
		return true;
	}
	return false;
}
