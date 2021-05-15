/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/
if(hasInterface)exitwith{_this remoteExecCall ["CQC_fnc_ahLog",2]};

params['_logname','_logentry'];
diag_log format['<CQC AntiHack>%1| %2   [v0.0.4]',_logname,_logentry];