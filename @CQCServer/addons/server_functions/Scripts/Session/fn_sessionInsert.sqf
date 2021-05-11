/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params ["_steamID"];

private _databaseQuery = ["SELECT","SteamID,ProfileName,KnownNames,Gear,AdminRank,HasDonated FROM Clients WHERE SteamID='"+_steamID+"'"] call CQC_fnc_queryDatabase;
private _sessionTries = missionNamespace getVariable [format["CQC_var_%1SessionTries",_steamID],0];
private _inserted = false;

//Add client too database
while {count _databaseQuery <= 0 AND _sessionTries <= 25} do {
	if !(_inserted)then{
		["INSERT", "Clients (ProfileName,KnownNames,SteamID,Gear) VALUES('"+_ProfileName+"', '"+([_ProfileName]call CQC_fnc_database_mresArray)+"', '"+_steamID+"','""[]""')"] call CQC_fnc_queryDatabase;
		_inserted = true;
	};
	missionNamespace setVariable [format["CQC_var_%1SessionTries",_steamID],_sessionTries+1,true];
	_databaseQuery = [_steamID,true] call CQC_fnc_sessionInsert;
};

_databaseQuery