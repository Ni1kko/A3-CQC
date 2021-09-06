/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

switch (_this) do {
	case 0: {call CQC_fnc_donatorSupCycle;};
	case 1: {call CQC_fnc_donatorESP;};
	case 2: {call CQC_fnc_donatorInfAmmo;};
	case 3: {
		CQC_var_autoReloadActive = !CQC_var_autoReloadActive;
		[format["Auto Reload %1",["Off","On"] select CQC_var_autoReloadActive]] spawn CQC_fnc_Notification;
		closeDialog 0;
	};
	case 4: {call CQC_fnc_donatorMK200;};
};