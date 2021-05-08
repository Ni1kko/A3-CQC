disableSerialization;

_selection = _this select 0;
_index = _selection select 1;

switch (_index) do {

	case 0 : {
		closeDialog 500;
		if(vehicle player != player) exitWith {["You're in a vehicle so you cannot access the menu"] spawn CQC_fnc_Notification;};
		if(player distance fragsquad_shop < 15) exitWith {["You can't spawn vehicles in spawn."] spawn CQC_fnc_Notification;};
		if(player distance experimental_marker < 150) exitWith {["You can't spawn vehicles at experimental."] spawn CQC_fnc_Notification;};
		if(player distance quarantine_marker < 250) exitWith {["You can't spawn vehicles at quarantine."] spawn CQC_fnc_Notification;};
		if(alecw_healing) exitWith {["Wait until you're done healing."] spawn CQC_fnc_Notification;};
		createDialog "CQC_RscDisplayGarage";
	};
	
	case 1 : {
		closeDialog 500;
		createDialog "jstar_items";
	};
};