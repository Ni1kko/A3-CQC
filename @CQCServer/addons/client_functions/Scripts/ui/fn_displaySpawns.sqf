params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
	case "onLoad":{
		private _display = _params param [0,displayNull];

		private _title = _display displayCtrl 1;
		private _list = _display displayCtrl 2;
		private _button1 = _display displayCtrl 3;
		private _button2 = _display displayCtrl 4;

		_title ctrlSetText "Teleport Menu";

		lbClear _list;
		{
			private _displayName = _x splitstring "_" joinstring " ";
			_list lbAdd _displayName;
			_list lbSetData [_foreachindex,_x];

			preloadCamera (getMarkerPos(_x + "__combat_zone"));
		} foreach [
			"OG_Arms",
			"Church",
			"Airport",
			"Experimental",
			"Quarantine",
			"Mushroom",
			"Capture_Sector",
			"Capture_Alpha",
			"Fed"
		];

		_button1 ctrlSetText "Exit";
		_button1 ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay 2}];

		_button2 ctrlSetText "Spawn";
		_button2 ctrlAddEventHandler ["ButtonClick",{["ButtonClick",_this] call CQC_fnc_displaySpawns}];

		_display displayAddEventHandler ["MouseHolding",{["LBUpdate",_this] call CQC_fnc_displaySpawns}];
		_display displayAddEventHandler ["MouseMoving",{["LBUpdate",_this] call CQC_fnc_displaySpawns}];

	};

	case "onUnload": {};

	case "LBUpdate": {
		private _display = _params param [0,displayNull];
		private _list = _display displayCtrl 2;

		private _units = allPlayers - allDeadMen;
		for "_i" from 0 to (lbSize _list - 1) do {
			private _location = _list lbData _i;

			private _playersNearby = {
				_x distance (getMarkerPos _location) < ((markerSize _location) select 0) * 2
			} count _units;

			_list lbSetTextRight [_i,format["%1 players",_playersNearby]]
		};
	};

	case "ButtonClick": {
		private _button = _params param [0,controlNull];
		//_button ctrlEnable false;
		private _display = ctrlParent _button;
		private _list = _display displayCtrl 2;

		private _location = _list lbData (lbCurSel _list);
		private _locationName = _list lbText (lbCurSel _list);

		switch (_locationName) do {

			case "OG Arms" : {
				execVM "scripts\jstar_teleport\jstar_spawns\jstar_og.sqf";
			
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};
			
			case "Church" : {
				execVM "scripts\jstar_teleport\jstar_spawns\jstar_church.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};

			case "Airport" : {
				execVM "scripts\jstar_teleport\jstar_spawns\jstar_airport.sqf";
				["Airport is for MRAP decamping, don't roach"] spawn CQC_fnc_Notification;
				player addEventHandler ["HandleDamage", {0}];
				{if ( _x in primaryWeaponMagazine player ) then { player removeMagazine _x }} forEach magazines player;
				player setAmmo [currentWeapon player,0];
				player addAction ["", { 
				["Your gun is disabled until you spawn in a vehicle (Shift + 2)"] spawn CQC_fnc_Notification; 
				}, "", 0, false, true, "DefaultAction"];
			};

			case "Experimental" : {
				execVM "scripts\jstar_teleport\jstar_spawns\alecw_experimental.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};
			
			case "Quarantine" : {
				execVM "scripts\jstar_teleport\jstar_spawns\alecw_quarantine.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};
			
			case "Mushroom" : {
				execVM "scripts\jstar_teleport\jstar_spawns\alecw_mushroom.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};

			Case "Capture Sector" : {
				execVM "scripts\jstar_teleport\jstar_spawns\jstar_gravia.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};

			Case "Capture Alpha" : {
				execVM "scripts\jstar_teleport\jstar_spawns\CQC_capturealpha.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};

			Case "Fed" : {
				execVM "scripts\jstar_teleport\jstar_spawns\jstar_fed.sqf";
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
		
				[] spawn CQC_fnc_handleDamage;
			};

			Case "" : {
				["Please select a valid spawn."] spawn CQC_fnc_Notification;
			};
		};
	};
};
canTeleport = false;