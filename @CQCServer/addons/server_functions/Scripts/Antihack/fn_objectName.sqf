/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

if(alive _this)then{
	_n = name _this;
	_this setVariable['playerName',_n];
	_n
}else{
	_n = _this getVariable['playerName',''];
	if(_n isEqualTo '')then{
		if!(getPlayerUID _this isEqualTo '')then{
			_n = name _this;
			_this setVariable['playerName',_n];
		};
	};
	_n
};