/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

waitUntil {!isNull player};

player enableFatigue false; 
player setCustomAimCoef 0.00;
player switchCamera "EXTERNAL";
player addRating -1000000;
CQC_var_isHealing = false;

// Sets View Distances
setViewDistance 325;
setObjectViewDistance 325;
setTerrainGrid 50;

//Temp Check If Not In DB
if !(call isAdmin) then{  
	if (getplayeruid player in [
		// Staff Team
		'76561198119520123', // Callum HD
		'76561198334203836', // Tom Cliffoff
		'76561198095796413', // Shipman
		'76561197967469192', // Scottish
		'76561198101131022', // Helmut
		'76561199034504598', //dabest
		'76561199089637134', //house

		// Development Team
		'76561198250806228', // Martinez 
		'76561198283428669'  // Ryn
	]) then {
		titleText ["<t color='#ff0000' size='5'>Please visit discord and @Developer requesting you be added to the database!</t>", "PLAIN", -1, true, true];
	};
};

//Temp Check If Not In DB
if!(call isDonator)then{ 
	if (getplayeruid player in [
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
		'76561198075617538', // Clark
		'76561198121847178', // Butch
		'76561198271611896', // hawky
		'76561198097255922', // Eemil
		'76561198195264231', // Sicario
		'76561198976538765',  // monkeycow
		'76561198114101981', // Damon
		'76561199066320068', // Shado 
		'76561198172489513', // Harry.
		'76561198102381199', // Ghost2k
		'76561199034504598', //dabest
		'76561198203772432', //McPooperson
		'76561198942538304'  // Actually Shock
	]) then {
		titleText ["<t color='#ff0000' size='5'>Please visit discord and @Developer requesting you be added to the VIP!</t>", "PLAIN", -1, true, true];
	};
};
	
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

 
[] spawn CQC_fnc_eventHandlers;
[] spawn CQC_fnc_initActions;// scroll actions

// Player Icons nameTags
["CQC_ESPHook", "OnEachFrame", CQC_fnc_nameTags] call BIS_fnc_addStackedEventHandler;
//["CQC_ESPHook", "OnEachFrame"] call BIS_fnc_removeStackedEventHandler;

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

if(CQC_var_firstSpawn)then{
	CQC_var_firstSpawn = false;
	if(call isDonator /*|| call isAdmin*/)then{
		[] spawn CQC_fnc_donatorInit;
	}else{
		createDialog "CQCDisplayHelp";
	};
}else{
	createDialog "CQCDisplaySpawns";
};

if(isNil "CQC_fnc_customHudInit")then{
	[]spawn{
		waitUntil{!isNil "CQC_fnc_customHudInit"};
		[] spawn CQC_fnc_customHudInit;
	};
}else{
	[] spawn CQC_fnc_customHudInit;
};