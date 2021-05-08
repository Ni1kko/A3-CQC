/*
	File: travel_Move.sqf
	Author: JSt4r
*/

disableSerialization;

_selection = _this select 0;
_index = _selection select 1;

switch (_index) do {

		case 0 : {
			closeDialog 500;
			execVM "scripts\jstar_scripts\jstar_repair.sqf";
		};
		
		case 1 : {
			closeDialog 500;
			execVM "scripts\jstar_scripts\jstar_flip.sqf";
		};
	};