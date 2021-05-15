/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_ghost",objNull,[objNull]]
];

_ghost hideObjectGlobal true;
_ghost enableDynamicSimulation false;
_ghost enableSimulationGlobal false;

//get database infomation for character
private _databaseQuery = [_ghost,"C_man_polo_4_F"] call CQC_fnc_sessionInsert;
if((count _databaseQuery) < 1)exitWith{[[],{(findDisplay 46) closeDisplay 2}] remoteExecCall ["spawn",owner _ghost]};

//extract type from database result for character
private _characterType = [_databaseQuery,6,""] call BIS_fnc_param;
if(_characterType isEqualTo "")exitWith{[[],{(findDisplay 46) closeDisplay 2}] remoteExecCall ["spawn",owner _ghost]};

//get position for character
private _characterPosition = getPosATL _ghost;
_characterPosition set [2, 1];

//create new group for character
private _characterGroup = createGroup civilian;
_characterGroup deleteGroupWhenEmpty true;

//create new character
private _character = _characterGroup createUnit [_characterType, [1,1,1], [], 0, "CAN_COLLIDE"];
if(isNull _character)exitWith{[[],{(findDisplay 46) closeDisplay 2}] remoteExecCall ["spawn",owner _ghost]};

//delete group
[_character] joinSilent (grpNull);

//prepare new character
_character hideObjectGlobal true;
_character enableDynamicSimulation true;
_character enableSimulationGlobal true;
_character setDamage 0;
_character allowDamage false;
_character setName (name _ghost);
_character setPos _characterPosition;
_character setDir 356.399;

//finish up on client side
[[_character,_characterPosition,_databaseQuery],{
	params [
		["_character",objNull],
		["_characterPosition",[]], 
		["_databaseQuery",[]]
	];

	_databaseQuery params [
		["_steamIDDB",""],
		["_ProfileNameDB",""],
		["_KnownNamesDB",[]],
		["_GearDB",[]],
		["_AdminRankDB",0],
		["_HasDonatedDB",0],
		["_characterTypeDB",""]
	];
	
	if(!isFinal "isAdmin")then{isAdmin = compileFinal (""+str _AdminRankDB+" > 0")};
	if(!isFinal "isDonator")then{isDonator = compileFinal ("(("+str _HasDonatedDB+" isEqualTo 1) OR (if("+str(getNumber(missionConfigFile >> "adminDonator"))+" isEqualTo 1)then{"+str _AdminRankDB+" >= 2}else{false}))")};
	if(!isFinal "playersWithGodMode")then{playersWithGodMode = compileFinal '((allplayers apply {if(!isDamageAllowed _x AND _x distance2D (markerPos "spawnMarker") > 100)then{[name _x,getPlayerUID _x]}else{["",""]}}) - [["",""]])'};

	CQC_var_clientGear = _GearDB;

	//Enable new player
	selectPlayer _character;
	_character switchCamera "EXTERNAL";
	_character enableFatigue false; 
	_character setCustomAimCoef 0.00;
	_character addRating -1000000; 
	_character setPos _characterPosition;//fucking arma
	character = _character;
}] remoteExec ["spawn",owner _ghost];