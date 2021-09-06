/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

waitUntil {!isNull player};  

[] call CQC_fnc_stopProgress;

if(getNumber(missionConfigFile >> "spawnSmoke") isEqualTo 1)then{
	private _spawnSmoke = [] spawn {
		private _particles = []; 
		for "_i" from 0 to 360 step 45 do {
			_pos = player getPos[1,_i]; 
			_particle = "#particlesource" createVehicleLocal _pos;
			_particle setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 10, [0, 0, 0],[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 0.7],[1, 1, 1, 0.5], [1, 1, 1, 0.25], [1, 1, 1, 0]],[0.2], 1, 0.04, "", "", _this];
			_particle setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
			_particle setDropInterval 0.2;
			_particles pushBack _particle;
			_particle1 = "#particlesource" createVehicleLocal _pos;
			_particle1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 7, 0], "", "Billboard", 1, 5, [0, 0, 0],[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 1],[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 0]],[0.2], 1, 0.04, "", "", _this];
			_particle1 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
			_particle1 setDropInterval 0.15;
			_particles pushBack _particle1; 
		};
		uiSleep 1; 
		{deleteVehicle _x}forEach _particles; 
		true
	};
	waitUntil {scriptDone _spawnSmoke};
};

player switchCamera "EXTERNAL";
player enableFatigue false; 
player setCustomAimCoef 0.00;
player addRating -1000000; 

// Updates the variables
player setUnitTrait ["Medic",true];
player setVariable ["cqc_kills", profileNamespace getVariable "cqc_kills"];
player setVariable ["cqc_death", profileNamespace getVariable "cqc_death"];
player setVariable ["cqc_kda", profileNamespace getVariable "cqc_kda"];
player setVariable ["Earplugs",0];
player setVariable ["Plugs",false];


[] spawn CQC_fnc_eventHandlers;
[] spawn CQC_fnc_initActions;// scroll actions

//Temp Check If Not In DB
if !(call isAdmin) then{  
	if (getplayeruid player in [
		// Staff Team
		'76561198119520123', // Callum HD
		'76561198334203836', // Tom Cliffoff
		'76561198095796413', // Shipman
		'76561197967469192', // Scottish
		'76561198101131022', // Helmut
		'76561199034504598', //dabest
		'76561199089637134', //house

		// Development Team
		'76561198250806228', // Martinez 
		'76561198283428669'  // Ryn
	]) then {
		titleText ["<t color='#ff0000' size='5'>Please visit discord and @Developer requesting you be added to the database!</t>", "PLAIN", -1, true, true];
	};
};

//Temp Check If Not In DB
if!(call isDonator)then{ 
	if (getplayeruid player in [
		'76561198393606454', // Yab (Friend)
		'76561198276144474', // Liamm
		'76561198092176053', // TyRant
		'76561198105744855', // Reidy
		'76561198130546772', // Kevin
		'76561198081711098', // Alistair
		'76561198264633517', // Ethan
		'76561198030088997', // Rogue
		'76561198261714445', // Kral
		'76561198138454776', // Silo
		'76561198213550053', // Mikey!
		'76561198169146689', // Joike
		'76561198285522367', // Nathan
		'76561198272394878', // Vince
		'76561198075617538', // Clark
		'76561198121847178', // Butch
		'76561198271611896', // hawky
		'76561198097255922', // Eemil
		'76561198195264231', // Sicario
		'76561198976538765',  // monkeycow
		'76561198114101981', // Damon
		'76561199066320068', // Shado 
		'76561198172489513', // Harry.
		'76561198102381199', // Ghost2k
		'76561199034504598', //dabest
		'76561198203772432', //McPooperson
		'76561198942538304'  // Actually Shock
	]) then {
		titleText ["<t color='#ff0000' size='5'>Please visit discord and @Developer requesting you be added to the VIP!</t>", "PLAIN", -1, true, true];
	};
};

// Custom Loadout Bullshit
if ((call isDonator) AND count (CQC_var_clientGear) > 0) then {
	player setUnitLoadout CQC_var_clientGear;
}else{
	private _customLoadout = profileNamespace getVariable [ "CQC_Custom_Loadout", [] ];
	if ( count (_customLoadout) > 0) then {
		player setUnitLoadout _customLoadout;
	}else{
		//fail safe (no custom, no db saved)
		player setUnitLoadout [[],[],[],["U_C_Poloshirt_tricolour",[]],["V_PlateCarrier2_blk",[]],[],"H_Hat_brown","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		[] call CQC_fnc_saveGear;
	};
};


if(profileNameSpace getVariable ["CQC_idleKicked",false])then{
	profileNameSpace setVariable ["CQC_idleKicked",false];
	saveprofileNameSpace;
	["Welcome Back, You we're kicked for being idle"] spawn CQC_fnc_Notification;
};

if(CQC_var_firstSpawn)then{
	CQC_var_firstSpawn = false;
	if(call isDonator)then{
		[] spawn CQC_fnc_donatorInit;
	}else{
		createDialog "CQC_Rsc_DisplayHelp";
	};
}else{
	createDialog "CQC_Rsc_DisplaySpawns";
};

if(isNil "CQC_fnc_customHudInit")then{
	[]spawn{
		waitUntil{!isNil "CQC_fnc_customHudInit"};
		[] spawn CQC_fnc_customHudInit;
	};
}else{
	[] spawn CQC_fnc_customHudInit;
};

true