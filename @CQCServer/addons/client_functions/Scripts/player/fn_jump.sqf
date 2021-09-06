/*
    Name: fn_jump.sqf
    Author: Maihym & Nikko
    Description: Makes the player jump.

    Parameters:
    NONE
*/

if ((animationState player isEqualTo "AovrPercMrunSrasWrflDf") || !(isTouchingGround player) || !(stance player isEqualTo "STAND") || !(speed player > 2) || {((velocity player) select 2) > 2.5} || {time - (player getVariable ["CQC_var_jumpActionTime",0]) < 2.5}) exitWith {};

player setVariable ["CQC_var_jumpActionTime",time];

_oldpos = getPosATL player;  
_v1 = 3.82;
_v2 = .4;
_dir = direction player;
_vel = velocity player;
player setVelocity[(_vel select 0)+(sin _dir*_v2),(_vel select 1)+(cos _dir*_v2),(_vel select 2)+_v1];

[player, "AovrPercMrunSrasWrflDf"] remoteExec ["switchMove", 0];

[player,_oldpos] spawn {
    waitUntil {
        if ((getPos (_this#0) select 2) > 4) then {
            _this#0 setposATL _this#1;
            _this#0 setVelocity [0, 0, 0];
        };
        animationState (_this#0) != "AovrPercMrunSrasWrflDf";
    };
};