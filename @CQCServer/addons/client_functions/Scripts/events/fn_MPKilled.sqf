private _victim = _this select 0;
private _killer = _this select 1;

if (_killer isEqualTo player) then {
	[] remoteExec ["CQC_fnc_playerAddKill", _killer]
};