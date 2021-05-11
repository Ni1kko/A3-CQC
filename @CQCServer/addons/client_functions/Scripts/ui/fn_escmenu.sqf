/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

disableSerialization;

private _display = displayNull;
private _escapeTime = getNumber(missionConfigFile >> "escapeTimer");

while {true} do 
{
	//Escape opened 
	waitUntil{_display = findDisplay 49; !isNull _display};

	//Set esacpe time var
	private _timeTillAbort = diag_tickTime + _escapeTime;

	//Get Controls
	private _abortButton = _display displayCtrl 104;
	private _respawnButton = _display displayCtrl 103;
	private _fieldManual = _display displayCtrl 122;

	//Lock Controls until timer has expired   
	waitUntil {
		//Block off buttons.
		_abortButton ctrlEnable false;
		_respawnButton ctrlEnable false;
		_fieldManual ctrlEnable false; 
		
		//Update buttons
		_timeTillAbort = if(CQC_var_inCombat)then{CQC_var_combatTimer}else{_timeTillAbort};//tweat esacpe time var if in combat
		_abortButton ctrlSetText format["Abort available in %1",[(_timeTillAbort - diag_tickTime),"SS.MS"] call BIS_fnc_secondsToString];//show time on abort button
		_abortButton ctrlCommit 0;

		//Can we break out?
		round(_timeTillAbort - diag_tickTime) <= 0 || isNull _display
	};

	//Unlock Controls
	if(!isNull _abortButton)then{
		_abortButton ctrlSetText "Abort";
		_abortButton ctrlSetTooltip "Leave CQC Sever";
		_abortButton ctrlSetEventHandler ["ButtonClick","[] spawn CQC_fnc_outtro; (findDisplay 49) closeDisplay 2; true"];
		_abortButton ctrlCommit 2.5;
		_abortButton ctrlEnable true;
	};

	//Escape closed
	waitUntil{isNull _display};
};