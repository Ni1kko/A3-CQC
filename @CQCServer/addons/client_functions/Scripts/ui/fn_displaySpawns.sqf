params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
	case "onLoad":{
		private _display = _params param [0,displayNull];

		private _title = _display displayCtrl 1;
		private _list = _display displayCtrl 2;
		private _button1 = _display displayCtrl 3;
		private _button2 = _display displayCtrl 4;

		_title ctrlSetText "Teleport Menu";

		_display displayAddEventHandler ["KeyUp", {
			params ["_display", "_key", "_shift", "_ctrl", "_alt"];
			private _pressed = false;
			if(_key in [28,156,57])then{
				["ButtonClick",[_display displayCtrl 3]] call CQC_fnc_displaySpawns;
				_pressed = true;
			};
			_pressed
		}];

		lbClear _list;

		private _zones = [
			"OG_Arms",
			"Church",
			"Airport",
			"Experimental",
			"Quarantine",
			"Mushroom",
			//"Capture_Sector",
			//"Capture_Alpha",
			"Fed"
		];

		//donator last pos
		if(CQC_var_lastSpawnPos != "" AND (call isDonator) AND CQC_var_inSpawnArea)then{
			_zones = (["Last Position"] + _zones);
		};

		//add each zone
		{
			private _displayName = _x splitstring "_" joinstring " ";
			if(_x isEqualTo "Last Position")then{
				_displayName = format ["%1 (%2)",_displayName, CQC_var_lastSpawnPos];
			};
			_list lbAdd _displayName;
			
			_list lbSetData [_foreachindex,if(_x isEqualTo "Last Position")then{CQC_var_lastSpawnPos splitstring " " joinstring "_"}else{_x}];
			preloadCamera (getMarkerPos(_x + "__combat_zone"));
		} foreach _zones;

		//select first so you can press enter
		_list lbSetCurSel 0;

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

		//Temp fix for airport
		player allowDamage true;
		player setAmmo [currentWeapon player,500];

		if(_locationName isEqualTo "Last Position")then{
			_locationName = CQC_var_lastSpawnPos;
		};
		
		switch (_locationName) do {
			case "OG Arms" : {
				[]spawn CQC_fnc_spawn_og;
			
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};
			
			case "Church" : {
				[]spawn CQC_fnc_spawn_church;
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};

			case "Airport" : { 
				[]spawn CQC_fnc_spawn_airport;
				["Airport is for MRAP decamping, don't roach"] spawn CQC_fnc_Notification;
				player allowDamage false;
				{if ( _x in primaryWeaponMagazine player ) then { player removeMagazine _x }} forEach magazines player;
				player setAmmo [currentWeapon player,0];
				//if(player distance2D [14779.1,16835.1,0.00143814] < 500)then{};
				player addAction ["", { 
					["Your gun is disabled until you spawn in a vehicle (Shift + 2)"] spawn CQC_fnc_Notification; 
				}, "", 0, false, true, "DefaultAction"];
			};

			case "Experimental" : {
				[]spawn CQC_fnc_spawn_experimental;
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};
			
			case "Quarantine" : 
			{
				[] spawn CQC_fnc_spawn_quarantine;
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};
			
			case "Mushroom" : { 
				[]spawn CQC_fnc_spawn_mushroom;
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};

			Case "Capture Sector" : {
				[]spawn CQC_fnc_spawn_capture_sector;

				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};

			Case "Capture Alpha" : {
				[]spawn CQC_fnc_spawn_capture_alpha; 
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};

			Case "Fed" : {
				[]spawn CQC_fnc_spawn_fed;
				
				{
					player removeAction _x;
				} foreach [1,2,3,4,5];
			};

			Case "" : {
				["Please select a valid spawn."] spawn CQC_fnc_Notification;
			};
		};

		CQC_var_lastSpawnPos = _locationName;
	};
};
CQC_var_canTeleport = false;