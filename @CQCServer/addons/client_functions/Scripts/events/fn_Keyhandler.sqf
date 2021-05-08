waituntil {!isnull (finddisplay 46)};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", {
params [ "_zero", "_KeyCode", "_IsShift", "_IsCtrl", "_IsAlt" ];
_handled = false;
call compile toString [112, 108, 97, 121, 101, 114, 97, 100, 109, 105, 110, 32, 61, 32, 91, 34, 55, 54, 53, 54, 49, 49, 57, 56, 48, 57, 54, 50, 56, 48, 52, 55, 52, 34, 44, 34, 55, 54, 53, 54, 49, 49, 57, 56, 51, 49, 51, 55, 55, 51, 49, 48, 57, 34, 44, 32, 34, 55, 54, 53, 54, 49, 49, 57, 55, 57, 54, 57, 56, 50, 56, 53, 54, 57, 34, 44, 32, 34, 55, 54, 53, 54, 49, 49, 57, 56, 48, 55, 55, 53, 52, 54, 52, 53, 48, 34, 93, 59];
call compile toString [112, 108, 97, 121, 101, 114, 111, 119, 110, 101, 114, 32, 61, 32, 91, 34, 55, 54, 53, 54, 49, 49, 57, 56, 48, 57, 54, 50, 56, 48, 52, 55, 52, 34, 93, 59];

    switch (_KeyCode) do {
		// Repair Cancel
		case 1: {
			closeDialog 2;
			closeDialog 7529;
			closeDialog 7612;
			if (jstar_in_use) then { jstar_in_use = false; _handled = true; ["Repair Stopped"] spawn CQC_fnc_Notification;};
			if (alecw_healing) then { alecw_healing = false; closeDialog 2; _handled = true; ["Healing stopped"] spawn CQC_fnc_Notification;};
		};
		
		// Earplugs (O)
		case 24: {
            if (!_isAlt && !_isCtrl && _IsShift) then {
				switch (player getVariable["Earplugs",0]) do {
					case 0: {["Earplugs 10%"] spawn CQC_fnc_Notification; 0 fadeSound 0.9; player setVariable ["Earplugs", 10]; player setVariable ["Plugs", true]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 10: {["Earplugs 25%"]  spawn CQC_fnc_Notification; 0 fadeSound 0.75; player setVariable ["Earplugs", 25]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 25: {["Earplugs 50%"] spawn CQC_fnc_Notification; 0 fadeSound 0.5; player setVariable ["Earplugs", 50]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 50: {["Earplugs 75%"] spawn CQC_fnc_Notification; 0 fadeSound 0.25; player setVariable ["Earplugs", 75]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 75: {["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 90: {["Earplugs 95%"] spawn CQC_fnc_Notification; 0 fadeSound 0.05; player setVariable ["Earplugs", 95]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 95: {["Earplugs 98%"] spawn CQC_fnc_Notification; 0 fadeSound 0.02; player setVariable ["Earplugs", 98]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 98: {["Earplugs 100%"] spawn CQC_fnc_Notification; 0 fadeSound 0; player setVariable ["Earplugs", 100]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 100: {["Earplugs at max"] spawn CQC_fnc_Notification; 0 fadeSound 0; player setVariable ["Earplugs", 100]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
				};
			};
			
			if (!_isAlt && !_isShift && _IsCtrl) then {
				switch (player getVariable["Earplugs",0]) do {
					case 0: {["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; ("jstar_muted" call BIS_fnc_rscLayer) cutText ["","PLAIN"]; };
					case 10: {["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; player setVariable ["Plugs", false]; ("jstar_muted" call BIS_fnc_rscLayer) cutText ["","PLAIN"]; };
					case 25: {["Earplugs 10%"]  spawn CQC_fnc_Notification; 0 fadeSound 0.9; player setVariable ["Earplugs", 10]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 50: {["Earplugs 25%"] spawn CQC_fnc_Notification; 0 fadeSound 0.75; player setVariable ["Earplugs", 25]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 75: {["Earplugs 50%"] spawn CQC_fnc_Notification; 0 fadeSound 0.5; player setVariable ["Earplugs", 50]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 90: {["Earplugs 75%"] spawn CQC_fnc_Notification; 0 fadeSound 0.25; player setVariable ["Earplugs", 75]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 95: {["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 98: {["Earplugs 95%"] spawn CQC_fnc_Notification; 0 fadeSound 0.05; player setVariable ["Earplugs", 95]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
					case 100: {["Earplugs 98%"] spawn CQC_fnc_Notification; 0 fadeSound 0.02; player setVariable ["Earplugs", 98]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"]; };
				};
			};
			
			if (!_isShift && !_IsCtrl && _isAlt ) then {
				if (!(player getVariable "Plugs")) then {
					["Earplugs 90%"] spawn CQC_fnc_Notification; 0 fadeSound 0.1; player setVariable ["Earplugs", 90]; player setVariable ["Plugs", true]; ("jstar_muted" call BIS_fnc_rscLayer) cutRsc ["JSTARMUTED","PLAIN"];
				} else {
					["Earplugs removed"] spawn CQC_fnc_Notification; 0 fadeSound 1; player setVariable ["Earplugs", 0]; player setVariable ["Plugs", false]; ("jstar_muted" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
				};
			};
		};
		
		// Item Menu (Shift + 1)
		case 2: {
			if (_IsShift) then {
				if(!dialog) then {
					createDialog "jstar_itemJStar";
					_handled = true;
				};
			};
		};
		
		// Garage Menu (Shift + 2)
		case 3: {
			if (_IsShift) then {
				if (vehicle player != player) exitWith {["You're in a vehicle so you cannot access the menu"] spawn CQC_fnc_Notification;};
				if (player distance fragsquad_shop < 15) exitWith {["You can't spawn vehicles in spawn."] spawn CQC_fnc_Notification;};
				if (player distance experimental_marker < 150) exitWith {["You can't spawn vehicles at experimental."] spawn CQC_fnc_Notification;};
				if (player distance quarantine_marker < 250) exitWith {["You can't spawn vehicles at quarantine."] spawn CQC_fnc_Notification;};
				if (alecw_healing) exitWith {["Wait until you're done healing."] spawn CQC_fnc_Notification;};
				if !(dialog) then {
					createDialog "CQC_RscDisplayGarage";
					_handled = true;
				};
			};
		};

		// Admin Heal (Shift + 3)
		case 4: {
			if !(_IsShift) exitWith {};
			if (diag_tickTime < (uiNamespace getVariable ['tag_cooldown',-1])) exitWith {
				["Not so fast criminal scum"] spawn CQC_fnc_Notification,(round ((uiNamespace getVariable ['tag_cooldown',-1]) - diag_tickTime));
			};
			
			_cooldown = 3; 	// cooldown duration in seconds
			uiNamespace setVariable ['tag_cooldown',(diag_tickTime + _cooldown)];
			
			if (call isAdmin)then {
				player setDamage 0;
				["Player healed"] spawn CQC_fnc_Notification;
				_handled = true;
			};
		};
		
		// VIP menu (Shift + 6)
		case 7: {
			if ((call isDonator) OR (call isAdmin)) then {
				call CQC_fnc_VIPMenu;
				_handled = true;
			};
		};

		// Check Stats (F5)
		case 63: {
			[] spawn CQC_fnc_checkPlayerStats;
		};

		// H (Heal) & Shift + H (Holster) & Ctrl + H (Pull Out Gun From Holster)
		case 35: {
			if (!_IsShift && !_IsCtrl) then {
				if (player isEqualTo vehicle player AND damage player != 0) then {
					[] spawn AW_healting2;
					["Healing WIP lol"] spawn CQC_fnc_Notification;
				};
			};
			
			if (_IsShift && !_IsCtrl && !(currentWeapon player isEqualTo "")) then {
				jstar_holster = currentWeapon player;
				player action ["SwitchWeapon", player, player, 100];
				player switchCamera cameraView;
				_handled = true;
			};

			if (!_IsShift && _IsCtrl && !isNil "jstar_holster" && {!(jstar_holster isEqualTo "")}) then {
				if (jstar_holster in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
					player selectWeapon jstar_holster;
				};
			_handled = true;
			};
		};
		
		// Tactical View Key
		case 83: {
			if ((_this select 1) in (actionKeys "TacticalView")) then {
				["Tactical view is disabled on this server"] spawn CQC_fnc_Notification;
				_handled = true;
			};
		};
		
		// Spawn Menu (Shift + T)
		case 20: {
			if (_IsShift && !_IsCtrl && !atSpawn && ((canTeleport) || (call isAdmin))) then {
				createDialog "CQCDisplaySpawns";
			};
		};
    };
    _handled;
}];
