/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _anthingStopped = false;

if (CQC_var_userBusy) then {_anthingStopped = true;CQC_var_userBusy = false; ["Repair Stopped"] spawn CQC_fnc_Notification;};
if (CQC_var_isHealing) then {_anthingStopped = true;CQC_var_isHealing = false; ["Healing stopped"] spawn CQC_fnc_Notification;};

if(_anthingStopped)then{
    for "_i" from 0 to 2 do {closeDialog _i}; 
};

_anthingStopped