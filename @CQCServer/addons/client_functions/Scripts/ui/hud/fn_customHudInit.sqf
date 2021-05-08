call CQC_fnc_customHudRemove;
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

call CQC_fnc_customHudThread; 