/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [ 
	["_display",displayNull,[displayNull]]
];

if (getNumber(missionConfigFile >> "AFKKicker") isEqualTo 0) exitwith {};
if ((call isAdmin) AND getNumber(missionConfigFile >> "AFKAdminBypass") isEqualTo 1) exitwith {};

private _timer = getNumber(missionConfigFile >> "AFKKickTime");
private _notify = getNumber(missionConfigFile >> "AFKKickTimeNotify");
private _diff = 0;

while {true} do { 
    waitUntil 
    {
        uiSleep 1;

        _diff = round(((CQC_var_lastKeyPress - serverTime)  max 0) / 60);

        if(_diff mod _notify isEqualTo 0)then{
            if(_diff isEqualTo 0)then{
                ["Idle kick in 60 seconds"] spawn CQC_fnc_Notification;
            }else{
                [format ["Idle kick in %1 min",_diff]] spawn CQC_fnc_Notification;
            };
            uiSleep 60;
        };
        
        _diff isEqualTo 0 || _diff isEqualTo _timer 
    };

    if(_diff isEqualTo 0)then{
        profileNameSpace setVariable ["CQC_idleKicked",true];
        saveprofileNameSpace;
        _display closeDisplay 2;
    }else{
        [format ["Idle kick aborted",_diff]] spawn CQC_fnc_Notification; 
        waitUntil 
        {
            uiSleep 1;
            _diff = round(((CQC_var_lastKeyPress - serverTime)  max 0) / 60);
            _diff isNotEqualTo _timer
        };
    };
};