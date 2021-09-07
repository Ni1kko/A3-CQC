private _returnValue = [];       
private _cfgCompatibleItems = _this;
if (isArray _cfgCompatibleItems) then {
	_returnValue = getArray _cfgCompatibleItems;
} else {
	if (isClass _cfgCompatibleItems) then {
		_returnValue = (configProperties [_cfgCompatibleItems, "isNumber _x && {(getNumber _x) > 0}"]) apply {configName _x};
	};
};
_returnValue	