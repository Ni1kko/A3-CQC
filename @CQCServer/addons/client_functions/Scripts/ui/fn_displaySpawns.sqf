params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
	case "onLoad":
	{
		private _display = _params param [0,displayNull];
		private _title = _display displayCtrl 1;
		private _list = _display displayCtrl 2;
		private _button1 = _display displayCtrl 3;
		private _button2 = _display displayCtrl 4;

		_title ctrlSetText "Teleport Menu";

		private _zones = [];
		
		{
			if (getNumber(missionConfigFile >> "CQCSpawns" >> _x) isEqualTo 1) then {
				_zones pushBackUnique _x;
			};
		}forEach [
			"OG_Arms",
			"Church",
			"Airport",
			"Experimental",
			"Quarantine",
			"Mushroom",
			"Gravia",
			"Fed"
		];
		
		 
		//No zones enabled
		if(count _zones isEqualTo 0)exitWith{
			closeDialog 1;
		};

		//donator last pos
		if(CQC_var_lastSpawnPos != "" AND (call isDonator) AND CQC_var_inSpawnArea)then{
			_zones = (["Last_Position"] + _zones);
		};

		//add each zone
		lbClear _list;{
			_list lbAdd (_x splitstring "_" joinstring " ");
			_list lbSetData [_foreachindex,if(_x isEqualTo "Last Position")then{CQC_var_lastSpawnPos splitstring " " joinstring "_"}else{_x}];
		} foreach _zones;

		//select first so you can press enter
		_list lbSetCurSel 0;

		//
		_button1 ctrlSetText "Exit";
		_button1 ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay 2}];

		//
		_button2 ctrlSetText "Spawn";
		_button2 ctrlAddEventHandler ["ButtonClick",{["ButtonClick",_this] call CQC_fnc_displaySpawns}];

		//
		_display displayAddEventHandler ["MouseHolding",{["LBUpdate",_this] call CQC_fnc_displaySpawns}];
		_display displayAddEventHandler ["MouseMoving",{["LBUpdate",_this] call CQC_fnc_displaySpawns}];
		_display displayAddEventHandler ["KeyUp", {
			params ["_display", "_key", "_shift", "_ctrl", "_alt"];
			private _pressed = false;
			if(_key in [28,156])then{
				["ButtonClick",[_display displayCtrl 3]] call CQC_fnc_displaySpawns;
				_pressed = true;
			};
			_pressed
		}];

		setMousePosition [0.5, 0.5];
	};
	case "onUnload": 
	{
	};
	case "LBUpdate": 
	{
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
	case "ButtonClick": 
	{
		private _button = _params param [0,controlNull]; 
		private _display = ctrlParent _button;
		private _list = _display displayCtrl 2; 
		private _location = _list lbData (lbCurSel _list);
		private _locationName = _list lbText (lbCurSel _list); 
		private _spawned = false;

		if(_locationName isEqualTo "Last Position")then{
			_locationName = CQC_var_lastSpawnPos;
		};

		private _markerSuffix = (_locationName splitString " " joinString "_");
		  
		if (getNumber(missionConfigFile >> "CQCSpawns" >> _markerSuffix) isEqualTo 0) exitWith {
			[format["%1 is temporary disabled",_locationName]] spawn CQC_fnc_Notification;
		};

		switch _markerSuffix do 
		{
			case "Airport" : 
			{ 
				_spawned = [_markerSuffix, 1, 15] call CQC_fnc_handleSpawn;
				if(_spawned)then{
					["Airport is for MRAP decamping, don't roach"] spawn CQC_fnc_Notification;
					player allowDamage false;
					CQC_var_airportActionID = player addAction ["", {["Your gun is disabled until you spawn in a vehicle (Shift + 2)"] spawn CQC_fnc_Notification}, "", 0, false, true, "DefaultAction"];
					[]spawn{
						waitUntil{uiSleep 0.9; (player distance2D (getMarkerPos format ["CQC_Marker_Spawn_%11",_markerSuffix]) > 750)}; 
						if(!CQC_var_inSpawnArea AND CQC_var_airportActionID != -1)then{
							player allowDamage true;
							player removeAction CQC_var_airportActionID;
							CQC_var_airportActionID = -1;
						};
					};
				};
			};
			case "OG_Arms" : 
			{
				_spawned = [_markerSuffix, 1, 12] call CQC_fnc_handleSpawn;
			};
			default
			{
				_spawned = [_markerSuffix, 1, 15] call CQC_fnc_handleSpawn;
			};
		};

		if(_spawned)then{
			CQC_var_lastSpawnPos = _locationName;
		};
	};
};