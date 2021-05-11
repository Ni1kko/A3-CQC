/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

//Check and toggle `CQC_var_inCombat` if timer changes
[] spawn {while {true} do {waitUntil {CQC_var_inCombat = (round(CQC_var_combatTimer - diag_tickTime) max 0) >= 1; CQC_var_inCombat}}};
while {true} do 
{
	//Combat triggered
	waitUntil {CQC_var_inCombat};
	["You are in combat!"] spawn CQC_fnc_Notification; 


	//Combat Ended
	waitUntil {!CQC_var_inCombat};
	["You are no longer in combat"] spawn CQC_fnc_Notification;
};