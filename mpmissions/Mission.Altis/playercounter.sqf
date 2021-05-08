[] spawn {
	while {true} do {
		cntPly = {
			_x distance player < 500;
		} count allPlayers;
		uiSleep 1;
	};
};

[] spawn {	
	while {true} do {
		uiSleep 1;
	
		if (player distance (markerPos "spawnMarker") > 200) then {
			atSpawn = false;
		} else {
			atSpawn = true;
		};
		
		if ( cntPly isEqualTo 1 && !atSpawn ) then {
			uiSleep 4;
			["You're the only one here, press shift + T to teleport elsewhere"] spawn CQC_fnc_Notification;
			canTeleport = true;
		} else {
			canTeleport = false;
		};
	};	
};	