waitUntil {!isNull player};
execVM "functions\NRE_earplugs.sqf";
player setCustomAimCoef 0.45;
0 setFog 0;
forceWeatherChange;
999999 setFog 0;
player enableFatigue false;
player enableStamina false;
player addEventHandler ["HandleRating", {0}];
player addEventHandler ["Respawn", {removeUniform player; player forceAddUniform "U_Competitor"; player setUnitLoadout (player getVariable ["Saved_Loadout",[]]); player enableFatigue false; player setCustomAimCoef 0.05; player setUnitRecoilCoefficient 1;}];
// Prevent Team Killing
player addEventHandler ["HandleDamage", {
	private _damage = _this select 2;
	private _shooter = _this select 6;
	if (side _shooter == side player) then {
		_damage = 0;
	};
	_damage;
}];
player addEventHandler ["Fired", { 
_target = cursorTarget;
_bullet = _this select 6;
if(side _target == side player) then { 
deleteVehicle _bullet;
};}];
player addEventHandler ["HandleHeal", {
	_this spawn {
		params ["_injured","_healer"];
		_damage = damage _injured;
		if (_injured == _healer) then {
			waitUntil {damage _injured != _damage};
			if (damage _injured < _damage) then {
				_injured setDamage 0;
			};
		};
	};
}];
player addEventHandler ["killed", {
    if (isPlayer (_this select 2)) then {
        {playSound "killsound"; hint "Enemy Killed";} remoteExec ["bis_fnc_call", (_this select 1)];
    };
}];
execVM "jumpscript.sqf";
execVM "killEnemy.sqf";