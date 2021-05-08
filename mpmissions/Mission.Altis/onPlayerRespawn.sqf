private _defaultLoadout = [[],[],[],["U_C_Poloshirt_tricolour",[]],["V_PlateCarrier2_blk",[]],[],"H_Hat_brown","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
private _customLoadout = profileNamespace getVariable [ "CQC_Custom_Loadout", _defaultLoadout ];
player setUnitLoadout (_customLoadout);

execVM "scripts\jstar_scripts\alecw_heal.sqf";
player switchCamera "EXTERNAL";
alecw_healing = false;
player addRating -1000000; 

if(isNil "CQC_fnc_potatiHud")then{
	[]spawn{
		waitUntil{!isNil "CQC_fnc_potatiHud"};
		[] spawn CQC_fnc_potatiHud;
	};
}else{
	[] spawn CQC_fnc_potatiHud;
};