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
			[] spawn CQC_fnc_repairVehicle;
		};
		
		case 1 : {
			closeDialog 500;
			[] spawn CQC_fnc_flipVehicle;
		};
	};