/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_steamID","",[""]],
	["_name","",[""]]
];

 
private _ProfileName = [_name] call CQC_fnc_database_nameSafe;
private _getDatabaseQuery = { ["SELECT","SteamID,ProfileName,KnownNames,Gear,AdminRank,HasDonated FROM Clients WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase };
private _databaseQuery = call _getDatabaseQuery;

//Add client too database
private _inserted = false;
private _sessionTries = missionNamespace getVariable [format["CQC_var_%1SessionTries",_steamID],0];
if(count _databaseQuery <= 0 AND _sessionTries <= 25)then{
	while {count _databaseQuery <= 0 AND _sessionTries <= 25} do {
		if !(_inserted)then{
			["INSERT", "Clients (ProfileName,KnownNames,SteamID,Gear) VALUES('"+_ProfileName+"', '"+([_ProfileName]call CQC_fnc_database_mresArray)+"', '"+_steamID+"','""[]""')"] call CQC_fnc_queryDatabase;
			_inserted = true;
		};
		missionNamespace setVariable [format["CQC_var_%1SessionTries",_steamID],_sessionTries+1,true];
		_databaseQuery = call _getDatabaseQuery;
	};
};
missionNamespace setVariable [format["CQC_var_%1SessionTries",_steamID],0,true];

//Failed adding client too database
if(count _databaseQuery < 1)then{
	if(_inserted)then{
		(format["Failed Too Add Client (%1)[%2]",_ProfileName,_steamID]) call CQC_fnc_database_log;
	}else{
		(format["Failed Too Load Client (%1)[%2]",_ProfileName,_steamID]) call CQC_fnc_database_log;
	};
}else{
	//clientdata from database
	_databaseQuery params [
		["_steamIDDB",""],
		["_ProfileNameDB",""],
		["_KnownNamesDB",""],
		["_GearDB",""],
		["_AdminRankDB",0],
		["_HasDonatedDB",0],
		["_characterTypeDB",""]
	];

	//parse data from database
	_KnownNamesDB = [_KnownNamesDB] call CQC_fnc_database_mresToArray;
	_databaseQuery set [2,_KnownNamesDB];

	_GearDB = [_GearDB] call CQC_fnc_database_mresToArray;
	_databaseQuery set [3,_GearDB];

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
};

_databaseQuery