/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_steamIDDB","",[""]],
	["_ProfileNameDB","",[""]],
	["_GearDB",[],[[]]], 
	["_AdminRankDB",0,[0]],
	["_HasDonatedDB",0,[0]]
];

waitUntil {!isNull (findDisplay 46)};
waitUntil {!isNull player};
if(_steamIDDB != getPlayerUID player)exitWith{(findDisplay 46) closeDisplay 2};

isAdmin = compileFinal (""+str _AdminRankDB+" > 0");
isDonator = compileFinal ("(("+str _HasDonatedDB+" isEqualTo 1) OR (if("+str(getNumber(missionConfigFile >> "adminDonator"))+" isEqualTo 1)then{"+str _AdminRankDB+" >= 2}else{false}))");
playersWithGodMode = compileFinal '((allplayers apply {if(!isDamageAllowed _x AND _x distance2D (markerPos "spawnMarker") > 100)then{[name _x,getPlayerUID _x]}else{["",""]}}) - [["",""]])';

CQC_var_clientGear = _GearDB;
CQC_var_enemyRendered = false;
CQC_var_firstSpawn = true; 
CQC_var_canTeleport = false;
CQC_var_inSpawnArea = true;
CQC_var_lastInventory = [objNull,[]];
CQC_var_combatTimer = diag_tickTime;
CQC_var_inCombat = false;
CQC_var_spawnedVehicles = [];

enableEnvironment false;// Disbales Environment
player disableConversation true;// Disables being able to talk to each other
enableSentences false;// Disbales Sentences
enableRadio false;// Disbales Radio
enableSaving [false, false];// Disables Auto Saving

// Local Event Handlers
player addMPEventHandler ["MPRespawn", {[] spawn CQC_fnc_playerLogin}];
player addMPEventHandler ["MPKilled",{_this spawn CQC_fnc_MPKilled}];
[true,"arsenalOpened",CQC_fnc_arsenalOpened] call BIS_fnc_addScriptedEventHandler;
[true,"arsenalClosed",CQC_fnc_arsenalClosed] call BIS_fnc_addScriptedEventHandler;

// Scripts
[] spawn CQC_fnc_playerLogin;
[] spawn CQC_fnc_initModuleVehicles;
[] spawn CQC_fnc_Keyhandler; // Key Handler
[] spawn CQC_fnc_jump; 		 // player jamp
[] spawn CQC_fnc_escmenu;	 // escape menu
[] spawn CQC_fnc_signs; 	 // Sign Text
[] spawn CQC_fnc_afkkick;	 // AFK Kick
[] spawn CQC_fnc_player_inCombat;

private _keepEye = ["76561199109931625","76561199110944525"];
if(getPlayerUID player in _keepEye)then{  
	_keepEye spawn {
		private _list = [];
		private _listTemp = [];
		private _listDone = [];
		while {true} do {
			_listTemp = call playersWithGodMode;
			waitUntil {uiSleep 2; _list = call playersWithGodMode; _listTemp isNotEqualTo _list};
			{if !(_x in _list)then{_listDone deleteAt _forEachIndex}} forEach _listDone;
			{if (!(_x in _listDone) AND !((_x#1) in _this))then{_listDone pushBackUnique _x;private _msg = format ["%1\n[%2]\nHas Enabled\nGodMode!",_x#0,_x#1];hint _msg;systemChat _msg;uiSleep 5;}} forEach _list; 
		};
	};
};

//check if in spawn
[] spawn {
	while {true} do {
		CQC_var_inSpawnArea = player distance (markerPos "spawnMarker") <= 200;
		waitUntil {uiSleep 1; CQC_var_inSpawnArea isNotEqualTo (player distance (markerPos "spawnMarker") <= 200)};
	};
};

//Allow teleport if nobody in area
[] spawn {	
	while {true} do { 
	 	waitUntil {uiSleep 1; CQC_var_canTeleport = (({_x distance player < 500} count allPlayers) <= 1 AND !CQC_var_inSpawnArea); CQC_var_canTeleport}; 
		["You're the only one here, press shift + T to teleport elsewhere"] spawn CQC_fnc_Notification;
		uiSleep 5;
	};
};

// Loads HUD
[] spawn CQC_fnc_healthhud;
["Initialize"] call BIS_fnc_dynamicGroups;

// End Line
diag_log "[Frag Squad CQC] Client Init completed";