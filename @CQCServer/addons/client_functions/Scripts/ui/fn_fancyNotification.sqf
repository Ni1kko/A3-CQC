_structuredTextStrNoUnderscore = _this select 0;
_icon = _this select 1;
_iconColor = _this select 2;
_notiColor = _this select 2;

if (isNil "_icon") then {
	_icon = "\A3\Ui_f\data\GUI\Cfg\RespawnRoles\recon_ca.paa";
};

if (isNil "_iconColor") then {
	_iconColor = [0, 0, 0, 1];
};

if (isNil "_notiColor") then {
	_notiColor = [1,0.35,0,0.7];
};

if (!isNil {player getVariable "underScoreLoop"}) then {
	terminate (player getVariable "underScoreLoop")
};

_structuredTextCount = count (str _structuredTextStrNoUnderscore);
_structuredTextCountSubstracted = _structuredTextCount - 6;

_firstPartOfStrText = _structuredTextStrNoUnderscore select [0,_structuredTextCountSubstracted];
_secondPartOfStrText = _structuredTextStrNoUnderscore select [_structuredTextCountSubstracted, _structuredTextCount];

_tempArrayForStr = [];

_tempArrayForStr pushback _firstPartOfStrText;
_tempArrayForStr set [1, "_"];
_tempArrayForStr pushBack _secondPartOfStrText;
_structuredTextStrUnderscore = _tempArrayForStr joinString "";
_tempArrayForStr = nil;

_bgNotification = (findDisplay 46) displayCtrl 11;
_iconNotification = (findDisplay 46) displayCtrl 12;
_textNotification = (findDisplay 46) displayCtrl 13;
ctrlDelete _bgNotification;
ctrlDelete _iconNotification;
ctrlDelete _textNotification;

playsound "hintExpand";
playsound "hintExpand";
playsound "hintExpand";

_bgNotification = findDisplay 46 ctrlCreate ["RscBackground", 11];
_bgNotification ctrlSetBackgroundColor _notiColor;
_bgNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.06)];
_bgNotification ctrlCommit 0;
_bgNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.4),(safezoneH * 0.06)];
_bgNotification ctrlCommit 0.75;

_iconNotification = findDisplay 46 ctrlCreate ["RscPictureKeepAspect", 12];
_iconNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.06)];
_iconNotification ctrlSetText _icon;
_iconNotification ctrlSetTextColor _iconColor;
_iconNotification ctrlCommit 0;
_iconNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.035),(safezoneH * 0.06)];
_iconNotification ctrlCommit 0.075;

sleep 0.075;

_textNotification = findDisplay 46 ctrlCreate ["RscStructuredText", 13];
_textNotification ctrlSetPosition [(safezoneX + 0.335 * safezoneW),(safezoneY + 0.13 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.05)];
_textNotification ctrlCommit 0;
_textNotification ctrlSetPosition [(safezoneX + 0.335 * safezoneW),(safezoneY + 0.13 * safezoneH),(safezoneW * 0.365),(safezoneH * 0.05)];
_textNotification ctrlSetStructuredText parseText _structuredTextStrNoUnderscore;
_textNotification ctrlCommit 0.675;

sleep 0.675;



_underscoreLoop = [_structuredTextStrUnderscore, _structuredTextStrNoUnderscore] spawn {
	_textNotification = (findDisplay 46) displayCtrl 13;
	_structuredTextStrUnderscore = _this select 0;
	_structuredTextStrNoUnderscore = _this select 1;
	_varForUnderscores = 0;
	while {true} do {
		if (_varForUnderscores isEqualTo 0) then {
		_textNotification ctrlSetStructuredText parseText _structuredTextStrUnderscore;
		_varForUnderscores = 1;
		} else {
		_textNotification ctrlSetStructuredText parseText _structuredTextStrNoUnderscore;
		_varForUnderscores = 0;
		};
		sleep 0.5;
	};
};

player setVariable ["underScoreLoop", _underscoreLoop];


sleep 5;

terminate _underscoreLoop;
player setVariable ["underScoreLoop", nil];

_bgNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.06)];
_bgNotification ctrlCommit 0.75;

_textNotification ctrlSetPosition [(safezoneX + 0.335 * safezoneW),(safezoneY + 0.13 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.05)];
_textNotification ctrlCommit 0.675;

sleep 0.675;

_iconNotification ctrlSetPosition [(safezoneX + 0.3 * safezoneW),(safezoneY + 0.125 * safezoneH),(safezoneW * 0.0001),(safezoneH * 0.06)];
_iconNotification ctrlCommit 0.075;

sleep 0.075;

_controls = [_bgNotification, _iconNotification, _textNotification];

{
	ctrlDelete _x;
} forEach _controls;