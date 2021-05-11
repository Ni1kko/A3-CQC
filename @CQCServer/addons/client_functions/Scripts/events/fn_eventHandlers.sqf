/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

player removeAllEventHandlers "HandleDamage";
player addEventHandler ["HandleDamage", {
		params ["_unit", "_part", "_damage", "_source"];
		private _vehicle = vehicle _source;
		if ((_vehicle isKindOf "LandVehicle") && ((driver _vehicle) isEqualTo _source)) then {
			if (_source != _unit AND alive _unit AND isPlayer _source) then {
				_damage = 0.001;
			};
		};
		_damage;
}];

player removeAllEventHandlers "HandleHeal";
player addEventHandler ["HandleHeal", {
	_this spawn {
		params ["_injured","_healer"];
		private _damage = damage _injured;
		if (_injured isEqualTo _healer) then {
			waitUntil {damage _injured != _damage};
			if (damage _injured < _damage) then {
				_injured setDamage 0;
			};
		};
	};
}];

player removeAllEventHandlers "Killed";
player addEventHandler ["Killed", CQC_fnc_player_Killed];

player removeAllEventHandlers "Respawn";
player addEventHandler ["Respawn", CQC_fnc_player_respawned];

player removeAllEventHandlers "InventoryOpened";
player addEventHandler ["InventoryOpened", { 
	params [ 
		["_player",objNull,[objNull]], 
		["_inventorycontainer",objNull], 
		["_inventorycontainer2",objNull]
	];
	
	private _inventoryAcssesDistance = 6.8;//too small of a value will prevent users intertacting with certian vehicles due to the med lod points (Default: 10 | Recommended: 6.5 - 15) 
	private _Selfinventory = (true in (["Man","LandVehicle","Ship","Air"] apply {if(cursorObject isKindOf _x)then{cursorObject distance2D player <= _inventoryAcssesDistance}else{false}})) isEqualTo false;
	private _blockAction = true;

	if(alive _player)then
	{
		//Self inventory
		if(_Selfinventory)then{
			_blockAction = false;
		}else{
			//Too Far
			if (cursorObject distance2D _player > _inventoryAcssesDistance)then{
				["You cannot loot that far away"] spawn CQC_fnc_Notification;
			}else{
				//Players inventory
				if (cursorObject isKindOf "Man" || getNumber(configFile >> "CfgVehicles" >> (backpack cursorObject) >> "isBackpack") isEqualTo 1) then {
					["You cannot loot other alive players, you would get caught"] spawn CQC_fnc_Notification;
				}else{
					//Vehicles inventory
					if (true in (["LandVehicle","Ship","Air"] apply {cursorObject isKindOf _x})) then {
						if (locked cursorObject >= 2) exitWith {
							["You cannot loot locked vehicles"] spawn CQC_fnc_Notification;
						};
						_blockAction = false;
					}else{
						//Containers  inventory
						if(getNumber(configFile >> "CfgVehicles" >> typeOf _inventorycontainer >> "isBackpack") isEqualTo 0)then{ 
							["You cannot loot containers"] spawn CQC_fnc_Notification;
						};
					};
				};
			};
		}; 
	};

	if(_blockAction)then{ 
		_player spawn{
			_this switchMove "";
			waitUntil {_this switchMove ""; isNull(finddisplay 602)}; 
			_this switchMove ""; 
		};
	};

	_blockAction
}];

player removeAllEventHandlers "InventoryClosed";
player addEventHandler ["InventoryClosed", {
	params [ 
		["_player",objNull,[objNull]], 
		["_inventorycontainer",objNull]
	];
 
	_player switchMove "";

	private _curInventory = [_player,getUnitLoadout _player];

	if(CQC_var_lastInventory isNotEqualTo _curInventory)then{
		CQC_var_lastInventory = _curInventory;
		[] call CQC_fnc_saveGear;
	};

	false
}];

player removeAllEventHandlers "Take";
player addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	private _curInventory = [_player,getUnitLoadout _player];
	
	if(CQC_var_lastInventory isNotEqualTo _curInventory)then{
		CQC_var_lastInventory = _curInventory;
		[] call CQC_fnc_saveGear;
	};
}];

player removeAllEventHandlers "Put";
player addEventHandler ["Put", {
	params ["_unit", "_container", "_item"];
	private _curInventory = [_player,getUnitLoadout _player];
	
	if(CQC_var_lastInventory isNotEqualTo _curInventory)then{
		CQC_var_lastInventory = _curInventory;
		[] call CQC_fnc_saveGear;
	};
}];

player removeAllEventHandlers "FiredNear";
player addEventHandler ["FiredNear", {
	params [
		"_unit", 	 // unit: Object - Object the event handler is assigned to
		"_firer",    // firer: Object - Object which fires a weapon near the unit
		"_distance", // distance: Number - Distance in meters between the unit and firer (max. distance ~69m)
		"_weapon", 	 // weapon: String - Fired weapon
		"_muzzle", 	 //  muzzle: String - Muzzle that was used
		"_mode", 	 // mode: String - Current mode of the fired weapon
		"_ammo",     // ammo: String - Ammo used 
		"_gunner"    // gunner: Object - gunner, whose weapons are fired
	];
	
	CQC_var_combatTimer = diag_tickTime + 25;
}];

player removeAllEventHandlers "Hit";
player addEventHandler ["Hit", {
	params [
		"_unit", 		// unit: Object - Object the event handler is assigned to
		"_source", 		// source: Object - Object that caused the damage – contains unit in case of collisions
		"_damage",      // damage: Number - Level of damage caused by the hit
		"_instigator"   // instigator: Object - Person who pulled the trigger
	];

	CQC_var_combatTimer = diag_tickTime + 25;
}];