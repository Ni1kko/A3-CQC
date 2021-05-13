params [
	["_mode",0]
];

private _dateTime = systemTimeUTC;
private _dateNow = _dateTime select [0,3];
private _timeNow = _dateTime select [3,2];

reverse _dateNow;

if((_dateNow#1) >= 4 AND (_dateNow#1) <= 10 )then{
	_timeNow set [0,if((_timeNow#0) isEqualTo 23)then{"00"}else{(_timeNow#0)+1}];
};

if((_timeNow#0) <= 9) then{
	_timeNow set [0, format["0%1",_timeNow#0]];
};
if((_timeNow#1) <= 9) then{
	_timeNow set [1, format["0%1",_timeNow#1]];
};

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

_timeNow = _timeNow joinString ":";
_dateNow = _dateNow joinString " ";
    
if(_mode isEqualTo -1)exitWith{parseNumber((_timeNow splitString ":" apply {parseNumber _x}) joinString "")};
if(_mode isEqualTo 1)exitWith{_timeNow};
if(_mode isEqualTo 2)exitWith{_dateNow};
format ["%1 (%2)",_timeNow,_dateNow];