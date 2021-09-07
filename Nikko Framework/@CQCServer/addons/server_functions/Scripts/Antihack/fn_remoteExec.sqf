/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [['_input',''],['_code',{}],['_id',0],['_jip',false]];
if(_id isEqualTo 0)exitWith{false};
if(_code isEqualType '')then{_code=compile _code;};
if(_id isEqualTo 2)exitWith{_input call _code};
[_input,_code] remoteExecCall ['call',_id,_jip]