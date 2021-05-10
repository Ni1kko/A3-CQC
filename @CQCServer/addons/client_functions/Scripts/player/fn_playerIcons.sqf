
private _admins = missionNamespace getVariable ["CQCAdmins",[]];
private _donators = missionNamespace getVariable ["CQCDonators",[]];
{
	private _target = _x;
	private _targetText = "";
	private _targetSteamID = getplayeruid _x;
	private _targetVehicle = (vehicle player); 
	private _targetInVehicle = (_targetVehicle isNotEqualTo player);
    private _targetDistance = player distance2D _target;
	private _targetHidden = (isObjectHidden _target OR isObjectHidden _targetVehicle);
	private _targetPosition = (_target modelToWorldVisual (_target selectionPosition "head"));
	private _targetColor = switch (true) do {
		case (_targetSteamID in _donators): {[1,0.545,0,1]};
		case (_targetSteamID in _admins): {[0.898,0.322,0.322,1]};
		default {[1,1,1,1]};
	};
	
	_targetPosition set [2, (_targetPosition select 2) + 0.7];

	if(_targetInVehicle AND !_targetHidden AND !(lineIntersects [eyePos player, eyePos _target, player, _target])) then{
		if (alive _targetVehicle AND _targetDistance < 50) then {
			if (_targetDistance < 25) then { _targetText = (name _target); }; 
			drawIcon3D [
				"iconCar",
				_targetColor,
				_targetPosition,
				0.65,
				0.65,
				0,
				_targetText,
				2,0.03,
				"PuristaMedium"
			];
		};
	}else{
		if (alive _target AND _targetDistance < 20) then {
			if (_distance < 10) then { _targetText = format ["%1", name _target]};
			drawIcon3D [
				"iconMan",
				_targetColor,
				_targetPosition,
				0.65,
				0.65,
				0,
				_targetText,
				2,
				0.03,
				"PuristaMedium"
			];
		};
	};
} count allPlayers - [(player)];