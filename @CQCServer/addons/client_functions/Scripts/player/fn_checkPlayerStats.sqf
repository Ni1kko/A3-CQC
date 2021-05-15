/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/ 

[
	format [ 
		"<t size='1' color='#000000' valign='middle' font='EtelkaMonospacePro'>CQC statistics for %1<br />Kills: %2 Deaths: %3 K/D Ratio: %4</t>",  
		(name player),  
		str(profileNameSpace getVariable ["cqc_kills",0]),  
		profileNameSpace getVariable ["cqc_death",0],  
		([profileNameSpace getVariable ["cqc_kda",0], 2] call BIS_fnc_cutdecimals) 
	], 
	"\A3\Ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa"
] spawn CQC_fnc_fancyNotification;