/*
	File: CQC_capturealpha.sqf
	Author: Ryn
*/

_CQC_alpha = ceil(random 12);

if (_CQC_alpha isEqualTo 1) then {
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_0"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_0" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_0");
} else {
	_CQC_alpha = 2;
};};
if (_CQC_alpha isEqualTo 2) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_1"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_1" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_1");
} else {
	_CQC_alpha = 3;
};};
if (_CQC_alpha isEqualTo 3) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_2"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_3" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_3");
} else {
	_CQC_alpha = 4;
};};
if (_CQC_alpha isEqualTo 4) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_4"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_4" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then {
		closeDialog 1; 
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_4");
} else {
	_CQC_alpha = 5;
};};
if (_CQC_alpha isEqualTo 5) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_5"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_5" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca;
		player setDir (markerDir "CQC_capturealpha_5");
} else {
	_CQC_alpha = 6;
};};
if (_CQC_alpha isEqualTo 6) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_6"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_6" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_6");
} else {
	_CQC_alpha = 7;
};};
if (_CQC_alpha isEqualTo 7) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_7"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_7" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then {
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_7");
} else {
	_CQC_alpha = 8;
};};
if (_CQC_alpha isEqualTo 8) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_8"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_8" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_8");
} else {
	_CQC_alpha = 9;
};};
if (_CQC_alpha isEqualTo 9) then {	
	CQC_marker_ca = getMarkerPos "CQC_capturealpha_9"; 
	CQC_caCheck = getMarkerpos "CQC_capturealpha_9" nearEntities [["man"], 15];
	if (CQC_caCheck isEqualTo []) then { 
		closeDialog 1;
		player setPos CQC_marker_ca; 
		player setDir (markerDir "CQC_capturealpha_9");
} else {
	["All spawns blocked. Try again."] spawn CQC_fnc_Notification;
};};