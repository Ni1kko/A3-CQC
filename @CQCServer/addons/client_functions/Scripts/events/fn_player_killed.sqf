_currentdeath = profileNamespace getVariable "cqc_death";
_newdeath = _currentdeath + 1;

profileNameSpace setVariable ["cqc_death", _newdeath];

[] call CQC_fnc_updatePlayerKDA;

if !((vehicle player) isEqualTo player) then
{
	unassignVehicle player; 
	player action ["GetOut", vehicle player]; 
	player action ["Eject", vehicle player];
};
//double checks if player still in a vehicle, happens sometimes in cases like dead vehicles.
if !((vehicle player) isEqualTo player) then { 
	_pX = floor random -5; 
	_pY = floor random -5; 
	_position = vehicle player modelToWorld [_pX,_pY,0]; 
	player setpos _position; 
};