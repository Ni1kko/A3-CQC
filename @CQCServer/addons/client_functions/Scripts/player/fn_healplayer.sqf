/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

if !(alive player) exitwith {};

["Press ESC to stop"] call CQC_fnc_Notification;
_healValue = 0;
disableSerialization;
CQC_var_isHealing = true;

private _stance = stance player;

switch (_stance) do {
	case "STAND": {player playActionNow "PlayerCrouch"; player playMoveNow "AinvPknlMstpSrasWrflDnon";};
	case "CROUCH": {player playMoveNow "AinvPknlMstpSrasWrflDnon";};
	case "PRONE": {player playMoveNow "AinvPpneMstpSrasWrflDnon";};
};

with uiNamespace do {
	_bar = findDisplay 46 ctrlCreate ["CQC_Rsc_DisplayProgress", 5]; 
	_bar ctrlSetPosition [0.1,1.2,0.7,0.04]; 
	_bar ctrlCommit 0;
	_bar progressSetPosition 0.5;
	
	private _i = 0; 
	for [{ _i = 0}, {_i < 100}, {_i = _i + 1}] do {
	_healValue = _healValue + 0.030;
	_bar progressSetPosition _healValue;
	uiSleep 0.1;
	
	switch (_stance) do {
		case "STAND": {player playAction "PlayerCrouch"; player playMoveNow "AinvPknlMstpSrasWrflDnon";};
		case "CROUCH": {player playMoveNow "AinvPknlMstpSrasWrflDnon";};
		case "PRONE": {player playMoveNow "AinvPpneMstpSrasWrflDnon";};
	};
	
	if(!alive player) exitWith{		ctrlDelete ((findDisplay 46) displayCtrl 5);};
	if((!CQC_var_isHealing) && (_stance == "STAND")) exitWith{ctrlDelete ((findDisplay 46) displayCtrl 5); player switchMove "AinvPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon"; ["1"] call JSt4r_fnc_notification_system;};		
	if((!CQC_var_isHealing) && (_stance == "CROUCH")) exitWith{ctrlDelete ((findDisplay 46) displayCtrl 5); player switchMove "AinvPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon"; ["2"] call JSt4r_fnc_notification_system;};
	if((!CQC_var_isHealing) && (_stance == "PRONE")) exitWith{ctrlDelete ((findDisplay 46) displayCtrl 5); player switchMove "AinvPpneMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"; ["3"] call JSt4r_fnc_notification_system;};

	if (_healValue > 0.99) exitWith{
		["Player healed"] call CQC_fnc_Notification;
		titleFadeOut 2;
		player setDamage 0;
		if (_stance == "STAND") then {player switchMove "AinvPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";};
		if (_stance == "CROUCH") then {player switchMove "AinvPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";};
		if (_stance == "PRONE") then {player switchMove "AinvPpneMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";};
		CQC_var_isHealing = false;
		ctrlDelete ((findDisplay 46) displayCtrl 5);
		closeDialog 7612;
		};
	};
	uiSleep 3;
};