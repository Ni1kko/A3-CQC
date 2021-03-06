/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

params [
	["_id",-100,[0]],			// Number - is the unique DirectPlay ID. Quite useless as the number is too big for in-built string representation and gets rounded. It is also the same id used for user placed markers.
	["_steamid","",[""]],		// String - is getPlayerUID of the joining player. In Arma 3 it is also the same as Steam ID.
	["_ProfileName","",[""]],	// String - is profileName of the joining player.
	["_didJip",false,[false]], 	// Boolean - is a flag that indicates whether or not the player joined after the mission has started (Joined In Progress). true when the player is JIP, otherwise false. (since Arma 3 v1.49)
	["_ownerID",-100,[0]],		// Number - is owner id of the joining player. Can be used for kick or ban purposes or just for publicVariableClient. (since Arma 3 v1.49) 
	["_idstr","",[""]]  		// String - same as _id but in string format, so could be exactly compared to user marker ids. (since Arma 3 v1.95) 
];

// User-Defined - custom passed args (since Arma 3 v2.04) 
//_thisArgs

//Players only
if (_ownerID < 3) exitWith {false};

//Return
true