/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _allDonators = (["SELECT", "SteamID FROM Clients WHERE HasDonated = '1'",true] call CQC_fnc_queryDatabase) apply {_x#0};

private _curDonators = uiNamespace getVariable ["CQCDonators",[]];

if(_allDonators isNotEqualTo _curDonators)then
{
	{_x setVariable ["CQCDonators",_allDonators]}forEach [missionNamespace,uiNamespace];
	publicVariable "CQCDonators";
};

true