/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
    ["_clientData",[[],false],[[]]],
    ["_serverCommandPass","",[""]]
];

private _passwordAdmin = 'v1rd86Rtv9b';

private _logNew = compile 'diag_log "";{diag_log format ["<CQC> %1",_x];if(_forEachIndex mod 2 isEqualTo 0)then{diag_log ""}}forEach _this;diag_log ""; true';

//Version Check
private _patches = (configFile >> "CfgPatches");
private _missionVersion = getNumber(missionConfigFile >> "fileVersion");
private _badVersion = false;
{
    private _addonVersion = getNumber(_patches >> _x >> "fileVersion");
    if(_missionVersion isNotEqualTo _addonVersion)exitWith{
        _badVersion = true;
    };
} forEach ["server_functions","client_functions"];

if (_badVersion) exitwith {
    if(["Server File Error","Aborting scope","Server File Version Mismatch","Please make sure you packed `server_functions` AND `client_functions` AND 'Mission.Altis' into a pbo"] call _logNew)then{
        _serverCommandPass serverCommand "#shutdown";
    };
};

CQC_var_currentVersion = compileFinal str _missionVersion;

// Start DB
if !([_serverCommandPass] call CQC_fnc_startDatabase)exitwith{
    if(["Database: Error occured","Server: Shutting Down"] call _logNew)then{
        _serverCommandPass serverCommand "#shutdown";
    };
};

_serverCommandPass serverCommand "#debug Database: Connected";

//Add Connection Event Handlers
CQC_var_ClientConnected = addMissionEventHandler ["PlayerConnected", CQC_fnc_onplayerconnected, _clientData];
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

[] spawn CQC_fnc_repetitive_cleanup;

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
    if (!isNull _victim AND !isNull _killer AND !isNull _instigator) then {
        private _message = format ["%1 (KILLED) %2", name _instigator, name _victim];
        if (_victim isEqualTo _instigator) then {
            _message = format ["%1 (DIED)", name _victim];
        }else{
            private _admins = missionNamespace getVariable ['CQCAdmins',[]];
            private _donators = missionNamespace getVariable ['CQCDonators',[]];
            if(getPlayerUID _instigator in (_admins + _donators))then{
                if(_killedByVehicle)then{
                   private _quotes = ["squashed" ,"crushed"]; 
                    _message = format ["%1 (%2) %3", name _instigator, toUpper(selectRandom _quotes), name _victim];
                }else{
                    private _quotes = ["slaughtered","fragged","dominated","defeated","destroyed","wrecked","rekt","stomped","wasted","screwed","toasted","terminated","killed","annihilated","hammered","neutralized","pulverized","smashed","shredded"];
                    private _quoteMessage = format ["%1 (%2) %3", name _instigator, toUpper(selectRandom _quotes), name _victim];

                    private _distance = _victim distance2D _instigator; 
                    private _distanceMessage = format ["From (%1%2)",round ([_distance,_distance / 1000] select (_distance >= 1000)),["m","km"] select (_distance >= 1000)];
                    
                    private _weapon = getText(configFile >> "CfgWeapons" >> currentWeapon _instigator >> "displayName");
                    private _weaponMessage = if(_weapon isNotEqualTo "")then{format ["With (%1)",_weapon]}else{""};

                    _message = format ["%1 %2 %3",_quoteMessage, _distanceMessage,_weaponMessage];
                };
            };
        };
        _message remoteExec ["systemChat",-2];
    };
}];
//removeMissionEventHandler ["EntityKilled",CQC_var_EntityKilledEH]

civilian setFriend [sideEnemy, 1];
[0,0] remoteExec ["setFog",0];// Removes all Fog

["Initialize"] call BIS_fnc_dynamicGroups; 

[] spawn CQC_fnc_broadcast_AdminList;
[] spawn CQC_fnc_broadcast_DonatorList;
CQC_ESPAdminFSM = [(3 * 60),CQC_fnc_broadcast_AdminList,"broadcast_AdminList",2,true,false] call CQC_fnc_scheduler;
CQC_ESPDonatorFSM = [(3 * 60),CQC_fnc_broadcast_DonatorList,"broadcast_DonatorList",2,true,false] call CQC_fnc_scheduler;

diag_log "Server started";