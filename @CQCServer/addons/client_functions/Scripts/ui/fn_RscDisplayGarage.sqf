/*
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-04-24 09:20:06
* @Last Modified by:   DnA
* @Last Modified time: 2014-09-25 09:10:39
*/

#define IDD_RSCDISPLAYGARAGE								5100
#define IDC_RSCDISPLAYGARAGE_TITLE							5100
#define IDC_RSCDISPLAYGARAGE_BACKGROUND						5101
#define IDC_RSCDISPLAYGARAGE_BACKGROUNDFILTER				5102
#define IDC_RSCDISPLAYGARAGE_FILTER0						5103
#define IDC_RSCDISPLAYGARAGE_FILTER1						5104
#define IDC_RSCDISPLAYGARAGE_FILTER2						5105
#define IDC_RSCDISPLAYGARAGE_FILTER3						5106
#define IDC_RSCDISPLAYGARAGE_FILTER4						5107
#define IDC_RSCDISPLAYGARAGE_TREEVEHICLES					5108
#define IDC_RSCDISPLAYGARAGE_TEXTSKIN						5109
#define IDC_RSCDISPLAYGARAGE_COMBOSKIN						5110
#define IDC_RSCDISPLAYGARAGE_BACKGROUNDICONVEHICLE			5113
#define IDC_RSCDISPLAYGARAGE_ICONVEHICLE					5114
#define IDC_RSCDISPLAYGARAGE_BUTTONSPAWN					5115

params [ "_mode", "_params" ];

switch (_mode) do {

	case "onLoad": {

		//--- Controls
		_display = ( _params#0 );

		//--- Control Filters
		{

			_ctrl = _display displayCtrl _x;
			_ctrl ctrlAddEventHandler [ "ButtonClick",  format [ " [ 'onFilterChanged', [ ctrlParent ( _this#0 ), %1 ] ] call CQC_fnc_RscDisplayGarage ", _forEachIndex ] ];

		} forEach [
			IDC_RSCDISPLAYGARAGE_FILTER2,
			IDC_RSCDISPLAYGARAGE_FILTER1,
			IDC_RSCDISPLAYGARAGE_FILTER3,
			IDC_RSCDISPLAYGARAGE_FILTER4,
			IDC_RSCDISPLAYGARAGE_FILTER0
		];

		//--- Call filter EH
		CQC_RscDisplayGarage_filter = missionNamespace getVariable [ "CQC_RscDisplayGarage_filter", 4 ];
		[ "onFilterChanged", [ _display ] ] call CQC_fnc_RscDisplayGarage;

		//--- Control ListVehicles
		_ctrlTreeVehicles = _display displayCtrl IDC_RSCDISPLAYGARAGE_TREEVEHICLES;

		//--- Control ListVehicles
		_ctrlIconVehicle = _display displayCtrl IDC_RSCDISPLAYGARAGE_ICONVEHICLE;
		[ _ctrlIconVehicle, 0.8, 0 ] call BIS_fnc_ctrlSetScale; //--- Scale down

		//--- Control ButtonSpawn
		_ctrlButtonSpawn = _display displayCtrl IDC_RSCDISPLAYGARAGE_BUTTONSPAWN;
		_ctrlButtonSpawn ctrlAddEventHandler [ "ButtonClick",  { [ "spawnVehicle", [ ctrlParent ( _this#0 ) ] ] call CQC_fnc_RscDisplayGarage } ];

		//--- Set default control focus
		ctrlSetFocus _ctrlTreeVehicles;

	};

	/////////////////////////////////////////////////////////////////////////////////

	case "onUnload": {
	};

	/////////////////////////////////////////////////////////////////////////////////

	case "onFilterChanged": {

		//--- Controls
		_display = _params#0;
		_ctrlTreeVehicles = _display displayCtrl IDC_RSCDISPLAYGARAGE_TREEVEHICLES;
		_ctrlBackgroundFilter = _display displayCtrl IDC_RSCDISPLAYGARAGE_BACKGROUNDFILTER;
		_list = CQC_ModuleVehicles_list;
		_curSel = if ( count _params > 1 ) then { _params#1 } else { CQC_RscDisplayGarage_filter };

		_list = if ( _curSel isEqualTo 4 ) then {

			_return = [];

			{

				_return = _return + _x

			} forEach _list;

			_return

		} else {

			_list#_curSel

		};

		//--- Remove treeview EH
		_ctrlTreeVehicles ctrlRemoveAllEventHandlers "TreeSelChanged";

		//--- Clear treeview
		tvClear _ctrlTreeVehicles;

		//--- Populate treeview
		{

			//--- Add faction
			_displayName = _x#0;
			_icon = _x#1;
			_vehicleClasses = _x#2;

			_tvFaction = _ctrlTreeVehicles tvAdd [ [], _displayName ];
			_ctrlTreeVehicles tvSetPicture [ [ _tvFaction ], _icon ];

			{

				//--- Add vehicle classes
				private [ "_displayName", "_vehicles" ];
				_displayName = _x#0;
				_vehicles = _x#1;

				_tvVehicleClass = _ctrlTreeVehicles tvAdd [ [ _tvFaction ], _displayName ];

				{

					//--- Add vehicles
					private [ "_displayName", "_icon", "_className" ];
					_displayName = _x#0;
					_icon = _x#1;
					_className = _x#2;

					_tvVehicle = _ctrlTreeVehicles tvAdd [ [ _tvFaction, _tvVehicleClass ], _displayName ];
					_tvVehicle = [ _tvFaction, _tvVehicleClass, _tvVehicle ];

					_ctrlTreeVehicles tvSetPicture [ _tvVehicle, _icon ];
					_ctrlTreeVehicles tvSetData [ _tvVehicle, _className ];

				} forEach _vehicles;

				_ctrlTreeVehicles tvSort [ [ _tvFaction, _tvVehicleClass ], false ];

			} forEach _vehicleClasses;

			_ctrlTreeVehicles tvSort [ [ _tvFaction ], false ];
			_ctrlTreeVehicles tvExpand [ _tvFaction ];

		} forEach _list;

		//--- Update filters visual
		_delay = if ( CQC_RscDisplayGarage_init ) then { 0.1 } else { 0 };

		{

			_ctrl = _display displayCtrl _x;
			_color = _forEachIndex call BIS_fnc_sideColor;
			_alpha = 0.5;
			_scale = 0.75;

			if ( _forEachIndex isEqualTo _curSel ) then {

				_alpha = 1;
				_scale = 1;
				CQC_RscDisplayGarage_filter = _forEachIndex;

			};

			_ctrl ctrlSetActiveColor _color;
			_color set [ 3, _alpha ];
			_ctrl ctrlSetTextColor _color;
			_pos = [ _ctrl, _scale, _delay ] call BIS_fnc_ctrlSetScale;

			if ( _forEachIndex isEqualTo _curSel ) then {

				_ctrlBackgroundFilter ctrlSetPosition _pos;
				_ctrlBackgroundFilter ctrlCommit _delay;

			};

		} forEach [
			IDC_RSCDISPLAYGARAGE_FILTER2,
			IDC_RSCDISPLAYGARAGE_FILTER1,
			IDC_RSCDISPLAYGARAGE_FILTER3,
			IDC_RSCDISPLAYGARAGE_FILTER4,
			IDC_RSCDISPLAYGARAGE_FILTER0
		];

		//--- Call treeview#EH
		[ "onVehicleSelChanged", [ _display ] ] call CQC_fnc_RscDisplayGarage;

		//--- Add treeview#EH
		_ctrlTreeVehicles ctrlAddEventHandler [ "TreeSelChanged",  { [ "onVehicleSelChanged", [ ctrlParent ( _this#0 ) ] ] call CQC_fnc_RscDisplayGarage } ];

	};

	/////////////////////////////////////////////////////////////////////////////////

	case "onVehicleSelChanged": {

		_display = _params#0;
		_ctrlTreeVehicles = _display displayCtrl IDC_RSCDISPLAYGARAGE_TREEVEHICLES;
		_ctrlComboSkin = _display displayCtrl IDC_RSCDISPLAYGARAGE_COMBOSKIN;
		_ctrlIconVehicle = _display displayCtrl IDC_RSCDISPLAYGARAGE_ICONVEHICLE;
		_ctrlButtonSpawn = _display displayCtrl IDC_RSCDISPLAYGARAGE_BUTTONSPAWN;
		_curSel = tvCurSel _ctrlTreeVehicles;
		_className = _ctrlTreeVehicles tvData _curSel;

		if ( count _curSel isEqualTo 3 ) then {

			//--- Update options
			[ "updateOptions", [ _display, _className ] ] call CQC_fnc_RscDisplayGarage;

			//--- Enable spawn
			_ctrlButtonSpawn ctrlEnable true;

		} else {

			//--- Disable options
			_ctrlComboSkin ctrlEnable false;
			lbClear _ctrlComboSkin;
			_ctrlButtonSpawn ctrlEnable false;
			_ctrlIconVehicle ctrlSetText "";

		};

	};

	/////////////////////////////////////////////////////////////////////////////////

	case "updateOptions": {

		_display = _params#0;
		_ctrlIconVehicle = _display displayCtrl IDC_RSCDISPLAYGARAGE_ICONVEHICLE;
		_ctrlComboSkin = _display displayCtrl IDC_RSCDISPLAYGARAGE_COMBOSKIN;
		_className = _params#1;
		_cfg = configFile >> "CfgVehicles" >> _className;

		//--- Update vehicle icon
		_icon = ( getText ( _cfg >> "picture" ) ) call BIS_fnc_textureVehicleIcon;
		_ctrlIconVehicle ctrlSetText _icon;

		//--- Add skins to combo
		lbClear _ctrlComboSkin;
		_ctrlComboSkin lbAdd "Default";
		_ctrlComboSkin lbSetValue [ 0, -1 ];
		_ctrlComboSkin lbSetCurSel 0;

		//--- Check for skins from CQC_CfgVehicleSkins
		{
			private _cfgSkin = missionConfigFile >> "CQC_CfgVehicleSkins" >> _x;
			{
				//--- Add skins to array
				if ( isClass _cfg ) then {
					{
						_skin = _x;
						_displayName = getText ( _skin >> "displayName" );
						_textures = getArray ( _skin >> "textures" );

						_lbSkin = _ctrlComboSkin lbAdd _displayName;
						_ctrlComboSkin lbSetData [ _lbSkin, str _textures ];
					} forEach ( "true" configClasses _x );
				};
			} forEach ( _cfgSkin call BIS_fnc_returnParents );
		} forEach ( [ _cfg, true ] call BIS_fnc_returnParents );

		//--- Enable/disable skins combo
		if ((call isDonator) OR (call isAdmin)) then {
			_ctrlComboSkin ctrlEnable ( lbSize _ctrlComboSkin > 1 );
		} else {
			_ctrlComboSkin ctrlEnable false;
		};

	};

	/////////////////////////////////////////////////////////////////////////////////

	case "spawnVehicle": {

		_display = _params#0;
		_ctrlTreeVehicles = _display displayCtrl IDC_RSCDISPLAYGARAGE_TREEVEHICLES;
		_ctrlComboSkin = _display displayCtrl IDC_RSCDISPLAYGARAGE_COMBOSKIN;
		_curSel = tvCurSel _ctrlTreeVehicles;
		_curSelSkin = lbCurSel _ctrlComboSkin;
		_className = _ctrlTreeVehicles tvData _curSel;

		//--- Calculate spawn position
		_pos = ( [ player, 15, getDir player ] call BIS_fnc_relPos );

		//--- Check for nearby entities
		if ( count nearestObjects [ _pos, [ "Car", "Tank", "Air", "Ship" ], 10 ] > 0 ) exitWith {

			["Unable to spawn vehicle near other vehicles"] spawn CQC_fnc_Notification;

		};

		//--- Create vehicle
		_vehicle = createVehicle [ _className, _pos, [], 0, "CAN_COLLIDE" ];
		_vehicle setPosASL AGLtoASL _pos;
		_vehicle setDir getDir player;
		_vehicle setVehicleAmmo 0;
		_vehicle setVehicleAmmoDef 0;
		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		
		//--- Apply vehicle skin
		if ( ctrlEnabled _ctrlComboSkin && { _curSelSkin > 0 } ) then {

			//--- Texture data
			_texture = call compile( _ctrlComboSkin lbData _curSelSkin );

			//--- Disable texture randomisation
			_vehicle setVariable [ "BIS_enableRandomization", false ];
			
			//--- Set vehicle texture
			{ _vehicle setObjectTextureGlobal [_forEachIndex, _x ] } forEach _texture;
			
			// --- Clears the stuff inside of the vehicle
			_vehicle setVehicleAmmo 0;
			_vehicle setVehicleAmmoDef 0;
			clearWeaponCargoGlobal _vehicle;
			clearMagazineCargoGlobal _vehicle;
			clearItemCargoGlobal _vehicle;
			clearBackpackCargoGlobal _vehicle;

		};

		//--- Create UAV AI
		if ( getText ( configFile >> "CfgVehicles" >> _className >> "vehicleClass" ) isEqualTo "Autonomous" ) then {

			createVehicleCrew _vehicle;

		};
		
		{
			player removeAction _x;
		} foreach [1,2,3,4,5];
		
		// add ammo back
		player setAmmo [currentWeapon player,999];
		
		if (["arifle_ARX", currentWeapon player] call BIS_fnc_inString) then {
			for  "_i" from 1 to 100 do { 
	
				Fn_Gear_CompatibleMagazines = {  
					private _cls = configFile >> "CfgWeapons" >> currentWeapon player;  
					private _res = [];  
					{
						_res pushBack (if (_x isEqualTo "this") then {
							getArray(_cls >> "magazines")
						} else {
							getArray(_cls >> _x >> "magazines")});  
					} forEach getArray (_cls >> "muzzles");  
			
					_res  
				};  
		
				private _unt = player;  
		
				{ 
					if (count _x > 0) then {  
						{ if (count _x > 1) then {     
							_unt addMagazine (_x#0)}  
						} foreach (_x call Fn_Gear_CompatibleMagazines)   
					}
				} forEach [primaryWeapon _unt];  
			};
		}; 
		if (["LMG_",currentWeapon player] call BIS_fnc_inString) then {
			for  "_i" from 1 to 100 do { 
	
				Fn_Gear_CompatibleMagazines = {  
					private _cls = configFile >> "CfgWeapons" >> currentWeapon player;  
					private _res = [];  
					{_res pushBack 
						(
							if (_x isEqualTo "this") then {
								getArray(_cls >> "magazines")
							} else {
								getArray(_cls >> _x >> "magazines")}
						);  
					} forEach getArray (_cls >> "muzzles");  
			
					_res  
				};  
		
				private _unt = player;  
		
				{ 
					if (count _x > 0) then {  
						{ 
							if (count _x > 0) then {     
							_unt addMagazine (_x#1)}  
						} foreach (_x call Fn_Gear_CompatibleMagazines)   
					}  
				} forEach [primaryWeapon _unt];  
			};
		} else {
			for  "_i" from 1 to 100 do { 
 
				Fn_Gear_CompatibleMagazines = {  
					private _cls = configFile >> "CfgWeapons" >> currentWeapon player;  
					private _res = [];  
					{
						_res pushBack (
						if (_x isEqualTo "this") then {
							getArray(_cls >> "magazines")
						} else {
							getArray(_cls >> _x >> "magazines")}
						);  
					} forEach getArray (_cls >> "muzzles");  
			
					_res  
				};  
  
				private _unt = player;  
				
				{
					if (count _x > 0) then {  
						{ 
							if (count _x > 0) then {     
							_unt addMagazine (_x#0)}  
						} foreach (_x call Fn_Gear_CompatibleMagazines)   
					}  
				} forEach [primaryWeapon _unt];  
			};
		};
		
		[] spawn CQC_fnc_eventHandlers;
		
		player moveInAny _vehicle;

		//--- Cleanup when killed
		if ( CQC_ModuleVehicles_garageGC > -1 ) then {

			_vehicle addEventHandler [ "killed", {

				//--- Remove vehicle from spawned array
				CQC_ModuleVehicles_spawned = CQC_ModuleVehicles_spawned - [ _this#0 ];

				//--- Cleanup unit with delay preference
				[ _this#0, CQC_ModuleVehicles_garageGC ] call CQC_fnc_cleanupUnit;

			} ];

		};

		//--- Add vehicle to spawned array
		CQC_ModuleVehicles_spawned pushBack _vehicle;

		//--- Enforce spawn limit
		if ( CQC_ModuleVehicles_garageLimit > 0 && { count CQC_ModuleVehicles_spawned > CQC_ModuleVehicles_garageLimit } ) then {

			["Your previous vehicle was removed"] spawn CQC_fnc_Notification;

			//--- Delete first spawned vehicle
			deleteVehicle ( CQC_ModuleVehicles_spawned#0 );
			[ CQC_ModuleVehicles_spawned ] call BIS_fnc_arrayShift;

		};

		//--- Close display
		closeDialog 1;

	};

};
