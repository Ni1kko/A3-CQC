/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_character",objNull,[objNull]]
];

if(!isNull _character)then{
	if !(_character isKindOf "Man")exitWith{};
	_character hideObjectGlobal false;
};