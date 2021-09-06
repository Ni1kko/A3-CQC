/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _admins = missionNamespace getVariable ['CQCAdmins',[]];
private _donators = missionNamespace getVariable ['CQCDonators',[]]; 
private _developers = if(!isNil 'CQC_DEVS')then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
private _colorAdmin = getArray(missionConfigFile >> 'CQCColors' >> 'admin');
private _colorDonator = getArray(missionConfigFile >> 'CQCColors' >> 'donator');
private _colorPlayer = getArray(missionConfigFile >> 'CQCColors' >> 'player');
private _colorDeveloper = getArray(missionConfigFile >> 'CQCColors' >> 'developer');
//private _colorHighlighted = getArray(missionConfigFile >> 'CQCColors' >> 'highlighted');

private _clr = switch (true) do {
    case (_this in _developers): {_colorDeveloper};
    case (_this in _admins): {_colorAdmin};
    case (_this in _donators): {_colorDonator}; 
    default {_colorPlayer};
};

_clr