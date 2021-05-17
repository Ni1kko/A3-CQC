/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

//Get logs Array
private _logs = uiNamespace getVariable ["CQC_var_ServerFncLogs",[]];

//new log
private _log = format["<CQC Database>: %1",_this];

//add new log too logs array
_logs pushBackUnique _log;

//Update Logs
uiNamespace setVariable ["CQC_var_ServerFncLogs",_logs];

//Print log into .rpt
diag_log _log;