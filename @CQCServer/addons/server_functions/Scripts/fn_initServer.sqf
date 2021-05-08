/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
    ["_clientData",[[],false],[[]]],
    ["_serverCommandPass","",[""]],
	["_isLiveServer",true,[false]]
];


// Start DB
[] spawn CQC_fnc_startDatabase;
waitUntil {call(missionNamespace getVariable ["CQC_var_DBonline", {false}])};

//Add Connection Event Handlers
CQC_var_ClientConnected = call compile ("addMissionEventHandler ['PlayerConnected', {[_this#1,_this#2,_this#3,_this#4,"+str(_clientData)+","+str(_isLiveServer)+"] spawn CQC_fnc_onplayerconnected}]");
CQC_var_ClientDisconnected = call compile ("addMissionEventHandler ['PlayerDisconnected', {[_this#1,_this#2,_this#3,_this#4] spawn CQC_fnc_onplayerdisconnected}]");

if ((is3DEN || is3DENMultiplayer) AND !isMultiplayer) then {
    ["3DEN",profileName,true,2,_clientData,_isLiveServer] spawn CQC_fnc_onplayerconnected;
};

[
    1, // seconds to delete dead bodies (0 means don't delete) 
    15, // seconds to delete dead vehicles (0 means don't delete)
    60, // seconds to delete immobile vehicles (0 means don't delete)
    1, // seconds to delete dropped weapons (0 means don't delete)
    0, // seconds to deleted planted explosives (0 means don't delete)
    1 // seconds to delete dropped smokes/chemlights (0 means don't delete)
] execVM 'scripts\jstar_scripts\jstar_repetitive_cleanup.sqf';

publicVariable "CQC_fnc_compatibleItems";

diag_log "Server started";

//Server Ready => UNLOCK
_serverCommandPass serverCommand "#unlock";