/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

private _spawnbuddy = CQC_var_admin_spawnbuddys find _this;
if(_spawnbuddy >= 0)exitWith{
	CQC_var_admin_spawnbuddys deleteAt _spawnbuddy;
	publicvariable "CQC_var_admin_spawnbuddys";
	true
};
false