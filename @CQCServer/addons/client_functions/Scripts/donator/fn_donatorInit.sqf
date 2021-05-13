if !(call isDonator)exitwith {(findDisplay 46) closeDisplay 2};//bad... open me without perms and get disconected

diag_log "Donator Init started";

systemChat ("Welcome "+profileName+", Thanks for being a donator your support is much appricated");

[] spawn {
	while {true} do 
	{
		private _magInfo = [];  
		private _bulletCount = 0;
		private _bulletCountFull = 0;

		//Wait till need reload
		private _reload = false;
		waitUntil{
			uiSleep 1;
			if(currentWeapon player != "" AND currentMagazine player  != "")then{
				_magInfo = currentMagazineDetail player;  
				_bulletCount = parseNumber(((_magInfo splitString "()")#1 splitString "/")#0);
				if(_bulletCount <= 0)exitWith{
					_reload = true;
				};
			};
			_reload
		};

		["Auto reload"] spawn CQC_fnc_Notification;
		reload player;

		private _reloaded = false;
		waitUntil{
			uiSleep 1;
			if(currentWeapon player != "" AND currentMagazine player  != "")then{
				_magInfo = currentMagazineDetail player;  
				_bulletCount = parseNumber(((_magInfo splitString "()")#1 splitString "/")#0);
				_bulletCountFull = parseNumber(((_magInfo splitString "()")#1 splitString "/")#1);
				if(_bulletCount isEqualTo _bulletCountFull)then{
					_reloaded = true;
				};
				_reloaded
			}else{
				true
			};
		};
		
		["Reloaded"] spawn CQC_fnc_Notification;
	};
};

diag_log "Donator Init Finished";