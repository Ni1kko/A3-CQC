if (call isAdmin) exitwith {};
while { hasInterface } do {
    _lastpos = getPosATL player;
    _c = 0;
    uisleep 60;
    while { (getPosATL player) isEqualTo _lastpos } do {
        _c = _c+1;
		sleep 60;
        switch _c do {
            case 5: {titleText ["AFK kick in 5 min", "PLAIN"];};
            case 8: {titleText ["AFK kick in 2 min", "PLAIN"];};
            case 9: {titleText ["AFK kick in 1 min", "PLAIN"];};
            case 10: {titleText ["Kicked for AFK smh", "PLAIN"]; ("#kick " + profileName) remoteExec ["serverCommand", 2];};            
        };
    };
};