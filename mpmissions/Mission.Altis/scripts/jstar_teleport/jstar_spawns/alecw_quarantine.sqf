/*
	File: alecw_quarantine.sqf
	Author: AlecW
*/

_alecwQuarantine = ceil(random 16);
if (_alecwQuarantine isEqualTo 1) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_1"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_1" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_1");
} else {
	_alecwQuarantine = 2;
};};

if (_alecwQuarantine isEqualTo 2) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_2"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_2" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_2");
} else {
	_alecwQuarantine = 3;
};};

if (_alecwQuarantine isEqualTo 3) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_3"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_3" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_3");
} else {
	_alecwQuarantine = 4;
};};

if (_alecwQuarantine isEqualTo 4) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_4"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_4" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_4");
} else {
	_alecwQuarantine = 5;
};};

if (_alecwQuarantine isEqualTo 5) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_5"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_5" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_5");
} else {
	_alecwQuarantine = 6;
};};

if (_alecwQuarantine isEqualTo 6) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_6"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_6" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_6");
} else {
	_alecwQuarantine = 7;
};};

if (_alecwQuarantine isEqualTo 7) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_7"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_7" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_7");
} else {
	_alecwQuarantine = 8;
};};

if (_alecwQuarantine isEqualTo 8) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_8"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_8" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_8");
} else {
	_alecwQuarantine = 9;
};};

if (_alecwQuarantine isEqualTo 9) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_9"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_9" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_9");
} else {
	_alecwQuarantine = 10;
};};

if (_alecwQuarantine isEqualTo 10) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_10"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_10" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_10");
} else {
	_alecwQuarantine = 11;
};};

if (_alecwQuarantine isEqualTo 11) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_11"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_11" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_11");
} else {
	_alecwQuarantine = 12;
};};

if (_alecwQuarantine isEqualTo 12) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_12"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_12" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_12");
} else {
	_alecwQuarantine = 13;
};};

if (_alecwQuarantine isEqualTo 13) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_13"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_13" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_13");
} else {
	_alecwQuarantine = 14;
};};

if (_alecwQuarantine isEqualTo 14) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_14"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_14" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_14");
} else {
	_alecwQuarantine = 15;
};};


if (_alecwQuarantine isEqualTo 15) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_15"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_15" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_15");
} else {
	_alecwQuarantine = 16;
};};


if (_alecwQuarantine isEqualTo 16) then {
	_alecwMarker = getMarkerPos "alecw_quarantine_16"; 
	alecw_quarantineSpawnCheck = getMarkerpos "alecw_quarantine_16" nearEntities [["man"], 10];
	if (alecw_quarantineSpawnCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos _alecwMarker; 
		player setDir (markerDir "alecw_quarantine_16");
} else {
	["All spawns blocked. Try again."] spawn CQC_fnc_Notification;
};};