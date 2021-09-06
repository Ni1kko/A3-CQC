/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _admins = missionNamespace getVariable ["CQCAdmins",[]];
private _donators = missionNamespace getVariable ["CQCDonators",[]];
private _developers = if(!isNil "CQC_DEVS")then{CQC_DEVS}else{getArray(missionConfigFile >> 'enableDebugConsole')};
  
private _rank = switch (true) do {
	case (_this in _developers): {'Developer'};
	case (_this in _admins): {'Admin'};
	case (_this in _donators): {'VIP Player'};
	default {'Player'};
};

_rank