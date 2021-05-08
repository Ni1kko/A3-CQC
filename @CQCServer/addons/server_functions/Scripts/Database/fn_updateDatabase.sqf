/*
#	Params Currently Used:
#	SaveGear = Gets the players loadout and saves it to the database.
#
#
#
#
#
#
*/

params [
	[ "_type", "", [ "" ] ],
	[ "_uid", "", [ "" ] ]
];

switch ( _type ) do {
	// Gets the players loadout and updates it to the database
	case "SaveGear": {
		// SaveGear, SteamID, Loadout
		_loadout = [_this, 2, [], [[]]] call BIS_fnc_param;
		["UPDATE", "Clients SET Gear='"+ ( [_loadout] call CQC_fnc_database_mresArray ) +"' WHERE SteamID='"+ _uid +"'"] call CQC_fnc_queryDatabase; 
	};

	default { 

	};
};