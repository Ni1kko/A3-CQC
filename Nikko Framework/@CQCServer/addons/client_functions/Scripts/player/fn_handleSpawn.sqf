/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_name",""],
	["_from",0],
	["_to",0]
];

private _availableZones = [];

for "_zone" from _from to _to do 
{
	private _marker = format ["CQC_Marker_Spawn_%1%2",_name,_zone];
	private _markerPos = getMarkerPos _marker; 
	if (count(_markerPos nearEntities [["man"], 20]) isEqualTo 0) then { 
		_availableZones pushBackUnique [_marker,_markerPos,markerDir _marker];  
	};
};

if(count _availableZones isEqualTo 0)exitWith{
	["All spawns blocked. Try again."] spawn CQC_fnc_Notification;
	false
};

(selectRandom _availableZones) params[
	["_markerName","",[""]],
	["_markerPos",[0,0,0],[[]]],
	["_markerDir",0,[0]]
];

closeDialog 1;

player setPos _markerPos; 
player setDir _markerDir;

true