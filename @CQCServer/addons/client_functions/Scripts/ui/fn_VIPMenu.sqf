if (isNull (findDisplay 163)) then {
	disableserialization;
	createDialog "RscDisplayControlSchemes";

	// Title
	_ctrl = (findDisplay 163) displayctrl 1000;
	_ctrl ctrlSetText "VIP Menu";
	_ctrl ctrlSetFont "RobotoCondensed";
	_ctrl ctrlCommit 0;
	
	// Exit Menu Button
	_ctrl = (findDisplay 163) displayctrl 1;
	_ctrl buttonSetAction "closeDialog 2;";
	_ctrl ctrlSetFont "RobotoCondensed";
	_ctrl ctrlSetText "Exit";
	_ctrl ctrlCommit 0;
	
	// Save Gear Button
	_ctrl = (findDisplay 163) displayctrl 2;
	_ctrl buttonSetAction "[] call CQC_fnc_donatorSaveGear";
	_ctrl ctrlSetFont "RobotoCondensed";
	_ctrl ctrlSetText "Save Gear";
	_ctrl ctrlCommit 0;
	
	// All the buttons for the list box
	_ctrl = (findDisplay 163) displayctrl 101;
	_ctrl ctrlSetFont "RobotoCondensed";
	_ctrl ctrlAddEventHandler ["LBDblClick", { ( _this select 1 ) call CQC_fnc_VIPMenu_DBLClick } ];

	// Cycle Suppressors (Case 0)
	_ctrl lbAdd "Cycle available suppressors";

	// Toggle ESP (Case 1)
	_ctrl lbAdd "Toggle ESP";
	if ( CQC_var_donatorESPActive ) then {
		_ctrl lbSetColor [1, [0.259,0.961,0.596,1]];
		_ctrl lbSetText [1, "Toggle ESP [Active]"];
	} else {
		_ctrl lbSetColor [1, [1,1,1,1]];
		_ctrl lbSetText [1, "Toggle ESP"];
	};

	// Infinite Ammo (Case 2)
	_ctrl lbAdd "Infinite ammo";
	if (CQC_var_infiniteAmmoActive) then {
		_ctrl lbSetColor [2, [0.259,0.961,0.596,1]];
		_ctrl lbSetText [2, "Infinite Ammo [Active]"];
	} else {
		_ctrl lbSetColor [2, [1,1,1,1]];
		_ctrl lbSetText [2, "Infinite Ammo"];
	};

	// Auto Reload (Case 3)
	_ctrl lbAdd "Auto Reload";
	if (CQC_var_autoReloadActive) then {
		_ctrl lbSetColor [3, [0.259,0.961,0.596,1]];
		_ctrl lbSetText [3, "Auto Reload [Active]"];
	} else {
		_ctrl lbSetColor [3, [1,1,1,1]];
		_ctrl lbSetText [3, "Auto Reload"];
	};
	
	// Spawn Mk200 (Case 4)
	_ctrl lbAdd "Get Mk200";
};