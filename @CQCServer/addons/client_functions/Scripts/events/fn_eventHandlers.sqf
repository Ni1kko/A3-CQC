// CQC_fnc_eventHandlers

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

player addEventHandler ["InventoryOpened", {
		[_this#0, _this#1] spawn {   
			waituntil {!(isnull (finddisplay 602)) && ((_this#1) isEqualTo backpackContainer cursorTarget or (!alive cursorTarget && cursorTarget isKindOf "man")) };
			["You cannot look in players inventory's"] spawn CQC_fnc_Notification;
			closeDialog 602
		};
		false
	}
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

player addEventHandler [ "Killed", { [_this] spawn CQC_fnc_player_Killed; } ];
player addEventHandler [ "Respawn", { [_this] spawn CQC_fnc_player_respawn; } ];