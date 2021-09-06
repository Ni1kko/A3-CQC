/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

waitUntil {!isNull player};
waitUntil {alive player};
if (!isPlayer player) exitWith {};

disableSerialization; 
private _resource = "CQC_Rsc_PlayerHUD";
(_resource call BIS_fnc_rscLayer) cutRsc [_resource,"PLAIN"];

_display = uiNamespace getVariable _resource;
_ctrlDir = _display displayCtrl 520500; 
_ctrlFps = _display displayCtrl 520501;
_ctrlHps = _display displayCtrl 520502;
_ctrlSta = _display displayCtrl 520503;
_ctrlPly = _display displayCtrl 1004;
    
while {!isNull _display} do {

    sleep 0.1;
    _ctrlHps ctrlSetText format ["%1%2", round((1 - (damage player)) * 100), "%"];
    _ctrlPly ctrlSetText format ["Players nearby: %1", {_x distance player < 500} count (allPlayers - [player])];
    
    // Note: Doesn't Work
    switch (true) do {
        case (GetDammage player < 0.25): {_ctrlHps ctrlSetTextColor [0,0.5,0,1];};
        case (GetDammage player >= 0.25): {_ctrlHps ctrlSetTextColor [1,1,0,1];};         
        case (GetDammage player >= 0.5): {_ctrlHps ctrlSetTextColor [1,0.645,0,1];};
        case (GetDammage player >= 0.75): {_ctrlHps ctrlSetTextColor [1,0,0,1];};		
    };
};
