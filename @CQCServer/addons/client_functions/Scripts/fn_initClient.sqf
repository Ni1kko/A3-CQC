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
["preInit"] spawn CQC_fnc_initModuleVehicles;

waitUntil {!isNull player};
if(_steamIDDB != getPlayerUID player)exitWith{(findDisplay 46) closeDisplay 2};

isDonator = compileFinal (""+str _HasDonatedDB+" isEqualTo 1");
isAdmin = compileFinal (""+str _AdminRankDB+" > 0");

CQC_var_clientGear = _GearDB;
CQC_var_enemyRendered = false;
CQC_var_firstSpawn = true; 
CQC_var_canTeleport = false;
CQC_var_inSpawnArea = true;

enableEnvironment false;// Disbales Environment
player disableConversation true;// Disables being able to talk to each other
enableSentences false;// Disbales Sentences
enableRadio false;// Disbales Radio
enableSaving [false, false];// Disables Auto Saving

// Local Event Handlers
player addMPEventHandler ["MPRespawn", {[] spawn CQC_fnc_playerLogin}];
player addMPEventHandler ["MPKilled",{_this spawn CQC_fnc_MPKilled}];

// Scripts 
[] spawn CQC_fnc_playerLogin;
[] spawn CQC_fnc_Keyhandler; // Key Handler
[] spawn CQC_fnc_jump; 		 // player jamp
[] spawn CQC_fnc_escmenu;	 // escape menu
[] spawn CQC_fnc_signs; 	 // Sign Text
[] spawn CQC_fnc_afkkick;	 // AFK Kick
[missionNamespace,"arsenalClosed",{_this call CQC_fnc_arsenalClosed}] call BIS_fnc_addScriptedEventHandler;

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
["postInit"] spawn CQC_fnc_initModuleVehicles;

// End Line
diag_log "[Frag Squad CQC] Client Init completed";