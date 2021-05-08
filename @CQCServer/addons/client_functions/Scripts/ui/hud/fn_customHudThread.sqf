hudLoop = [] spawn {
	while {true} do {
	uiSleep 0.10;

	_currentHP = round (100 - (damage player) * 100);
	((findDisplay 46) displayCtrl 3) ctrlSetText str _currentHP;
	((findDisplay 46) displayCtrl 2) ctrlSetPosition [safezoneX + (safezoneW * 0.85),safezoneY + (safezoneH * 0.965),(safezoneW * 0.00145) * _currentHP,safezoneH * 0.0235];
	((findDisplay 46) displayCtrl 2) ctrlCommit 0.25;
	};
}; 