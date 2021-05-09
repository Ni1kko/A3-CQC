/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	['_steamid','',['']],
	['_ProfileName','',['']],
	['_didJip',false,[false]],
	['_ownerID',2,[0]],
    ["_clientData",[[],false],[[]]],
	['_isLiveServer',true,[false]]
];
 
//Players only
if (_ownerID < ([3,2] select is3DENMultiplayer)) exitWith {false};


//Check Profilename for bad chars
_ProfileName = [_ProfileName] call CQC_fnc_database_nameSafe;

//Check if in database
private _databaseQuery = ["SELECT","SteamID,ProfileName,KnownNames,Gear,AdminRank,HasDonated FROM Clients WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase;

//Add client too database
private _databaseError = false;
if(count _databaseQuery < 1)then{
	["INSERT", "Clients (ProfileName,KnownNames,SteamID,Gear) VALUES('"+_ProfileName+"', '"+([_ProfileName]call CQC_fnc_database_mresArray)+"', '"+_steamID+"','""[]""')"] call CQC_fnc_queryDatabase;
 	_databaseQuery = ["SELECT", "SteamID,ProfileName,KnownNames,Gear,AdminRank,HasDonated FROM Clients WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase;
	_databaseError = (count _databaseQuery < 1);
};

//Failed adding client too database
if(_databaseError)exitWith{
	(format["Failed Too Add Client (%1)[%2]",_ProfileName,_steamID]) call CQC_fnc_database_log;
};

(format["(%1)[%2] Data Loaded",_ProfileName,_steamID]) call CQC_fnc_database_log;

//clientdata from database
_databaseQuery params [
	["_steamIDDB",""],
	["_ProfileNameDB",""],
	["_KnownNamesDB",""],
	["_GearDB",""],
	["_AdminRankDB",0],
	["_HasDonatedDB",0]
];

//parse data from database
_KnownNamesDB = [_KnownNamesDB] call CQC_fnc_database_mresToArray;
_GearDB = [_GearDB] call CQC_fnc_database_mresToArray;

//Update name
if( not(_ProfileName isEqualTo _ProfileNameDB))then{
	_ProfileNameDB = _ProfileName;
	["UPDATE", "Clients SET ProfileName='"+_ProfileNameDB+"' WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase; 
};

//Update known names
if( not(_ProfileName in _KnownNamesDB))then{
	_KnownNamesDB pushBackUnique _ProfileName;
	["UPDATE", "Clients SET KnownNames='"+([_KnownNamesDB]call CQC_fnc_database_mresArray)+"' WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase; 
};
 
//Send client preinit (DONT EDIT)
[[_clientData,[
	
	_steamIDDB,
	_ProfileNameDB,
	_GearDB,
	_AdminRankDB,
	_HasDonatedDB
]],{
	params [
		["_clientData",[[],false]],
		"_databaseData"
	];

	//Db Error... goodbye!	
	if(isNil "_databaseData")exitwith{
		(findDisplay 46) closeDisplay 2;
	};

	//initFunctions
	{ 
		missionNamespace setVariable [_x#0, ([compile (_x#1),compileFinal(_x#1)]select(_clientData#1))];
		waitUntil{!isNil {missionNamespace getVariable (_x#0)}};
	} forEach (_clientData#0);

	//initClient
	_databaseData spawn CQC_fnc_initclient;
}] remoteExec ["spawn",_ownerID];

//Return
true
