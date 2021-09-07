/*
#	File:   signs.sqf
#	Author: Martinezzz
#	Server: Frag Squad CQC
#	Github: https://github.com/MartinezDeveloper
*/

removeAllMissionEventHandlers "Draw3D";

// Arsenal Box
addMissionEventHandler ["Draw3D",   
    {   
		_pos = getPosWorld CQC_arsenal;  
		alphaText = linearConversion [0, 10, player distance CQC_arsenal, 3, 0, true];  
		drawIcon3D [
			"",
			[1,1,1, alphaText],
			[(_pos select 0), (_pos select 1), 2.3], 
			4, 
			0.6, 
			0,
			"Arsenal",
			1,
			0.03, 
			"RobotoCondensed"
		];  
    }  
];

// Spawn Sign
addMissionEventHandler ["Draw3D",   
    {   
		_pos = getPosWorld fragsquad_shop;  
		alphaText = linearConversion [0, 10, player distance fragsquad_shop, 3, 0, true];  
		drawIcon3D [
			"",
			[1,1,1, alphaText],
			[(_pos select 0), (_pos select 1), 2.3], 
			4, 
			0.6, 
			0,
			"Spawn Sign",
			1,
			0.03, 
			"RobotoCondensed"
		];  
    }  
];