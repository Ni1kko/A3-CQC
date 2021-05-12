/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/
if(!canSuspend)exitWith{_this spawn CQC_fnc_player_respawned};

private _loginHandle = [] spawn CQC_fnc_playerLogin;
waitUntil {scriptDone _loginHandle};

true