/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

{ if ( _x in primaryWeaponMagazine player ) then { player removeMagazine _x } } forEach magazines player;

player addWeapon "LMG_Mk200_F";
player addPrimaryWeaponItem "optic_Arco";
player addPrimaryWeaponItem "acc_flashlight";
player addPrimaryWeaponItem "bipod_01_F_snd";
player addPrimaryWeaponItem "muzzle_snds_H_MG_blk_F";
player addWeaponItem [currentWeapon player,["200Rnd_65x39_cased_Box_Tracer",200]];

for "_i" from 0 to (15 - 1) do {player addMagazine "200Rnd_65x39_cased_Box_Tracer",200};

["Mk200 equipped"] spawn CQC_fnc_Notification;