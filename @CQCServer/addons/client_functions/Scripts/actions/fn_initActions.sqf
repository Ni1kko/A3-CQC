/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

//--- Heal
private _healting = player addAction ["heal", "[] spawn CQC_fnc_healPlayer", nil, 6, true, true, "", "damage player != 0 AND player == vehicle player"];
player setUserActionText [_healting , "Treat yourself", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/>"];