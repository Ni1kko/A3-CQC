/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

if !(call isDonator)exitwith {(findDisplay 46) closeDisplay 2};//bad... open me without perms and get disconected

diag_log "Donator Init started";

systemChat ("Welcome "+profileName+", Thanks for being a donator your support is much appricated");

[] spawn CQC_fnc_donatorAutoReload;
 
diag_log "Donator Init Finished";