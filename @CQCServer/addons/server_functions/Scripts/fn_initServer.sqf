/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
    ["_clientData",[[],false],[[]]],
    ["_serverCommandPass","",[""]],
	["_isLiveServer",true,[false]]
];

private _passwordAdmin = 'v1rd86Rtv9b';

private _logNew = compile 'diag_log "";{diag_log format ["<CQC> %1",_x];if(_forEachIndex mod 2 isEqualTo 0)then{diag_log ""}}forEach _this;diag_log ""; true';

// Start DB
if !([_serverCommandPass] call CQC_fnc_startDatabase)exitwith{
    if(["Database: Error occured","Server: Shutting Down"] call _logNew)then{
        _serverCommandPass serverCommand "#shutdown";
    };
};

_serverCommandPass serverCommand "#debug Database: Connected";

//Add Connection Event Handlers
CQC_var_ClientConnected = addMissionEventHandler ["PlayerConnected", CQC_fnc_onplayerconnected, [_clientData, _isLiveServer]];
CQC_var_ClientDisconnected = addMissionEventHandler ["PlayerDisconnected", CQC_fnc_onplayerdisconnected, []];

if (is3DEN || is3DENMultiplayer || !isDedicated || !isServer || hasInterface) exitwith {
    if(["Server Not A Server","Aborting scope","Server addon must be on server and not a client"] call _logNew)then{
        _serverCommandPass serverCommand "#shutdown";
    };
};

if (!isKeyActive "CQC_CustomProfile") exitwith {
    if(["Server Profile Error","Aborting scope","Server Profile ActiveKey Not Found"] call _logNew)then{
        _serverCommandPass serverCommand "#shutdown";
    };
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
    _msgs = [];
    _msgs resize 5;
    (_msgs apply {"Warning: ANTIHACK DISABLED"}) call _logNew;
    _serverCommandPass serverCommand "#unlock"; 
};

CQC_var_EntityKilledEH = addMissionEventHandler ["EntityKilled",
{
	params ["_victim", "_killer", "_instigator"];
    private _killedByVehicle = false;
	if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
	if (isNull _instigator) then {_killedByVehicle = true;_instigator = _killer}; // player driven vehicle road kill
    
     
    if(!isNull _victim AND !isNull _killer AND !isNull _instigator)then{ 
        private _message = format ["%1 (KILLED) %2", name _instigator, name _victim];
        private _admins = missionNamespace getVariable ['CQCAdmins',[]];
	    private _donators = missionNamespace getVariable ['CQCDonators',[]];
        if(getPlayerUID _instigator in (_admins + _donators))then{
            private _quotes = ["slaughtered","wrecked","fragged","dominated","killed","defeated","destroyed"];
            private _quote = [selectRandom _quotes, "squashed"] select _killedByVehicle;
            _message = format ["%1 (%2) %3", name _instigator, toUpper _quote, name _victim];
        };
        _message remoteExec ["systemChat",-2];
    };
}];
//removeMissionEventHandler ["EntityKilled",CQC_var_EntityKilledEH]

civilian setFriend [sideEnemy, 1];

CQC_ESPAdminFSM = [(3 * 60),CQC_fnc_broadcast_AdminList,"broadcast_AdminList",2,true,false] call CQC_fnc_scheduler;
CQC_ESPDonatorFSM = [(3 * 60),CQC_fnc_broadcast_DonatorList,"broadcast_DonatorList",2,true,false] call CQC_fnc_scheduler;

diag_log "Server started";