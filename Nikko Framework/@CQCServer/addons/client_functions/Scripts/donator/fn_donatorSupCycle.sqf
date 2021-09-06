/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _weapon = currentWeapon player;
private _class = (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
private _sups = _class call CQC_fnc_compatibleItems;

if (isNil "CQC_Sup_Index") then {
	CQC_Sup_Index = 0;
	CQC_Sup_Wep = _weapon;
};

if (CQC_Sup_Wep != _weapon) then {
	CQC_Sup_Wep = _weapon;
	CQC_Sup_Index = 0;
} else {
	CQC_Sup_Index = CQC_Sup_Index + 1;
	if (CQC_Sup_Index > (count _sups)-1) then {
		CQC_Sup_Index = 0;
	};
};

player addWeaponItem [_weapon, _sups select CQC_Sup_Index];
["Cycled suppressor, have fun with your suppressor dog"] spawn CQC_fnc_Notification;