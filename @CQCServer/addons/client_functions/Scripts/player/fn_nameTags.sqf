/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _rendered = false;
private _renderDistance = getNumber(missionConfigFile >> 'tagRenderDistance');
private _admins = missionNamespace getVariable ["CQCAdmins",[]];
private _donators = missionNamespace getVariable ["CQCDonators",[]];
private _devs = if(!isNil "CQC_DEVS")then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
 
private _targets = allPlayers;

//Only admins and devs and vips see there own tag 
if((getPlayerUID player in (_admins + _donators + _devs)) isEqualTo false)then{
	_targets = _targets - [player];
};

{
	private _target = _x;
	private _targetIcon = "";
	private _targetVehicle = (vehicle _target); 
	private _targetInVehicle = (_targetVehicle isNotEqualTo _target);
	private _targetPosition = (_target modelToWorldVisual (_target selectionPosition "head"));
	private _targetDistance = player distance2D _targetPosition;
	private _targetPlayerUID = getPlayerUID _target;
	private _targetRank = _targetPlayerUID call CQC_fnc_getPlayerRank;
	private _targetColor = _targetPlayerUID call CQC_fnc_getPlayercolor;
	
	if((alive _targetVehicle) AND !(isObjectHidden _targetVehicle) AND !(lineIntersects [eyePos player, eyePos _targetVehicle, player, _targetVehicle])) then
	{
		private _targetDistance = player distance2D _targetVehicle;

		if(_targetInVehicle) then{ 
			_targetIcon = "iconCar";
			_renderDistance = (_renderDistance + 10);
		}else{
			_targetIcon = "iconMan";
			_renderDistance = (_renderDistance / 2);
		};
		
		_targetPosition set [2, (_targetPosition select 2) + 0.7];

		if (_targetDistance < _renderDistance) then 
		{
			if(_targetPlayerUID in _admins || _targetPlayerUID in _devs)then {   
				drawIcon3D [_targetIcon,_targetColor,_targetPosition,0.65,0.65,0,_targetRank,2,0.03,"PuristaMedium"]; 
				_targetPosition set [2, (_targetPosition select 2) - 0.055];
				drawIcon3D ["",_targetColor,_targetPosition,0.65,0.65,0,name _target,2,0.03,"PuristaMedium"];
			}else{
				if(_targetPlayerUID in _donators)then {  
					drawIcon3D [_targetIcon,_targetColor,_targetPosition,0.65,0.65,0,_targetRank,2,0.03,"PuristaMedium"];
					_targetPosition set [2, (_targetPosition select 2) - 0.055];
					drawIcon3D ["",_targetColor,_targetPosition,0.65,0.65,0,"Player",2,0.03,"PuristaMedium"];
				}else{
					drawIcon3D  [_targetIcon,_targetColor,_targetPosition,0.65,0.65,0,"Player",2,0.03,"PuristaMedium"];
				};
			};
		 
			_rendered = true; 
		};
	};
} forEach _targets;

CQC_var_enemyRendered = _rendered;

_rendered