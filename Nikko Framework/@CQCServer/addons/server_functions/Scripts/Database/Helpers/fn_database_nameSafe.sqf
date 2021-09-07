/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_name","",[""]]
];

//check each char
_name = toArray _name;

_forbidden = [];
{
	if(_x in _forbidden)then{
		_name set [_forEachIndex, "-"];
	};
}forEach _name;

//Return
toString _name;