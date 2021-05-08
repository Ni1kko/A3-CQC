/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_steamIDDB","",[""]],
	["_ProfileNameDB","",[""]],
	["_GearDB",[],[[]]], 
	["_AdminRankDB",0,[0]],
	["_DonatorRankDB",0,[0]]
];

if(_steamIDDB != getPlayerUID player)exitWith{};

["preInit"] spawn CQC_fnc_initModuleVehicles;

CQC_var_AdminRank = compileFinal str _AdminRankDB;
CQC_var_DonatorRank = compileFinal str _DonatorRankDB;
isDonator = compileFinal "((call CQC_var_DonatorRank) > 0)";
isAdmin = compileFinal "((call CQC_var_AdminRank) > 0)";

CQC_var_clientGear = _GearDB;

disableSerialization;

// Disbales Environment
enableEnvironment false;

// Disables being able to talk to each other
player disableConversation true;

// Disbales Sentences
enableSentences false;

// Disbales Radio
enableRadio false;

// Disables Auto Saving
enableSaving [false, false];

// Removes all Fog
0 setFog 0;

// Lowers the terrain down automati
setTerrainGrid 50;

// Lowers Sway
player setCustomAimCoef 0.0;
diag_log "[Frag Squad CQC] Loading a shit ton of gay shit";

// Disbales Fatigue
player enableFatigue false;
 
// Local Event Handlers
player addMPEventHandler ["MPRespawn", {player enableFatigue false; player setCustomAimCoef 0.00;}];
player addMPEventHandler ["MPKilled",{_this spawn CQC_fnc_MPKilled}];
player addEventHandler ["Respawn",{waitUntil {!isNull player}; [] spawn CQC_fnc_eventHandlers; createDialog "CQCDisplaySpawns"; }];
[missionNamespace,"arsenalClosed",{_this call CQC_fnc_arsenalClosed}] call BIS_fnc_addScriptedEventHandler;

// Loads all the statis
// Loads Kills
if (isNil {profileNamespace getVariable "cqc_kills"}) then {profileNamespace setVariable ["cqc_kills", 0];};

// Loads Deaths
if (isNil {profileNamespace getVariable "cqc_death"}) then {profileNamespace setVariable ["cqc_death", 0];};

// Loads Kill to death Ratio
if (isNil {profileNamespace getVariable "cqc_kda"}) then {profileNamespace setVariable ["cqc_kda", 0];};

// Updates the variables
player setUnitTrait ["Medic",true];
player setVariable ["cqc_kills", profileNamespace getVariable "cqc_kills"];
player setVariable ["cqc_death", profileNamespace getVariable "cqc_death"];
player setVariable ["cqc_kda", profileNamespace getVariable "cqc_kda"];
player setVariable ["Earplugs",0];
player setVariable ["Plugs",false];

// Prints data into client side RPT
diag_log format ["[Frag Squad CQC] Player Stats Loaded. { Kills: %1 }, { Deaths: %2 }, { KDA: %3 }", profilenamespace getVariable "cqc_kills", profileNamespace getVariable "cqc_death", profileNamespace getVariable "cqc_kda"];

// Removes Dumb ass Chats
0 enableChannel [false, false];
1 enableChannel [true, false];
2 enableChannel [false, false];
3 enableChannel [false, false];
4 enableChannel [true, true];
5 enableChannel [true, true];
diag_log "[Frag Squad CQC] Chats Removed";

caseAFK = 0;
actPos = "0";
actPos2 = "0";
actCount = 0;
StringActPos = "0";
StringActPos2 = "0";

["Initialize"] call BIS_fnc_dynamicGroups;

MISSION_ROOT = call {
    private _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};

// First Menu
waitUntil { if !( isNull ( findDisplay 46 ) ) then { true } else { uiSleep 0.5; false } };
createDialog "CQCDisplayHelp";

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

[] spawn CQC_fnc_Keyhandler; // Key Handler
[] spawn CQC_fnc_jump; 		 // player jamp
[] spawn CQC_fnc_escmenu;	 // escape menu
[] spawn CQC_fnc_signs; 	 // Sign Text
[] spawn CQC_fnc_afkkick;	 // AFK Kick

["postInit"] spawn CQC_fnc_initModuleVehicles;
diag_log "[Frag Squad CQC] Scripts Loaded";

// Player Icons
["CQC_fnc_playerIcons", "OnEachFrame", "CQC_fnc_playerIcons"] call BIS_fnc_addStackedEventHandler;

// Global
jstar_names = false;
canTeleport = false;

// Loads HUD
[] call CQC_fnc_healthhud;
[] spawn JSTAR_HUD;

// Sets View Distances
setViewDistance 325;
setObjectViewDistance 325;

/* 
	!!!! TO BE REMOVED !!!

	VIPs = [
		'76561198393606454', // Yab (Friend)
		'76561198276144474', // Liamm
		'76561198092176053', // TyRant
		'76561198105744855', // Reidy
		'76561198130546772', // Kevin
		'76561198081711098', // Alistair
		'76561198264633517', // Ethan
		'76561198030088997', // Rogue
		'76561198261714445', // Kral
		'76561198138454776', // Silo
		'76561198213550053', // Mikey!
		'76561198169146689', // Joike
		'76561198285522367', // Nathan
		'76561198272394878', // Vince
		'76561198011953438', // Reece
		'76561198075617538', // Clark
		'76561198121847178', // Butch
		'76561198271611896', // hawky
		'76561198097255922', // Eemil
		'76561198195264231', // Sicario
		'76561198976538765',  // monkeycow
		'76561198114101981', // Damon
		'76561199066320068', // Shado 
		'76561198172489513', // Harry.
		'76561198387894795', // .Max
		'76561198102381199', // Ghost2k
		'76561199034504598', //dabest
		'76561199089637134', //house
		'76561198270967902', //spencer
		'76561198203772432', //McPooperson
		'76561198942538304'  // Actually Shock

	]; 

	!!!! TO BE REMOVED !!!

	Admins = [
		// Staff Team
		'76561198048125586', // Alec
		'76561198119520123', // Callum HD
		'76561198334203836', // Tom Cliffoff
		'76561198095796413', // Shipman
		'76561197967469192', // Scottish
		'76561198101131022', // Helmut
		'76561199034504598', //dabest
		'76561199089637134', //house

		// Development Team
		'76561198250806228', // Martinez
		'76561198339636384', // Jigggg
		'76561199110944525', // Xlax
		'76561198283428669'  // Ryn
	]; 

	!!!! TO BE REMOVED !!!
*/

// Custom Loadout Bullshit
private _customLoadout = profileNamespace getVariable [ "CQC_Custom_Loadout", [] ];
if (count (_customLoadout) > 0) then {
	player setUnitLoadout _customLoadout;
}else{
	// Checks if they have a loadout saved if they do not it doesnt do jack shit if they do it will grab it from the var that we set.
	if (count (CQC_var_clientGear) > 0) then {
		player setUnitLoadout CQC_var_clientGear;
	}else{
		//fail safe (no custom, no db saved)
		player setUnitLoadout [[],[],[],["U_C_Poloshirt_tricolour",[]],["V_PlateCarrier2_blk",[]],[],"H_Hat_brown","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
	};
};
 
if(call isDonator)then{
	[] spawn CQC_fnc_donatorInit;
};

// End Line
diag_log "[Frag Squad CQC] Client Init completed";