/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

_hours = floor(serverTime / 60 / 60);
_value = ((serverTime / 60 / 60) - _hours);
if(_value == 0)then{_value = 0.0001;};
_minutes = round(_value * 60);
_mytime = format['%1h %2min | ',_hours,_minutes];
_mytime