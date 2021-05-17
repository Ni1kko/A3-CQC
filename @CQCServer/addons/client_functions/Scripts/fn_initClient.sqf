/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [ 
	["_display",displayNull,[displayNull]]
];

waitUntil {!isNull player};

CQC_var_enemyRendered = false;
CQC_var_firstSpawn = true; 
CQC_var_canTeleport = false;
CQC_var_inSpawnArea = true;
CQC_var_lastInventory = [objNull,[]];
CQC_var_combatTimer = diag_tickTime;
CQC_var_inCombat = false;
CQC_var_spawnedVehicles = [];
CQC_var_lastSpawnPos = "";
CQC_var_lastKeyPress = round(serverTime + (getNumber(missionConfigFile >> "AFKKickTime") * 60));
CQC_var_lastKeysPressed = [-1,false,false,false];
CQC_var_autoReloadActive = false;
CQC_var_airportActionID = -1;
CQC_var_isHealing = false;
CQC_var_userBusy = false;

// Sets View Distances
setViewDistance 325;
setObjectViewDistance 325;
setTerrainGrid 50;

// Removes Dumb ass Chats
0 enableChannel [false, false];
1 enableChannel [true, false];
2 enableChannel [false, false];
3 enableChannel [false, false];
4 enableChannel [true, true];
5 enableChannel [true, true];

enableEnvironment false;// Disbales Environment
player disableConversation true;// Disables being able to talk to each other
enableSentences false;// Disbales Sentences
enableRadio false;// Disbales Radio
enableSaving [false, false];// Disables Auto Saving

//priority login first
private _loginHandle = [] spawn CQC_fnc_playerLogin;
waitUntil {scriptDone _loginHandle};

// Player Icons nameTags
["CQC_ESPHook", "OnEachFrame", CQC_fnc_nameTags] call BIS_fnc_addStackedEventHandler;

// Scripts
[] spawn CQC_fnc_initModuleVehicles;
[] spawn CQC_fnc_Keyhandler; 			// Key Handler
[] spawn CQC_fnc_escmenu;	 			// escape menu
[] spawn CQC_fnc_signs; 	 			// Sign Text
[] spawn CQC_fnc_player_inCombat;
[_display] spawn CQC_fnc_Idlekick;	 	// AFK Kick

// Local Event Handlers
_display displayAddEventHandler ["KeyDown", CQC_fnc_Keyhandler];
[true,"arsenalOpened",CQC_fnc_arsenalOpened] call BIS_fnc_addScriptedEventHandler;
[true,"arsenalClosed",CQC_fnc_arsenalClosed] call BIS_fnc_addScriptedEventHandler;

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
		CQC_var_inSpawnArea = player distance (markerPos "respawn") <= 25;
		waitUntil {uiSleep 1; CQC_var_inSpawnArea isNotEqualTo (player distance (markerPos "respawn") <= 25)};
	};
};

//Allow teleport if nobody in area
[] spawn {
	if(call isAdmin)then{
		[] spawn {
			while {true} do{
				CQC_var_canTeleport = true;
				waitUntil {
					if(({_x distance player < 500} count allPlayers) <= 1 AND !CQC_var_inSpawnArea)then{
						["You're the only one here, press shift + T to teleport elsewhere"] spawn CQC_fnc_Notification;
						uiSleep 5;
					}else{
						uiSleep 1;
					};
					!CQC_var_canTeleport
				};
			};
		};
	}else{
		while {true} do { 
			waitUntil {uiSleep 1; CQC_var_canTeleport = (({_x distance player < 500} count allPlayers) <= 1 AND !CQC_var_inSpawnArea); CQC_var_canTeleport}; 
			["You're the only one here, press shift + T to teleport elsewhere"] spawn CQC_fnc_Notification;
			uiSleep 5;
		};
	};
};

// Loads HUD
[] spawn CQC_fnc_healthhud;
["Initialize"] call BIS_fnc_dynamicGroups;

// End Line
diag_log "[Frag Squad CQC] Client Init completed";