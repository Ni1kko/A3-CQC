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

CQC_var_AdminRank = compileFinal str _AdminRankDB; 
isDonator = compileFinal (""+str _HasDonatedDB+" isEqualTo 1");
isAdmin = compileFinal "((call CQC_var_AdminRank) > 0)";

caseAFK = 0;
actPos = "0";
actPos2 = "0";
actCount = 0;
StringActPos = "0";
StringActPos2 = "0";
CQC_var_clientGear = _GearDB;
CQC_var_enemyRendered = false;
CQC_var_firstSpawn = true;
jstar_names = false;
canTeleport = false;
 
enableEnvironment false;// Disbales Environment
player disableConversation true;// Disables being able to talk to each other
enableSentences false;// Disbales Sentences
enableRadio false;// Disbales Radio
enableSaving [false, false];// Disables Auto Saving
0 setFog 0;// Removes all Fog
setTerrainGrid 50;// Lowers the terrain down automati
player setCustomAimCoef 0.0;// Lowers Sway;
player enableFatigue false;// Disbales Fatigue

diag_log "[Frag Squad CQC] Loading a shit ton of gay shit";

// Local Event Handlers
player addMPEventHandler ["MPRespawn", {[] spawn CQC_fnc_playerLogin}];
player addMPEventHandler ["MPKilled",{_this spawn CQC_fnc_MPKilled}];
[missionNamespace,"arsenalClosed",{_this call CQC_fnc_arsenalClosed}] call BIS_fnc_addScriptedEventHandler;

[] spawn CQC_fnc_Keyhandler; // Key Handler
[] spawn CQC_fnc_jump; 		 // player jamp
[] spawn CQC_fnc_escmenu;	 // escape menu
[] spawn CQC_fnc_signs; 	 // Sign Text
[] spawn CQC_fnc_afkkick;	 // AFK Kick
[] spawn CQC_fnc_playerLogin;

// Scripts
[] spawn {
	while {true} do {
		cntPly = {
			_x distance player < 500;
		} count allPlayers;
		uiSleep 1;
	};
};

[] spawn {	
	while {true} do {
		uiSleep 1;
	
		if (player distance (markerPos "spawnMarker") > 200) then {
			atSpawn = false;
		} else {
			atSpawn = true;
		};
		
		if ( cntPly isEqualTo 1 && !atSpawn ) then {
			uiSleep 4;
			["You're the only one here, press shift + T to teleport elsewhere"] spawn CQC_fnc_Notification;
			canTeleport = true;
		} else {
			canTeleport = false;
		};
	};	
};
 
["Initialize"] call BIS_fnc_dynamicGroups;

MISSION_ROOT = call {
    private _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};

// Loads HUD
[] call CQC_fnc_healthhud;
[] spawn JSTAR_HUD;
 
["postInit"] spawn CQC_fnc_initModuleVehicles;
diag_log "[Frag Squad CQC] Scripts Loaded";

// End Line
diag_log "[Frag Squad CQC] Client Init completed";