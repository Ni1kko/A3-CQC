/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _defaultLoadout = [[],[],[],["U_C_Poloshirt_tricolour",[]],["V_PlateCarrier2_blk",[]],[],"H_Hat_brown","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
private _customLoadout = profileNamespace getVariable [ "CQC_Custom_Loadout", _defaultLoadout ];
player setUnitLoadout (_customLoadout);

[] spawn CQC_fnc_initActions;
player switchCamera "EXTERNAL";
alecw_healing = false;
player addRating -1000000; 

if(isNil "CQC_fnc_customHudInit")then{
	[]spawn{
		waitUntil{!isNil "CQC_fnc_customHudInit"};
		[] spawn CQC_fnc_customHudInit;
	};
}else{
	[] spawn CQC_fnc_customHudInit;
};