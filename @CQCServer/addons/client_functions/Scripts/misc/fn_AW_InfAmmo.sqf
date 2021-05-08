AW_IA = !(missionNamespace getVariable ["AW_IA",false]);
if (AW_IA) then {
	player addEventHandler ["Fired", {(_this select 0) setAmmo [primaryWeapon player, 200]}];
	["Infinite ammo On"] spawn CQC_fnc_Notification;
	closeDialog 0;
} else {
	player removeEventHandler ["Fired",0];
	["Infinite ammo Off"] spawn CQC_fnc_Notification;
	closeDialog 0;
};