private["_abortButton","_respawnButton","_fieldManual","_escSync","_canUseControls"];
disableSerialization;

_escSync = {
	private["_abortButton","_thread","_syncManager"];
	disableSerialization;
	
	_syncManager = {
		disableSerialization;
		private["_abortButton","_timeStamp"];
		_abortButton = (findDisplay 49) displayCtrl 104;
		_respawnButton = (findDisplay 49) displayCtrl 103; // LHM
		_timeStamp = diag_tickTime + 2;
		
		waitUntil {
			_abortButton ctrlSetText format["Abort available in %1",[(_timeStamp - diag_tickTime),"SS.MS"] call BIS_fnc_secondsToString];
			_abortButton ctrlSetTooltip "To Lobby";
			_abortButton ctrlCommit 0;
			round(_timeStamp - diag_tickTime) <= 0 || isNull (findDisplay 49)
		};
		
		_abortButton ctrlSetText "Abort";
		_abortButton ctrlCommit 0;
	};
	
	_abortButton = (findDisplay 49) displayCtrl 104;
	
	if (_this) then {
		_thread = [] spawn _syncManager;
		waitUntil{scriptDone _thread OR isNull (findDisplay 49)};
		_abortButton ctrlEnable true;
		
	};
};
	
while {true} do {
	waitUntil{!isNull (findDisplay 49)};
	_abortButton = (findDisplay 49) displayCtrl 104;
	_respawnButton = (findDisplay 49) displayCtrl 103;
	_fieldManual = (findDisplay 49) displayCtrl 122;
	
	//Block off our buttons first.
	_abortButton ctrlEnable false;
	_respawnButton ctrlEnable false;
	_fieldManual ctrlEnable false;
	_fieldManual ctrlShow false;
	_respawnButton ctrlSetText "By tyrone & AlecW";
	_abortButton ctrlSetEventHandler ["ButtonClick","[] spawn CQC_fnc_outtro; (findDisplay 49) closeDisplay 2; true"];
	
	private _usebleCtrl = true;
	_usebleCtrl spawn _escSync;
	if(_usebleCtrl) then {
		_respawnButton ctrlEnable false; //Enable the button.
	};
	waitUntil{isNull (findDisplay 49)};
};