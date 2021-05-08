CQC_fnc_potatiHud = {

	p_removeCustomHud = {
		showHUD [true, true, true, true ,true, true, true, true];
		//terminate hudLoop;
		{
			ctrlDelete ((findDisplay 46) displayCtrl _x)
		} forEach [1,2,3,4,6,7,8,9,10,11,12,13,14];
	};

	p_hudInit = {
		call p_removeCustomHud;
		uiSleep 2;
		showHUD [true, true, true, true ,true, true, true, true];

		_hpBar = findDisplay 46 ctrlCreate ["RscBackground", 2];
		_hpBar ctrlSetPosition [safezoneX + (safezoneW * 0.85),safezoneY + (safezoneH * 0.965),safezoneW * 0.145,safezoneH * 0.0235];
		_hpBar ctrlSetBackgroundColor [0,0,0,0.5];
		_hpBar ctrlCommit 0;

		_hpValText = findDisplay 46 ctrlCreate ["RscText", 3];
		_hpValText ctrlSetPosition [safezoneX + (safezoneW * 0.9775),safezoneY + (safezoneH * 0.9675),safezoneW * 0.145,safezoneH * 0.0235];
		_hpValText ctrlSetFont "RobotoCondensedLight";
		_hpValText ctrlSetScale 0.85;
		_hpValText ctrlSetText "...";
		_hpValText ctrlCommit 0;

		_healthText = findDisplay 46 ctrlCreate ["RscText", 4];
		_healthText ctrlSetPosition [safezoneX + (safezoneW * 0.85),safezoneY + (safezoneH * 0.9675),safezoneW * 0.145,safezoneH * 0.0235];
		_healthText ctrlSetFont "RobotoCondensedLight";
		_healthText ctrlSetScale 0.85;
		_healthText ctrlSetText "Health";
		_healthText ctrlCommit 0;

		call p_createHudUpdateLoop;
	};

	p_createHudUpdateLoop = {
		hudLoop = [] spawn {
			while {true} do {
			uiSleep 0.10;

			_currentHP = round (100 - (damage player) * 100);
			((findDisplay 46) displayCtrl 3) ctrlSetText str _currentHP;
			((findDisplay 46) displayCtrl 2) ctrlSetPosition [safezoneX + (safezoneW * 0.85),safezoneY + (safezoneH * 0.965),(safezoneW * 0.00145) * _currentHP,safezoneH * 0.0235];
			((findDisplay 46) displayCtrl 2) ctrlCommit 0.25;
			};
		};
	};
	[] spawn p_hudInit;
};