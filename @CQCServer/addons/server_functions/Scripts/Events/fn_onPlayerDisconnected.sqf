/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	['_uid','',['']], 
	['_name','',['']], 
	['_jip',false,[false]], 
	['_owner',2,[0]]
];

//Players only
if (_owner < 3) exitWith {false};

//Return
true