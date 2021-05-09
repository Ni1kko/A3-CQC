/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _allAdmins = (["SELECT", "SteamID FROM Clients WHERE AdminRank > 1",true] call CQC_fnc_queryDatabase) apply {_x#0};

private _curAdmins = uiNamespace getVariable ["CQCAdmins",[]];

if(_allAdmins isNotEqualTo _curAdmins)then
{
	{_x setVariable ["CQCAdmins",_allAdmins]}forEach [missionNamespace,uiNamespace];
	publicVariable "CQCAdmins";
};

true