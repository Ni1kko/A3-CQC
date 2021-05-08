JSTAR_HUD = 
{

	waitUntil {!isNull player};
	waitUntil { alive player };
    if (!local Player) exitWith {};
	

	disableSerialization; 
    ("JSTAR_Layer" call BIS_fnc_rscLayer) cutRsc ["TAG_JSTARHUD","PLAIN"];
	
    _display = uiNamespace getVariable "TAG_JSTAR_display"; 
    _ctrlDir = _display displayCtrl 520500; 
    _ctrlFps = _display displayCtrl 520501;
	_ctrlHps = _display displayCtrl 520502;
	_ctrlSta = _display displayCtrl 520503;
	_ctrlPly = _display displayCtrl 1004;
		
    while {!isNull _display} do {
	
	    sleep 0.1;
        _ctrlHps ctrlSetText format ["%1%2", round((1 - (damage player)) * 100), "%"];
		_ctrlPly ctrlSetText format ["Players nearby: %1", cntPly - (1)];
		
		// Note: Doesn't Work
		switch (true) do {
            case (GetDammage Player < 0.25): {_ctrlHps ctrlSetTextColor [0,0.5,0,1];};
            case (GetDammage Player >= 0.25): {_ctrlHps ctrlSetTextColor [1,1,0,1];};         
            case (GetDammage Player >= 0.5): {_ctrlHps ctrlSetTextColor [1,0.645,0,1];};
            case (GetDammage Player >= 0.75): {_ctrlHps ctrlSetTextColor [1,0,0,1];};		
		};
    };
};