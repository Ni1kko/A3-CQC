/*
	File: jstar_repair.sqf
	Author: JSt4r
*/
if ((cursorTarget isKindOf "Car" OR cursorTarget isKindOf "Air") and (player distance cursorTarget < 5)) then {

	["Press [ESC] To Stop"] spawn CQC_fnc_Notification;
	player action ["SwitchWeapon", player, player, 100];
	_RepairValue = 0;
	disableSerialization;
	CQC_var_userBusy = true;

	with uiNamespace do {
		_bar = findDisplay 46 ctrlCreate ["RscProgress", 5]; 
		_bar ctrlSetPosition [0,0,1,0.05]; 
		_bar ctrlCommit 0;
		_bar progressSetPosition 0.5;

		while {true} do {
			_RepairValue = _RepairValue + 0.020;
			_bar progressSetPosition _RepairValue;
			sleep 0.20;
			if(animationState player != "AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown") then {player playMoveNow "AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown"};
			
			if (!alive player) exitWith {ctrlDelete ((findDisplay 46) displayCtrl 5);};
			if (!CQC_var_userBusy) exitWith {ctrlDelete ((findDisplay 46) displayCtrl 5); player switchMove "stop";};
			if (_RepairValue > 0.99) exitWith {
				animRepeat = false;
				player action ["SwitchWeapon", player, player, 100];
				["Vehicle Repaired"] spawn CQC_fnc_Notification;
				titleFadeOut 2;
				cursorTarget setDamage 0;
				player switchMove "stop";
				CQC_var_userBusy = false;
				ctrlDelete ((findDisplay 46) displayCtrl 5);
			};
		};
	};
};



