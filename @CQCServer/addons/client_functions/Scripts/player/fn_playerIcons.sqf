{
    private _unit = (vehicle _x);
    private _player = (vehicle player);
    private _distance = _player distance2D _unit;
	
	
	/*
		need to check the _unit in question isdonator or isadmin not just the current player
	*/
	private _colour = if (call isDonator) then {
		[1,0.545,0,1];
	} else {
		if (call isAdmin) then {
			[0.898,0.322,0.322,1];
		} else {
			[1,1,1,1];
		};
	};
	
	// If not in vehicle
	if (alive _unit && (_unit isKindOf "man") && { _distance < 10 }) then {
		if (alive _x && vehicle _x isEqualTo _x) then {
			_vis = lineIntersects [eyePos player, eyePos _x,player, _x];
			if(!_vis) then {
				private _text   = "";
				private _pos        = (_unit modelToWorldVisual (_unit selectionPosition "head"));
				_pos set [2, (_pos select 2) + 0.7];
							
				if ( _distance < 10 ) then { _text = format ["%1", name _unit]};
				
				drawIcon3D [
					"iconMan",
					_colour,
					_pos,
					0.65,
					0.65,
					0,
					_text,
					2,
					0.03,
					"PuristaMedium"
				];
			};
		};
	};
	
	// If in Vehicle
	if (alive _unit && (!(_unit isKindOf "man")) && { _distance < 25 }) then {
		if (alive _x) then {
			_vis = lineIntersects [eyePos player, eyePos _x, player, _x];
			if (!_vis) then {
				private _text   = "";
				private _pos    = (_unit modelToWorldVisual (_unit selectionPosition "head"));
				_pos set [2, (_pos select 2) + 0.7];
							
				if ( _distance < 25 ) then { _text = (name _unit); };
			
				drawIcon3D [
					"iconCar",
					_colour,
					_pos,
					0.65,
					0.65,
					0,
					_text,
					2,0.03,
					"PuristaMedium"
				];
			};
		};
	};
} count allPlayers - [(player)];

