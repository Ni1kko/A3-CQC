_currentKills = profileNameSpace getVariable "cqc_kills";
_currentDeaths = profileNameSpace getVariable "cqc_death";
_kd = profileNameSpace getVariable "cqc_kda";
_kdCutDecimals = [_kd, 2] call BIS_fnc_cutdecimals;
_notiString = format ["<t size='1' color='#000000' valign='middle' font='EtelkaMonospacePro'>Current overall CQC statistics for %1:<br />Kills: %2 Deaths: %3 K/D Ratio: %4</t>", (name player), _currentKills, _currentDeaths, _kdCutDecimals];
[_notiString, "\A3\Ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa"] spawn CQC_fnc_fancyNotification;