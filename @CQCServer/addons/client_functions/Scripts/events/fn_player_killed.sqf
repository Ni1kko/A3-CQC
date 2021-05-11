/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [ "_victim", "_killer" ]; 

//A mess needs looked at
private _currentdeath = profileNamespace getVariable "cqc_death";
private _newdeath = _currentdeath + 1;
profileNameSpace setVariable ["cqc_death", _newdeath];
[] call CQC_fnc_updatePlayerKDA;
if ((_victim isNotEqualTo _killer) AND isPlayer _killer) then {
	[] remoteExec ["CQC_fnc_playerAddKill", owner _killer];
};

if(!CQC_var_inSpawnArea)then{
	CQC_var_combatTimer = diag_tickTime + (getNumber(missionConfigFile >> "combatTimer") / 2);
};

//Remove from vehicle
if !((vehicle _victim) isEqualTo _victim) then
{
	unassignVehicle _victim; 
	_victim action ["GetOut", vehicle _victim]; 
	_victim action ["Eject", vehicle _victim];
};

//double checks if player still in a vehicle, happens sometimes in cases like dead vehicles.
if !((vehicle _victim) isEqualTo _victim) then { 
	_pX = floor random -5; 
	_pY = floor random -5; 
	_position = vehicle _victim modelToWorld [_pX,_pY,0]; 
	_victim setpos _position; 
};