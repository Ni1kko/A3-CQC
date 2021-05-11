/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

CQC_var_infiniteAmmoActive = !(missionNamespace getVariable ["CQC_var_infiniteAmmoActive",false]);

if (CQC_var_infiniteAmmoActive) then {
	player addEventHandler ["Fired", {(_this select 0) setAmmo [primaryWeapon player, 200]}];
	["Infinite ammo On"] spawn CQC_fnc_Notification;
	closeDialog 0;
} else {
	player removeEventHandler ["Fired",0];
	["Infinite ammo Off"] spawn CQC_fnc_Notification;
	closeDialog 0;
};