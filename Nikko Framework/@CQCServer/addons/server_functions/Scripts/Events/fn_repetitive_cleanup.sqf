/*
	If you want something to withstand the clean up, paste this into it's init:
	this setVariable["persistent",true];	
*/

if (!isServer) exitWith {}; // isn't server         

#define PUSH(A,B) A set [count (A),B];
#define REM(A,B) A=A-[B];

private _deadBodyTimer = [_this,0,0,[0]] call BIS_fnc_param;
private _deadBodyTimer = getNumber(missionConfigFile >> "bodyDeadCleanUp");
if(_deadBodyTimer < 60 AND getNumber(missionConfigFile >> "bodyDeadCleanMins") isEqualTo 0)then{
	60 - ((0.6 - parseNumber format ["0.%1",_deadBodyTimer])  * 100) 
}else{
	(_deadBodyTimer * 60)
};

private _deadVehiclesTimer = getNumber(missionConfigFile >> "vehicleDeadCleanUp");
if(_deadVehiclesTimer < 60 AND getNumber(missionConfigFile >> "vehicleDeadCleanMins") isEqualTo 0)then{
	60 - ((0.6 - parseNumber format ["0.%1",_deadVehiclesTimer])  * 100) 
}else{
	(_deadVehiclesTimer * 60)
};

private _abandonedVehiclesTimer = getNumber(missionConfigFile >> "vehicleUnusedCleanUp");
if(_abandonedVehiclesTimer < 60 AND getNumber(missionConfigFile >> "vehicleUnusedCleanMins") isEqualTo 0)then{
	60 - ((0.6 - parseNumber format ["0.%1",_abandonedVehiclesTimer])  * 100) 
}else{
	(_abandonedVehiclesTimer * 60)
};

private _droppedWeaponsTimer = getNumber(missionConfigFile >> "weaponCleanUp");
if(_droppedWeaponsTimer < 60 AND getNumber(missionConfigFile >> "weaponCleanMins") isEqualTo 0)then{
	60 - ((0.6 - parseNumber format ["0.%1",_droppedWeaponsTimer])  * 100) 
}else{
	(_droppedWeaponsTimer * 60)
};

private _objectsToCleanup = [];
private _timesWhenToCleanup = [];

private _addToCleanup = {
	private _object = _this#0;
	if (!(_object getVariable["persistent",false])) then {
		private _newTime = (_this#1)+time;
		private _index = _objectsToCleanup find _object;
		if (_index isEqualTo -1) then {
			PUSH(_objectsToCleanup,_object)
			PUSH(_timesWhenToCleanup,_newTime)
		} else {
			_currentTime = _timesWhenToCleanup#_index;
			if(_currentTime>_newTime) then {		
				_timesWhenToCleanup set[_index, _newTime];
			}; 
		};			   
	};
};

private _removeFromCleanup = {
	private _object = _this#0;
	private _index = _objectsToCleanup find _object;
	if(_index != -1) then {
		_objectsToCleanup set[_index, 0];
		_timesWhenToCleanup set[_index, 0]; 
	};			   
};

while {true} do {
	uiSleep 10;	
	
	//near items to clean
	{	
	    private _unit = _x;
	    
		//Dropped weapons
		if (_droppedWeaponsTimer > 0) then {
			{
				{ 	 
					[_x, _droppedWeaponsTimer] call _addToCleanup;			
				} forEach (getpos _unit nearObjects [_x, 100]);
			} forEach ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"];
		};

		//active smokes 
		{
			{ 	 
				[_x, 1] call _addToCleanup; 
			} forEach (getpos _unit nearObjects [_x, 100]);
		} forEach ["SmokeShell"];
	} forEach allUnits;
	
	//dead groups
	{
		if ((count units _x) isEqualTo 0) then {
			deleteGroup _x;
		};
	} forEach allGroups;
	
	//dead bodies
	if (_deadBodyTimer>0) then {
		{
			[_x, _deadBodyTimer] call _addToCleanup;
		} forEach allDeadMen;
	};	
	
	//dead vehicles
	if (_deadVehiclesTimer>0) then {		
		{
			if(_x isEqualTo vehicle _x) then { // make sure its vehicle 	 
				[_x, _deadVehiclesTimer] call _addToCleanup;
			}; 
		} forEach (allDead - allDeadMen); // all dead without dead men isEqualTo mostly dead vehicles
	};
	
	//abandoned vehicles
	/*if (_abandonedVehiclesTimer>0) then {		
		{
			if ({alive _x}count crew _x isEqualTo 0) then { 	 
				[_x, _abandonedVehiclesTimer] call _addToCleanup;
			} else {
				[_x] call _removeFromCleanup;
			}; 
		} forEach vehicles;
	};*/


	//cleanup							
	REM(_objectsToCleanup,0)
	REM(_timesWhenToCleanup,0) 
	{        
		if(isNull(_x)) then {
			_objectsToCleanup set[_forEachIndex, 0];
			_timesWhenToCleanup set[_forEachIndex, 0];
		} else {
			if(_timesWhenToCleanup select _forEachIndex < time) then {
				deleteVehicle _x;
				_objectsToCleanup set[_forEachIndex, 0];
				_timesWhenToCleanup set[_forEachIndex, 0];			 	
			};
		};	
	} forEach _objectsToCleanup; 
	REM(_objectsToCleanup,0)
	REM(_timesWhenToCleanup,0) 
};