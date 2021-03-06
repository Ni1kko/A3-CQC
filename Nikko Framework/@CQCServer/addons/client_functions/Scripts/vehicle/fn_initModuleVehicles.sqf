/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

//--- Process CfgPatches units
private _list = [ [], [], [], [] ];
private _factions = [ [], [], [], [] ];
private _vehicleClasses = [ [], [], [], [] ];
private _blacklist = [];

{
	{

		private _className = toLower _x;
		private _isVehicle = false;
		private _types = [ 

			// OPFOR
			"O_MRAP_02_F", // Ifrit
			"O_T_LSV_02_unarmed_F", // Qilin (Unarmed)

			// BLURFOR
			"B_MRAP_01_F", // Hunter
			"B_T_LSV_01_unarmed_F", // Prowler (Unarmed)

			// CIVILIAN
			"C_Hatchback_01_sport_F", // Hatchback (Sport)

			// INDEP
			"I_MRAP_03_F" // Strider
		];
		

		//--- Check if vehicle is correct type
		{ if(_className isKindOf _x)exitwith{_isVehicle = true}} foreach _types;

		//--- Proceed if vehicle is correct type
		if (_isVehicle && !(_className in _blacklist)) then {	

			//--- Add className to blacklist
			_blacklist pushBack _className;

			private _cfg = configfile >> "CfgVehicles" >> _className;
			private _side = getNumber ( _cfg >> "side" );
			private _public = getNumber ( _cfg >> "scope" ) isEqualTo 2;

			//--- Proceed if scope is public and side not empty
			if (_public && _side <= 3) then 
			{
				private _displayName = getText ( _cfg >> "displayName" );
				private _icon = ( getText ( _cfg >> "icon" ) ) call BIS_fnc_textureVehicleIcon;
				private _faction = toLower ( getText ( _cfg >> "faction" ) );
				private _vehicleClass = toLower ( getText ( _cfg >> "vehicleClass" ) );

				//--- Add faction to factions array
				if (!( _faction in (_factions select _side))) then 
				{
					private _cfg = configfile >> "CfgFactionClasses" >> _faction;
					private _displayName = getText ( _cfg >> "displayName" );
					private _icon = getText ( _cfg >> "icon" );

					//--- Add faction to factions -> side array
					_factions select _side pushBack _faction;

					//--- Add empty array to vehicle clases -> side array
					_vehicleClasses select _side pushBack [];

					//--- Add faction array to _list -> side array
					_list select _side pushBack [ _displayName, _icon, [] ];

				};

				//--- Add vehicle class to vehicle classes array
				_factionIndex = ( _factions select _side find _faction );

				if ( !( _vehicleClass in ( ( _vehicleClasses select _side ) select _factionIndex ) ) ) then 
				{
					private _cfg = configfile >> "CfgVehicleClasses" >> _vehicleClass;
					private _displayName = getText ( _cfg >> "displayName" );

					//--- Add vehicle class to vehicle classes -> side -> faction array
					( _vehicleClasses select _side ) select _factionIndex pushBack _vehicleClass;

					//--- Add vehicle class array to list -> side -> faction array
					( ( _list select _side ) select _factionIndex ) select 2 pushBack [ _displayName, [] ];

				};

				//--- Add vehicle to list -> side -> faction -> vehicle class array
				private _vehicleClassIndex = ((( _vehicleClasses select _side) select _factionIndex) find _vehicleClass);
				[((((_list select _side) select _factionIndex) select 2) select _vehicleClassIndex) select 1 pushBack [_displayName, _icon, _className ]];
			};

		};

	} forEach getArray ( _x >> "units" );

} forEach ("true" configClasses (configFile >> "CfgPatches" ));

//--- Update global list
CQC_ModuleVehicles_list = _list;