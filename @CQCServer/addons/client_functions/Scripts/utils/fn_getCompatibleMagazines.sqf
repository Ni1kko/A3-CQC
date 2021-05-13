/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
	["_weaponClass",currentWeapon player,[""]]
];

private _compatible = []; 
private _weaponCfg = configFile >> "CfgWeapons" >> _weaponClass;

{
	private _magazines = if (_x isEqualTo "this") then {
		getArray(_weaponCfg >> "magazines")
	} else {
		getArray(_weaponCfg >> _x >> "magazines")
	};
	{_compatible pushBackUnique _x}forEach _magazines;
} forEach getArray (_weaponCfg >> "muzzles");  

_compatible  