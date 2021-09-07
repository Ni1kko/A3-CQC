/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

//Args
if (_this params [
	["_id",-100],			    // Number - is the unique DirectPlay ID. Quite useless as the number is too big for in-built string representation and gets rounded. It is also the same id used for user placed markers.
	["_steamID","",[""]],		// String - is getPlayerUID of the joining player. In Arma 3 it is also the same as Steam ID.
	["_ProfileName","",[""]],	// String - is profileName of the joining player.
	["_didJip",false,[false]], 	// Boolean - is a flag that indicates whether or not the player joined after the mission has started (Joined In Progress). true when the player is JIP, otherwise false. (since Arma 3 v1.49)
	["_ownerID",-100,[0]],		// Number - is owner id of the joining player. Can be used for kick or ban purposes or just for publicVariableClient. (since Arma 3 v1.49) 
	["_idstr",""]			    // String - same as _id but in string format, so could be exactly compared to user marker ids. (since Arma 3 v1.95) 
] isEqualTo false) exitWith {false};

//Players only
if (_ownerID < ([3,2] select is3DENMultiplayer)) exitWith {false};
if (_steamID isEqualTo "")exitWith{};

//get database infomation for character
private _databaseQuery = [_steamID,_ProfileName] call CQC_fnc_sessionInsert;
if((count _databaseQuery) < 1)exitWith{
	diag_log "Player kicked off db data error";
	[[],{(findDisplay 46) closeDisplay 2}] remoteExecCall ["spawn",owner _ghost]
};

//Send client preinit (DONT EDIT)
[(_thisArgs + [_databaseQuery]),{
	params [
		["_functions",[]],
		["_final",false],
		["_databaseQuery",[]]
	];

	_databaseQuery params [
		["_steamIDDB",""],
		["_ProfileNameDB",""],
		["_KnownNamesDB",[]],
		["_GearDB",[]],
		["_AdminRankDB",0],
		["_HasDonatedDB",0]
	];

	if(!isFinal "isAdmin")then{isAdmin = compileFinal (""+str _AdminRankDB+" > 0")};
	if(!isFinal "isDonator")then{isDonator = compileFinal ("(("+str _HasDonatedDB+" isEqualTo 1) OR (if("+str(getNumber(missionConfigFile >> "adminDonator"))+" isEqualTo 1)then{"+str _AdminRankDB+" >= 2}else{false}))")};
	if(!isFinal "playersWithGodMode")then{playersWithGodMode = compileFinal '((allplayers apply {if(!isDamageAllowed _x AND _x distance2D (markerPos "spawnMarker") > 100)then{[name _x,getPlayerUID _x]}else{["",""]}}) - [["",""]])'};

	CQC_var_clientGear = _GearDB; 

	//initFunctions
	{
		missionNamespace setVariable [_x#0,[compile(_x#1), compileFinal(_x#1)] select _final];
		waitUntil{!isNil {missionNamespace getVariable (_x#0)}};
	} forEach _functions;

	//initClient
	private _display = displayNull;
	waitUntil {uiSleep 1; _display = findDisplay 46; !isNull _display};
	[_display] spawn CQC_fnc_initclient;
}] remoteExec ["spawn",_ownerID];

//Return
true
