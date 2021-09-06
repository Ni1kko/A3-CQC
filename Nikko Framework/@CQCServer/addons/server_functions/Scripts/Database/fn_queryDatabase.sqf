/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params[
	['_type','',['']],
	['_queryStmt','',['']],
	['_multiarr',false,[false]]
];  

_type = toLower(_type);  
if(_type isEqualTo 'insert')then{
	_queryStmt = ((toUpper(_type)) + (toString([32])) + ('INTO') + (toString([32])) + (_queryStmt));
}else{
	_queryStmt = ((toUpper(_type)) + (toString([32])) + (_queryStmt));
};

//Get index
private _index = uiNamespace getVariable ["CQC_var_DBqueryindex",0];

//new index
_index = _index + 1;
 
//Update Logs
uiNamespace setVariable ["CQC_var_DBqueryindex",_index];

(format["Query #%1 [%2]",_index, _queryStmt]) call CQC_fnc_database_log;

private _key = ('extDB3' callExtension (format['%1:%2:%3',(if(_type isEqualTo 'select')then{2}else{1}),(call(uiNamespace getVariable 'CQC_var_DBprotocolID')),_queryStmt]));  
if !(_type isEqualTo 'select') exitWith {true};
_key = call compile format ['%1',_key];
_key = (_key select 1);
_queryResult =  ('extDB3' callExtension (format['4:%1', _key]));  

if (_queryResult isEqualTo '[3]') then {
	for '_i' from 0 to 1 step 0 do {
		if (!(_queryResult isEqualTo '[3]')) exitWith {};
		_queryResult =  ('extDB3' callExtension (format ['4:%1', _key]));
	};
};

if (_queryResult isEqualTo '[5]') then {
	_loop = true;
	for '_i' from 0 to 1 step 0 do {  
		_queryResult = '';
		for '_i' from 0 to 1 step 0 do {
			_pipe =  ('extDB3' callExtension (format ['5:%1', _key]));
			if (_pipe isEqualTo '') exitWith {_loop = false};
			_queryResult = _queryResult + _pipe;
		};
	if (!_loop) exitWith {};
	};
};
_queryResult = call compile _queryResult;
if ((_queryResult select 0) isEqualTo 0) exitWith {diag_log format ['extDB3: Protocol Error: %1', _queryResult]; []};
_return = (_queryResult select 1);
if (!_multiarr && count _return > 0) then {
	_return = (_return select 0);
};

(format["Query #%1 %2",_index, _return]) call CQC_fnc_database_log;

_return;
/*TEST CODE
	
	//Raw with ID
    ["043711434:SELECT SteamID, ProfileName FROM Clients WHERE SteamID='76561198276956558'",2] call CQC_fnc_callDatabase;

	//Querys
    ["SELECT", "SteamID, ProfileName FROM Clients WHERE SteamID='76561198276956558'"] call CQC_fnc_queryDatabase;
    ["UPDATE", "Clients SET ProfileName='Test' WHERE SteamID='76561198276956558'"] call CQC_fnc_queryDatabase; 
    ["INSERT", "Clients (ProfileName,KnownNames,SteamID,Gear,Money) VALUES('Test', '""[]""', '76561198276956558','""[]""','50000')"] call CQC_fnc_queryDatabase;
    ["CALL",   "deleteOldGangs"] call CQC_fnc_queryDatabase; 


    //number conversion from a2net->extdb
    _tmp =(["SELECT", "SteamID, ProfileName, Money FROM Clients WHERE SteamID='76561198276956558'"] call CQC_fnc_queryDatabase)#2;              
    [_tmp] call CQC_fnc_database_numberSafe;
*/