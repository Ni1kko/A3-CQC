
player addEventHandler ["HandleDamage", {
		params [ "_unit", "_part", "_damage", "_source" ];
		private _vehicle = vehicle _source;

		if ((vehicle _source isKindOf "LandVehicle") && ((driver _vehicle) isEqualTo _source)) then {
			if (_source != _unit AND {alive _unit} AND {isPlayer _source}) then {
				_damage = 0.001;
			};
		};
		_damage;
	}
];

player addEventHandler [ "Killed", {
		params [ "_killed", "_killer" ];
		if ( !( _killer isEqualTo _killed ) && { isPlayer _killer && { side _killer isEqualTo side group _killed }} ) then {
			[ _killer, [ 2, 0, 0, 0, 0 ] ] remoteExec[ "addPlayerScores", 2 ];
		};

		if (_killer isEqualTo player) then {
			[] remoteExec ["CQC_fnc_playerAddKill", _killer]
		};
	}
];

//todo
player addEventHandler ["InventoryOpened", { 
	if (count _this isEqualTo 1) exitWith {false};
	private _backpackOwner = _this#0;
	private _backpack = _this#1;

	if (_backpack isKindOf "Man" && alive _backpack) exitWith {
		["You cannot loot other alive players, you would get caught"] spawn CQC_fnc_Notification;
		true;
	};

	if (true in (["LandVehicle","Ship","Air"] apply {_backpack isKindOf _x})) exitWith {
		if (container getVariable ["locked",true]) exitWith {
			["You cannot loot locked cargo"] spawn CQC_fnc_Notification;
			true;
		};
		false
	};

	false
];

player addEventHandler ["InventoryClose", { 
	private _backpack = _this#0;
	if (_backpack isKindOf "Man" isEqualTo false) exitWith {false};
	if (call isDonator) then {
		[] call CQC_fnc_saveGear;
	};
	false
];

player addEventHandler ["HandleHeal", {
		_this spawn {
			params ["_injured","_healer"];
			_damage = damage _injured;
			if (_injured isEqualTo _healer) then {
				waitUntil {damage _injured != _damage};
				if (damage _injured < _damage) then {
					_injured setDamage 0;
				};
			};
		};
	}
];

player addEventHandler [ "Killed", CQC_fnc_player_Killed ];
player addEventHandler [ "Respawn", CQC_fnc_player_respawned ];