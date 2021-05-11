/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

CQC_var_donatorESPActive = !(missionNamespace getVariable ["CQC_var_donatorESPActive",false]);

if (CQC_var_donatorESPActive) then {
	Fragsquad_CQC_ESP = addMissionEventHandler ["Draw3D",
		{
			{
				if ((isPlayer _x) && ((side _x) isEqualTo (side player)) && ((player distance _x) < 250) && (getplayeruid _x != "") !isObjectHidden _x) then {
					_pos = getposatl _x;
					_eyepos = ASLtoATL eyepos _x;
					if ((getTerrainHeightASL [_pos select 0,_pos select 1]) < 0) then {
						_eyepos = eyepos _x;
						_pos = getposasl _x;
					};
					_3 = _x modelToWorld [-0.5,0,0];
					_3 set [2,(_eyepos select 2)+0.25];
					_HP = (damage _x - 1) * -100;
					_fontsize = 0.025;
					_eyepos set [2,(_3 select 2) - 1];
					drawIcon3D ["", [0,1,0,1], _eyepos,0.1,0.1,45,format["%1 (%2m) - %3HP",name _x,round(player distance _x),round(_HP)],1,_fontsize,'EtelkaNarrowMediumPro'];
				};
			} forEach allPlayers;
		}
	];
	["VIP ESP Enabled"] spawn CQC_fnc_Notification;
	closeDialog 0;
} else {
	["VIP ESP Disabled"] spawn CQC_fnc_Notification;
	closeDialog 0;
	removeMissionEventHandler ["Draw3D", Fragsquad_CQC_ESP];
	Fragsquad_CQC_ESP = -1;
};