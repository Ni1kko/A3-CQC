/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/


disableSerialization;

params [ 
	["_display",displayNull], 
	["_pressedKey",-100], 
	["_shiftHeld",false], 
	["_ctrlHeld",false],
	["_altHeld",false] 
];

private ["_step","_stopPropagation"];
CQC_var_lastKeyPress = round(serverTime + (getNumber(missionConfigFile >> "AFKKickTime") * 60));
CQC_var_lastKeysPressed = _this select [1,4];

#include "\a3\ui_f\hpp\definedikcodes.inc"

if (_pressedKey in (actionKeys "TacticalView")) exitWith 
{
	["Tactical view is disabled on this server"] spawn CQC_fnc_Notification;
	true
};

_stopPropagation = false;

[] call CQC_fnc_stopProgress;

switch (_pressedKey) do  
{ 
	//-- row 1
	case DIK_ESCAPE: { };
	case DIK_F1:  { _stopPropagation = true; };
	case DIK_F2:  { _stopPropagation = true; };
	case DIK_F3:  { _stopPropagation = true; };
	case DIK_F4:  { _stopPropagation = true; };
	case DIK_F5:  { _stopPropagation = true; };
	case DIK_F6:  { _stopPropagation = true; };
	case DIK_F7:  { _stopPropagation = true; }; 
	case DIK_F8:  { _stopPropagation = true; }; 
	case DIK_F9:  { _stopPropagation = true; }; 
	case DIK_F10: { _stopPropagation = true; }; 
	case DIK_F11: { _stopPropagation = true; }; 
	case DIK_F12: { };  
	
	//-- row 2
	case DIK_GRAVE: 
	{
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
		_stopPropagation = true;
	};
	case DIK_1: {
		if(count(weapons player) >= 1)then{
			player selectWeapon (weapons player)#0
		};
	};
	case DIK_2: 
	{ 
		if (_shiftHeld) then {
			if (vehicle player != player) exitWith {["You're in a vehicle so you cannot access the menu"] spawn CQC_fnc_Notification;};
			if (player distance fragsquad_shop < 15) exitWith {["You can't spawn vehicles in spawn."] spawn CQC_fnc_Notification;};
			if (player distance experimental_marker < 150) exitWith {["You can't spawn vehicles at experimental."] spawn CQC_fnc_Notification;};
			if (player distance quarantine_marker < 250) exitWith {["You can't spawn vehicles at quarantine."] spawn CQC_fnc_Notification;};
			if (CQC_var_isHealing) exitWith {["Wait until you're done healing."] spawn CQC_fnc_Notification;};
			if !(dialog) then {
				createDialog "CQC_Rsc_DisplayGarage"; 
			};
		}else{
			if(count(weapons player) >= 2)then{
				player selectWeapon (weapons player)#1;
			};
		};
		_stopPropagation = true;
	};
	case DIK_3: {
		if(count(weapons player) >= 3)then{
			player selectWeapon (weapons player)#2;
		};
	};
	case DIK_4: { 
		if(count(weapons player) >= 4)then{
			player selectWeapon (weapons player)#3;
		};
		_stopPropagation = true; 
	};
	case DIK_5: 
	{
		if (_shiftHeld) then {
			[] spawn CQC_fnc_checkPlayerStats;
			_stopPropagation = true;
		}else{
			if(count(weapons player) >= 5)then{
				player selectWeapon (weapons player)#5;
			};
		};
	};
	case DIK_6: 
	{
		if (_shiftHeld AND (call isDonator)) then {
			call CQC_fnc_VIPMenu; 
		}else{
			if(count(weapons player) >= 6)then{
				player selectWeapon (weapons player)#6;
			};
		};
		_stopPropagation = true;
	};
	case DIK_7: { _stopPropagation = true; };
	case DIK_8: { _stopPropagation = true; };   
	case DIK_9: { _stopPropagation = true; };
	case DIK_0: { _stopPropagation = true; }; 
	case DIK_BACK: { }; 
	case DIK_HOME: { _stopPropagation = true; };

	//-- row 3 
	case DIK_Q: { };
	case DIK_W: { };
	case DIK_E: { };
	case DIK_R: { };
	case DIK_T: 
	{
		if (_shiftHeld && !_ctrlHeld && CQC_var_canTeleport)  then {
			createDialog "CQC_Rsc_DisplaySpawns";
			_stopPropagation = true;
		};
	};
	case DIK_Y: { _stopPropagation = true; };//block zeus (y)
	case DIK_U: { _stopPropagation = true; };
	case DIK_I: { };
	case DIK_O: 
	{
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

		if(_altHeld || _ctrlHeld || _altHeld) then{
			_stopPropagation = true;
		};
	};
	case DIK_P: { _stopPropagation = true; };
	case DIK_END: { _stopPropagation = true; };
	
	//-- row 4 
	case DIK_A: { };
	case DIK_S: { };
	case DIK_D: { };
	case DIK_F: { }; 
	case DIK_G: { };
	case DIK_H: 
	{
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
		};

		if (!_shiftHeld && _ctrlHeld && !isNil "jstar_holster" && {!(jstar_holster isEqualTo "")}) then {
			if (jstar_holster in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
				player selectWeapon jstar_holster; 
			}; 
		};

		_stopPropagation = true;
	};
	case DIK_J: { _stopPropagation = true; };
	case DIK_K: { _stopPropagation = true; };
	case DIK_L: { _stopPropagation = true; };

	//-- row 5 
	case DIK_Z: { };
	case DIK_X: { };
	case DIK_C: { };
	case DIK_V: { };
	case DIK_B: { _stopPropagation = true; };
	case DIK_N: { };
	case DIK_M: { };

	//-- row 6 
	case DIK_LWIN:  { };
	case DIK_SPACE: 
	{
		if (_shiftHeld) then{
			[] call CQC_fnc_jump;
			_stopPropagation = true;
		}; 
	};
	case DIK_PRIOR: { _stopPropagation = true; };
	case DIK_NEXT:  { _stopPropagation = true; };
};

_stopPropagation;