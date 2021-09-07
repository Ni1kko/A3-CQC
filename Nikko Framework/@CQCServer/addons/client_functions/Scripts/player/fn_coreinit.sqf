diag_log text ""; 
diag_log text format["|=============================   %1   =============================|", missionName]; // stamp mission name
diag_log text "";

[] spawn {
	private ["_paramName", "_paramValue", "_i"];

	// Workaround for bug 24051 - Disable time of day settings.
	nightOrDay = 0;
	NightvisionParam = 1;
	[] call CQC_fnc_setDate;
	waitUntil {!isNil "paramsArray"};

	for [{_i = 0}, {_i < count paramsArray}, {_i = _i +1 }] do
	{
		_paramName =(configName ((missionConfigFile >> "Params") select _i));
		_paramValue = (paramsArray select _i);
		missionNameSpace setVariable [_paramName, _paramValue];
	};

	timeLimit = timeLimit * 60;

	all_crates = [];

	// TacBF Workarounds.
	ICE_fnc_gear_adjustMaxKitsAllowed = {0};

	preInitDone = true;
};