/*
	Nikko Renolds
	Attack & Defend
	Ni1kko@outlook.com
*/
if(!canSuspend) exitWith {
	[] spawn (missionNamespace getVariable ["AutoCompile_fnc_preInit",{diag_log "Functions Auto compile: fn_preInit.sqf Not Found!";false}]);
	false
};

//Get config values
private _config = configFile >> "CfgFunctions" >> "AutoCompile" >> "CfgBootstrap";
private _scriptPrefix = [_config, "tag", ""] call BIS_fnc_returnConfigEntry;
private _addonPrefix = [[_config, "file", ""] call BIS_fnc_returnConfigEntry,1] call BIS_fnc_trimString;
private _clientAddonPrefix = [[_config, "fileClient", ""] call BIS_fnc_returnConfigEntry,1] call BIS_fnc_trimString;
private _dontCompile = ([_config, "dontCompile", []] call BIS_fnc_returnConfigEntry) apply {toLower format["%1_fnc_%2",_scriptPrefix,_x]};
private _compileFinal = ([_config, "compileFinal", 1] call BIS_fnc_returnConfigEntry) isEqualTo 1;

//Already compiled as 'AutoCompile_fnc_preinit' & 'AutoCompile_fnc_postinit'
{_dontCompile pushBackUnique tolower format["%_fnc_%2",_scriptPrefix,_x]} forEach ["preinit","postinit"];

private _isLiveServer = (!("Dev" in servername) || !_compileFinal);
private _serverCommandPass = "ggfhryy3$$";

try {
	//Lock server at start 
	if (_isLiveServer AND !(_serverCommandPass serverCommand "#lock")) throw "Error: Server Command Password INCORECT!";

	private _clientFunctions = []; 

	//Prepare (SERVER)
	{
		if(["\fn_",_x] call BIS_fnc_inString) then {
			private _file = _x select [(_x find "fn_")];
			private _function = format["%1_fnc_%2",_scriptPrefix,_file select [3,(_file find ".sqf") - 3]];
			if( not(toLower _function in _dontCompile) AND not(isFinal _function))then{
				missionNamespace setVariable [_function, ([compile (preprocessFile _x),compileFinal (preprocessFile _x)] select _compileFinal)];
			};
		};
	} forEach (addonFiles [format["%1\",_addonPrefix], ".sqf"]);
	
	//Prepare (CLIENT)
	{
		if(["\fn_",_x] call BIS_fnc_inString) then {
			private _file = _x select [(_x find "fn_")];
			private _function = format["%1_fnc_%2",_scriptPrefix,_file select [3,(_file find ".sqf") - 3]];
			if( not(toLower _function in _dontCompile) AND not(isFinal _function))then{
				_clientFunctions pushBackUnique [_function,(preprocessFile _x)];
			};
		};
	} forEach (addonFiles [format["%1\",_clientAddonPrefix], ".sqf"]);

	//Initialize Server
	[[_clientFunctions,_compileFinal],_serverCommandPass,_isLiveServer] spawn (missionNamespace getVariable [format["%1_fnc_initServer",_scriptPrefix],{}]);
} catch {
	diag_log format["!! FATIAL ERROR !! Server Halted!!! Due To (%1)", _exception];//Log exception
	if _isLiveServer then{_serverCommandPass serverCommand "#shutdown"};//Server shutdown
};

true