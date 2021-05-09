/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
    ["_clientData",[[],false],[[]]],
    ["_serverCommandPass","",[""]],
	["_isLiveServer",true,[false]]
];

private _passwordAdmin = '34567';

// Start DB
if !([_serverCommandPass] call CQC_fnc_startDatabase)exitwith{
    _serverCommandPass spawn{
        while {true} do {
            [[],{
                (findDisplay 49) closeDisplay 2;
                uiSleep 0.5;
                (findDisplay 46) closeDisplay 2;
                failMission "end1";
                endMission "end1";
            }]remoteExecCall ["spawn",-2];
            uiSleep 60;
            _this serverCommand "#debug Database: Not loaded";
            uiSleep 30;
            _this serverCommand "#shutdown";
        };
    };
};

_serverCommandPass serverCommand "#debug Database: Connected";

//Add Connection Event Handlers
CQC_var_ClientConnected = call compile ("addMissionEventHandler ['PlayerConnected', {[_this#1,_this#2,_this#3,_this#4,"+str(_clientData)+","+str(_isLiveServer)+"] spawn CQC_fnc_onplayerconnected}]");
CQC_var_ClientDisconnected = call compile ("addMissionEventHandler ['PlayerDisconnected', {[_this#1,_this#2,_this#3,_this#4] spawn CQC_fnc_onplayerdisconnected}]");

if ((is3DEN || is3DENMultiplayer) AND !isMultiplayer) then {
    ["3DEN",profileName,true,2,_clientData,_isLiveServer] spawn CQC_fnc_onplayerconnected;
};

publicVariable "CQC_fnc_compatibleItems";

[
    1, // seconds to delete dead bodies (0 means don't delete) 
    15, // seconds to delete dead vehicles (0 means don't delete)
    60, // seconds to delete immobile vehicles (0 means don't delete)
    1, // seconds to delete dropped weapons (0 means don't delete)
    0, // seconds to deleted planted explosives (0 means don't delete)
    1 // seconds to delete dropped smokes/chemlights (0 means don't delete)
] spawn CQC_fnc_repetitive_cleanup;

private _useAntiHack = getNumber(configFile >> "CfgPatches" >> "server_functions" >> "antiHack") isEqualTo 1;
if(_useAntiHack)then{
    if([_serverCommandPass,_passwordAdmin] call CQC_fnc_startAH)then{
        _serverCommandPass serverCommand "#unlock";
    };
}else{
    for "_i" from 0 to 10 do {diag_log "Warning: ANTIHACK DISABLED"};
    _serverCommandPass serverCommand "#unlock";
};

diag_log "Server started";