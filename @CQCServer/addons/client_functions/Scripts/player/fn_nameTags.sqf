/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _renderESP = {
	params ["_target","_dist","_draw"];
	private _rendered = false;
	if((alive _target) AND !(isObjectHidden _target) AND !(lineIntersects [eyePos player, eyePos _target, player, _target])) then{
		private _targetDistance = player distance2D _target; 
		if (_targetDistance < _dist) then {
			if (_targetDistance < (_dist / 2)) then {_draw set [6, name _target]}; 
			_rendered = true;
			drawIcon3D _draw;
		};
	};
	_rendered
};

private _admins = missionNamespace getVariable ["CQCAdmins",[]];
private _donators = missionNamespace getVariable ["CQCDonators",[]];
private _renderDistance = 60;

{
	private _target = _x;
	private _targetVehicle = (vehicle _target); 
	private _targetInVehicle = (_targetVehicle isNotEqualTo _target);
	private _targetPosition = (_target modelToWorldVisual (_target selectionPosition "head"));
	private _targetDistance = player distance2D _targetPosition;
	private _targetColor = switch (true) do {
		case ((getPlayerUID _target) in _donators): {[1,0.545,0,1]};
		case ((getPlayerUID _target) in _admins): {[0.898,0.322,0.322,1]};
		default {[1,1,1,1]};
	};
	
	_targetPosition set [2, (_targetPosition select 2) + 0.7];
	
	if(_targetInVehicle) then{
		CQC_var_enemyRendered = [_targetVehicle, (_renderDistance + 10), ["iconCar",_targetColor,_targetPosition,0.65,0.65,0,"",2,0.03,"PuristaMedium"]] call _renderESP;
	}else{
		CQC_var_enemyRendered = [_target, 		 (_renderDistance / 2), ["iconMan",_targetColor,_targetPosition,0.65,0.65,0,"",2,0.03,"PuristaMedium"]] call _renderESP;
	};
} forEach allUnits - [player];

CQC_var_enemyRendered