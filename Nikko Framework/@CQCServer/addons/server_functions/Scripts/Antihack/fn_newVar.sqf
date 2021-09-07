/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/
params [['_variN',''],['_log',true]];

private _newCharacter = { selectRandom [(toArray 'A' #0) + floor(random ((toArray 'Z'#0) - (toArray 'A'#0))),(toArray 'a' #0) + floor(random ((toArray 'z'#0) - (toArray 'a'#0)))] }; 
private _newNumber = { (toArray '0' #0) + floor(random ((toArray '9' #0) - (toArray '0' #0)))}; 
private _output = [call _newCharacter]; 
for '_i' from 1 to 20 do {_output pushBack (selectRandom [call _newCharacter,call _newNumber])};   

private _varOut = toString _output;

if(_log)then{
	['RANDOMVARLOG',format['%1 => %2',_variN,_varOut]] call CQC_fnc_ahLog;
};

_varOut
