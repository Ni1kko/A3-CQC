params [
	["_mode",0]
];

private _dateTime = parseSimpleArray("9:LOCAL_TIME" call CQC_fnc_callExtDB )#1;

private _dateNow = _dateTime select [0,3];//[2021,5,16]
private _timeNow = _dateTime select [3,2];//[17,29]

reverse _dateNow; //[16,5,2021]

if((_timeNow#0) <= 9) then{
	_timeNow set [0, format["0%1",_timeNow#0]];
};
if((_timeNow#1) <= 9) then{
	_timeNow set [1, format["0%1",_timeNow#1]];
};

private _hr2min = (_timeNow#0) * 60;
private _min2sec = (_timeNow#1) * 60;
private _time2Secs = ((_hr2min * 60) + _min2sec);
private _amOrPm = (["PM","AM"] select ((_timeNow#0) > 23 AND (_timeNow#0) < 12));

if(_mode isEqualTo -3)exitWith{_dateNow};
if(_mode isEqualTo -2)exitWith{_timeNow};
if(_mode isEqualTo -1)exitWith{_time2Secs};
if(_mode isEqualTo 1)exitWith{_timeNow joinString ":"};
if(_mode isEqualTo 2)exitWith{_dateNow joinString "\"};

_dateNow set [1, switch (_dateNow#1) do {
	case 1: {"Jan"};
	case 2: {"Feb"};
	case 3: {"Mar"};
	case 4: {"April"};
	case 5: {"May"};
	case 6: {"June"};
	case 7: {"July"};
	case 8: {"Aug"};
	case 9: {"Sept"};
	case 10: {"Oct"};
	case 11: {"Nov"};
	case 12: {"Dec"};
}];
format ["%1:%2 %3 (%4\%5\%6)",_timeNow#0,_timeNow#1,_amOrPm,_dateNow#0,_dateNow#1,str(_dateNow#2) select[2,2]];