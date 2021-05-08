/*
#	File:   fn_saveGear.sqf
#	Author: Martinezzz
#	Server: Frag Squad CQC
#	Github: https://github.com/MartinezDeveloper
*/

// Gets the players loadout and automatically puts it in to an array
CQC_var_clientGear = getUnitLoadout player;

// Updates it to the database
["SaveGear", getPlayerUID player, CQC_var_clientGear] remoteExecCall ["CQC_fnc_UpdateDatabase", 2];