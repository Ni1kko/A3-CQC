/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	['_input','',['']],
	['_mode',9,[0]]
];

private _result = (format['%1:%2',_mode,_input]) call CQC_fnc_callExtDB;
private _output = _result;

if (((typeName(_result)) isEqualTo "STRING") && !(_result isEqualTo "")) then {
	_output = call compile _result;  
};

_output;

