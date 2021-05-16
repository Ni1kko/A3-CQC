/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/
 
params [ 
	["_display",displayNull], 
	["_pressedKey",-100], 
	["_shiftHeld",false], 
	["_ctrlHeld",false],
	["_altHeld",false] 
];

private _overrideKey = false;

switch (_pressedKey) do {
	// Repair Cancel
	case 1: {
		closeDialog 2;
		closeDialog 7529;
		closeDialog 7612;
		if (jstar_in_use) then { jstar_in_use = false; _overrideKey = true; ["Repair Stopped"] spawn CQC_fnc_Notification;};
		if (CQC_var_isHealing) then { CQC_var_isHealing = false; closeDialog 2; _overrideKey = true; ["Healing stopped"] spawn CQC_fnc_Notification;};
	};

	//block zeus (y)
	case 21: { 
		_overrideKey = true;
	};
	
	// Earplugs (O)
	case 24: {

		private _resource = "CQC_Rsc_MuteIcon";

		if (!_altHeld && !_ctrlHeld && _shiftHeld) then {
			switch (player getVariable["Earplugs",0]) do {
				case 0: {["Earplugs 10%"] spawn CQC_fnc_Notification; 0 fadeSound 0.9; player setVariable ["Earplugs", 10]; player setVariable ["Plugs", true]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 10: {["Earplugs 25%"]  spawn CQC_fnc_Notification; 0 fadeSound 0.75; player setVariable ["Earplugs", 25]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 25: {["Earplugs 50%"] spawn CQC_fnc_Notification; 0 fadeSound 0.5; player setVariable ["Earplugs", 50]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 50: {["Earplugs 75%"] spawn CQC_fnc_Notification; 0 fadeSound 0.25; player setVariable ["Earplugs", 75]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 75: {["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 90: {["Earplugs 95%"] spawn CQC_fnc_Notification; 0 fadeSound 0.05; player setVariable ["Earplugs", 95]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 95: {["Earplugs 98%"] spawn CQC_fnc_Notification; 0 fadeSound 0.02; player setVariable ["Earplugs", 98]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 98: {["Earplugs 100%"] spawn CQC_fnc_Notification; 0 fadeSound 0; player setVariable ["Earplugs", 100]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 100: {["Earplugs at max"] spawn CQC_fnc_Notification; 0 fadeSound 0; player setVariable ["Earplugs", 100]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
			};
		};
		
		if (!_altHeld && !_shiftHeld && _ctrlHeld) then {
			switch (player getVariable["Earplugs",0]) do {
				case 0: {["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; (_resource call BIS_fnc_rscLayer) cutText ["","PLAIN"]; };
				case 10: {["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; player setVariable ["Plugs", false]; (_resource call BIS_fnc_rscLayer) cutText ["","PLAIN"]; };
				case 25: {["Earplugs 10%"]  spawn CQC_fnc_Notification; 0 fadeSound 0.9; player setVariable ["Earplugs", 10]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 50: {["Earplugs 25%"] spawn CQC_fnc_Notification; 0 fadeSound 0.75; player setVariable ["Earplugs", 25]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 75: {["Earplugs 50%"] spawn CQC_fnc_Notification; 0 fadeSound 0.5; player setVariable ["Earplugs", 50]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 90: {["Earplugs 75%"] spawn CQC_fnc_Notification; 0 fadeSound 0.25; player setVariable ["Earplugs", 75]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 95: {["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 98: {["Earplugs 95%"] spawn CQC_fnc_Notification; 0 fadeSound 0.05; player setVariable ["Earplugs", 95]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
				case 100: {["Earplugs 98%"] spawn CQC_fnc_Notification; 0 fadeSound 0.02; player setVariable ["Earplugs", 98]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"]; };
			};
		};
		
		if (!_shiftHeld && !_ctrlHeld && _altHeld ) then {
			if (!(player getVariable "Plugs")) then {
				["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; player setVariable ["Plugs", true]; (_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"];
			} else {
				["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; player setVariable ["Plugs", false]; (_resource call BIS_fnc_rscLayer) cutText ["","PLAIN"];
			};
		};
	};
	
	// Garage Menu (Shift + 2)
	case 3: {
		if (_shiftHeld) then {
			if (vehicle player != player) exitWith {["You're in a vehicle so you cannot access the menu"] spawn CQC_fnc_Notification;};
			if (player distance fragsquad_shop < 15) exitWith {["You can't spawn vehicles in spawn."] spawn CQC_fnc_Notification;};
			if (player distance experimental_marker < 150) exitWith {["You can't spawn vehicles at experimental."] spawn CQC_fnc_Notification;};
			if (player distance quarantine_marker < 250) exitWith {["You can't spawn vehicles at quarantine."] spawn CQC_fnc_Notification;};
			if (CQC_var_isHealing) exitWith {["Wait until you're done healing."] spawn CQC_fnc_Notification;};
			if !(dialog) then {
				createDialog "CQC_Rsc_DisplayGarage";
				_overrideKey = true;
			};
		};
	};

	// Admin Heal (Shift + 3)
	case 4: {
		if !(_shiftHeld) exitWith {};
		if (diag_tickTime < (uiNamespace getVariable ['tag_cooldown',-1])) exitWith {
			["Not so fast criminal scum"] spawn CQC_fnc_Notification;
		};
		
		_cooldown = 3; 	// cooldown duration in seconds
		uiNamespace setVariable ['tag_cooldown',(diag_tickTime + _cooldown)];
		
		if (call isAdmin)then {
			player setDamage 0;
			["Player healed"] spawn CQC_fnc_Notification;
			_overrideKey = true;
		};
	};
	
	// VIP menu (Shift + 6)
	case 7: {
		if (call isDonator) then {
			call CQC_fnc_VIPMenu;
			_overrideKey = true;
		};
	};

	// Toogle ESP (`)
	case 41: {
		if(profileNamespace getVariable ["CQC_var_tagsShown",false])then{
			["CQC_ESPHook", "OnEachFrame"] call BIS_fnc_removeStackedEventHandler;
			["Player Tags Hidden"] spawn CQC_fnc_Notification;
			profileNamespace setVariable ["CQC_var_tagsShown",false];
		}else{
			["CQC_ESPHook", "OnEachFrame", CQC_fnc_nameTags] call BIS_fnc_addStackedEventHandler;
			["Player Tags Shown"] spawn CQC_fnc_Notification;
			profileNamespace setVariable ["CQC_var_tagsShown",true];
		};
		saveprofileNamespace;
	};

	// Check Stats (F5)
	case 63: {
		[] spawn CQC_fnc_checkPlayerStats;
	};

	// H (Heal) & Shift + H (Holster) & Ctrl + H (Pull Out Gun From Holster)
	case 35: {
		if (!_shiftHeld && !_ctrlHeld) then {
			if (player isEqualTo vehicle player AND damage player != 0) then {
				[] spawn CQC_fnc_healPlayer;
				["Healing WIP lol"] spawn CQC_fnc_Notification;
			};
		};
		
		if (_shiftHeld && !_ctrlHeld && !(currentWeapon player isEqualTo "")) then {
			jstar_holster = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchCamera cameraView;
			_overrideKey = true;
		};

		if (!_shiftHeld && _ctrlHeld && !isNil "jstar_holster" && {!(jstar_holster isEqualTo "")}) then {
			if (jstar_holster in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
				player selectWeapon jstar_holster;
			};
		_overrideKey = true;
		};
	};
	
	// Tactical View Key
	case 83: {
		if ((_this select 1) in (actionKeys "TacticalView")) then {
			["Tactical view is disabled on this server"] spawn CQC_fnc_Notification;
			_overrideKey = true;
		};
	};
	
	// Spawn Menu (Shift + T)
	case 20: {
		if (_shiftHeld && !_ctrlHeld && CQC_var_canTeleport)  then {
			createDialog "CQC_Rsc_DisplaySpawns";
		};
	};
};

CQC_var_lastKeyPress = ((-1 call CQC_fnc_getTimeDate) + getNumber(missionConfigFile >> "AFKKickTime"));
CQC_var_lastKeysPressed = _this select [1,4];

_overrideKey;
