private _markers = [];
private _members = [];

while { true } do {
	if ( visibleMap ) then {
		_members = units (group player);
		{
			_marker = createMarkerLocal [format["%1_marker",_x], getPosASLVisual _x];
			_marker setMarkerDirLocal getDirVisual _x;
			_marker setMarkerColorLocal "ColorUNKNOWN";
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerTextLocal format ["%1", name player];
			_markers pushBack [_marker, _x];
		} foreach _members;
			
		while {visibleMap} do {
			{

				_x params [ "_marker", "_unit" ];

				if ( !isNil "_unit" ) then {
					if ( !isNull _unit ) then {
					    _marker setMarkerPosLocal (getPosASLVisual _unit);
					};
				};
			} foreach _markers;
			if ( !visibleMap ) exitWith {  };
		};

		{
			deleteMarkerLocal ( _x #0 );
		} foreach _markers;
		_markers = [];
		_members = [];
	};
};