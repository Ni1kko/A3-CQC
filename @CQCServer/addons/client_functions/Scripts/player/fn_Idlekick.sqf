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
private _diff = 0;

while {true} do { 
    uiSleep 90;

    waitUntil 
    {
        uiSleep 1;

        _diff = round(CQC_var_lastKeyPress - (-1 call CQC_fnc_getTimeDate)) max 0;

        if(_diff mod 2 isEqualTo 0)then{
            if(_diff isEqualTo 0)then{
                [format ["Idle kick in 60 seconds",_diff]] spawn CQC_fnc_Notification;
            }else{
                [format ["Idle kick in %1 min",_diff]] spawn CQC_fnc_Notification;
            };
            uiSleep 60;
        }; 
        
        _diff isEqualTo 0 || _diff isEqualTo _timer 
    };

    if(_diff isEqualTo 0)then{
        _display closeDisplay 2;
    }else{
        [format ["Idle kick aborted",_diff]] spawn CQC_fnc_Notification; 
        waitUntil 
        {
            uiSleep 1;
            _diff = round(CQC_var_lastKeyPress - (-1 call CQC_fnc_getTimeDate)) max 0;
            _diff isNotEqualTo _timer
        };
    };
};