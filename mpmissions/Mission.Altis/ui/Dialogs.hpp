/*
#   Author: Frag Squad CQC Development Team
#   Description: Displays all the options.
#   For: Frag Squad CQC
*/ 
class CQC_ctrlDefault {
	access = 0;
	idc = -1;
	style = 0;
	default = 0;
	show = 1;
	fade = 0;
	blinkingPeriod = 0;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	tooltip = "";
	tooltipMaxWidth = 0.5;
	tooltipColorShade[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
	class ScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.06;
		arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
		arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
		border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
		thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
};

class CQC_ctrlDefaultText: CQC_ctrlDefault {
	sizeEx = "4.32 * pixelH * pixelGrid * 0.5";
	font = "RobotoCondensedLight";
	shadow = 1;
};

class CQC_ctrlDefaultButton: CQC_ctrlDefaultText {
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
};

class CQC_ctrlStatic: CQC_ctrlDefaultText {
	type = 0;
	colorBackground[] = {0,0,0,0};
	text = "";
	lineSpacing = 1;
	fixedWidth = 0;
	colorText[] = {1,1,1,1};
	colorShadow[] = {0,0,0,1};
	moving = 0;
	autoplay = 0;
	loops = 0;
	tileW = 1;
	tileH = 1;
	onCanDestroy = "";
	onDestroy = "";
	onMouseEnter = "";
	onMouseExit = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onVideoStopped = "";
};

class CQC_ctrlStaticPicture: CQC_ctrlStatic {
	style = 48;
};

class CQC_ctrlStaticPictureKeepAspect: CQC_ctrlStaticPicture {
	style = "0x30 + 0x800";
};

class CQC_ctrlStaticPictureTile: CQC_ctrlStatic {
	style = 144;
};

class CQC_ctrlStaticFrame: CQC_ctrlStatic {
	style = 64;
};

class CQC_ctrlStaticLine: CQC_ctrlStatic {
	style = 176;
};

class CQC_ctrlStaticMulti: CQC_ctrlStatic {
	style = "0x10 + 0x200";
};

class CQC_ctrlStaticBackground: CQC_ctrlStatic {
	colorBackground[] = {0.2,0.2,0.2,1};
};

class CQC_ctrlStaticOverlay: CQC_ctrlStatic {
	colorBackground[] = {0,0,0,0.5};
};

class CQC_ctrlStaticTitle: CQC_ctrlStatic {
	moving = 1;
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorText[] = {1,1,1,1};
	colorShadow[] = {0,0,0,0};
};

class CQC_ctrlStaticFooter: CQC_ctrlStatic {
	colorBackground[] = {0,0,0,0.3};
};

class CQC_ctrlStaticBackgroundDisable: CQC_ctrlStatic {
	x = -4;
	y = -2;
	w = 8;
	h = 4;
	colorBackground[] = {1,1,1,0.5};
};

class CQC_ctrlStaticBackgroundDisableTiles: CQC_ctrlStaticPictureTile {
	x = -4;
	y = -2;
	w = 8;
	h = 4;
	text = "\a3\3DEN\Data\Displays\Display3DENEditAttributes\backgroundDisable_ca.paa";
	tileW = "8 / (32 * pixelW)";
	tileH = "4 / (32 * pixelH)";
	colorText[] = {1,1,1,0.05};
};

class CQC_ctrlButton: CQC_ctrlDefaultButton {
	type = 1;
	style = "0x02 + 0xC0";
	colorBackground[] = {0,0,0,1};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	font = "PuristaLight";
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	borderSize = 0;
	colorBorder[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";
	period = 0;
	periodFocus = 2;
	periodOver = 0.5;
	class KeyHints {
		class A
		{
			key = "0x00050000 + 0";
			hint = "KEY_XBOX_A";
		};
	};
	onCanDestroy = "";
	onDestroy = "";
	onMouseEnter = "";
	onMouseExit = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onButtonClick = "";
	onButtonDown = "";
	onButtonUp = "";
};

class CQC_ctrlButtonPicture: CQC_ctrlButton {
	style = "0x02 + 0x30";
};

class CQC_ctrlButtonPictureKeepAspect: CQC_ctrlButton {
	style = "0x02 + 0x30 + 0x800";
};

class CQC_ctrlButtonOK: CQC_ctrlButton {
	default = 1;
	idc = 1;
	text = "$STR_DISP_OK";
};

class CQC_ctrlButtonCancel: CQC_ctrlButton {
	idc = 2;
	text = "$STR_DISP_CANCEL";
};

class CQC_ctrlButtonClose: CQC_ctrlButtonCancel {
	text = "$STR_DISP_CLOSE";
};

class CQC_ctrlButtonToolbar: CQC_ctrlButtonPictureKeepAspect {
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
};

class CQC_ctrlButtonSearch: CQC_ctrlButton {
	style = "0x02 + 0x30 + 0x800";
	text = "\a3\3DEN\Data\Displays\Display3DEN\search_start_ca.paa";
	textSearch = "\a3\3DEN\Data\Displays\Display3DEN\search_end_ca.paa";
	tooltip = "$STR_3den_display3den_menubar_search_text";
};

class CQC_ctrlButtonExpandAll: CQC_ctrlButtonToolbar {
	style = "0x02 + 0x30 + 0x800";
	text = "\a3\3DEN\Data\Displays\Display3DEN\tree_expand_ca.paa";
	tooltip = "$STR_3DEN_ctrlButtonExpandAll_text";
};

class CQC_ctrlButtonCollapseAll: CQC_ctrlButtonToolbar {
	style = "0x02 + 0x30 + 0x800";
	text = "\a3\3DEN\Data\Displays\Display3DEN\tree_collapse_ca.paa";
	tooltip = "$STR_3DEN_ctrlButtonCollapseAll_text";
};

class CQC_ctrlButtonFilter: CQC_ctrlButton {
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {1,1,1,0.3};
	colorFocused[] = {0,0,0,0};
};

class CQC_ctrlListbox: CQC_ctrlDefaultText {
	type = 5;
	style = "0x00 + 0x10";
	colorBackground[] = {0,0,0,0.2};
	colorSelectBackground[] = {1,0.5,0,0.5};
	colorSelectBackground2[] = {1,0.5,0,0.5};
	colorShadow[] = {0,0,0,0};
	colorDisabled[] = {1,1,1,0.25};
	colorText[] = {1,1,1,1};
	colorSelect[] = {1,1,1,1};
	colorSelect2[] = {1,1,1,1};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {1,1,1,1};
	colorSelect2Right[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	period = 1;
	rowHeight = "4.32 * pixelH * pixelGrid * 0.5";
	itemSpacing = 0;
	maxHistoryDelay = 1;
	canDrag = 0;
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	class ListScrollBar: ScrollBar{};
	onCanDestroy = "";
	onDestroy = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onLBSelChanged = "";
	onLBDblClick = "";
	onLBDrag = "";
	onLBDragging = "";
	onLBDrop = "";
};

class CQC_ctrlStructuredText: CQC_ctrlDefaultText {
	type = 13;
	colorBackground[] = {0,0,0,0};
	size = "4.32 * pixelH * pixelGrid * 0.5";
	text = "";
	class Attributes {
		align = "left";
		color = "#FFFFFF";
		colorLink = "#c48214";
		size = 1;
		font = "RobotoCondensedLight";
	};
	onCanDestroy = "";
	onDestroy = "";
	onButtonClick = "true";
};

class CQCDisplayOptions {
	idd = -1;
	onLoad = "[""onLoad"",_this] call (missionNameSpace getVariable ""CQC_fnc_displayOptions"")";
	onUnload = "[""onUnload"",_this] call (missionNameSpace getVariable ""CQC_fnc_displayOptions"")";

	class controlsBackground {
		class title: CQC_ctrlStaticTitle {
			idc = 1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class background: CQC_ctrlStaticBackground {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "45*(pixelH*pixelGrid*	0.50)";
		};

		class footer: CQC_ctrlStaticFooter {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(45*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5";
		};
	};

	class controls {
		class body: CQC_ctrlListbox {
			idc = 2;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(1*(pixelH*pixelGrid*	0.50))";
			w = "(63*(pixelW*pixelGrid*	0.50))-(2*(pixelW*pixelGrid*	0.50))";
			h = "(45*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)-(2*(pixelH*pixelGrid*	0.50))";
		};

		class button1: CQC_ctrlButton {
			idc = 3;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(2*(pixelW*pixelGrid*	0.50))+(30*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(45*(pixelH*pixelGrid*	0.50))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  *1.25)";
			w = "30*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class button2: button1 {
			idc = 4;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
		};
	};
};

class CQCDisplaySpawns {
	idd = -1;
	onLoad = "[""onLoad"",_this] call (missionNameSpace getVariable ""CQC_fnc_displaySpawns"")";
	onUnload = "[""onUnload"",_this] call (missionNameSpace getVariable ""CQC_fnc_displaySpawns"")";

	class controlsBackground {
		class title: CQC_ctrlStaticTitle {
			idc = 1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class background: CQC_ctrlStaticBackground {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "45*(pixelH*pixelGrid*	0.50)";
		};

		class footer: CQC_ctrlStaticFooter {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(45*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5";
		};
	};

	class controls {
		class body: CQC_ctrlListbox {
			idc = 2;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(1*(pixelH*pixelGrid*	0.50))";
			w = "(63*(pixelW*pixelGrid*	0.50))-(2*(pixelW*pixelGrid*	0.50))";
			h = "(45*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)-(2*(pixelH*pixelGrid*	0.50))";
		};

		class button1: CQC_ctrlButton {
			idc = 3;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(2*(pixelW*pixelGrid*	0.50))+(30*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(45*(pixelH*pixelGrid*	0.50)))+(45*(pixelH*pixelGrid*	0.50))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  *1.25)";
			w = "30*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class button2: button1 {
			idc = 4;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
		};
	};
};

class CQCDisplayHelp {
	idd = -1;
	onLoad = "[""onLoad"",_this] call (missionNameSpace getVariable ""CQC_fnc_displayHelp"")";
	onUnload = "[""onUnload"",_this] call (missionNameSpace getVariable ""CQC_fnc_displayHelp"")";
	
	class controlsBackground {
		class title: CQC_ctrlStaticTitle {
			idc = 1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(100*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(90*(pixelH*pixelGrid*	0.50)))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )";
			w = "100*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};
        
		class background: CQC_ctrlStaticBackground {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(100*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(90*(pixelH*pixelGrid*	0.50)))";
			w = "100*(pixelW*pixelGrid*	0.50)";
			h = "90*(pixelH*pixelGrid*	0.50)";
		};

		class footer: CQC_ctrlStaticFooter {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(100*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(90*(pixelH*pixelGrid*	0.50)))+(90*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)";
			w = "100*(pixelW*pixelGrid*	0.50)";
			h = "(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5";
		};
	};

	class controls {
		class body: CQC_ctrlStructuredText {
			idc = 2;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(100*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(90*(pixelH*pixelGrid*	0.50)))+(1*(pixelH*pixelGrid*	0.50))";
			w = "(100*(pixelW*pixelGrid*	0.50))-(2*(pixelW*pixelGrid*	0.50))";
			h = "(90*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)-(2*(pixelH*pixelGrid*	0.50))";
		};

		class button: CQC_ctrlButton {
			idc = 3;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(100*(pixelW*pixelGrid*	0.50)))+(100*(pixelW*pixelGrid*	0.50))-(31*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(90*(pixelH*pixelGrid*	0.50)))+(90*(pixelH*pixelGrid*	0.50))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  *1.25)";
			w = "30*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};
	};
};

class CQCAdminMenu {
	idd = -1;
	onLoad = "[""onLoad"",_this] call (missionNameSpace getVariable ""CQC_fnc_adminMenu"")";
	onUnload = "[""onUnload"",_this] call (missionNameSpace getVariable ""CQC_fnc_adminMenu"")";
	
	class controlsBackground {
		class title: CQC_ctrlStaticTitle {
			idc = 1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(75*(pixelH*pixelGrid*	0.50)))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class background: CQC_ctrlStaticBackground {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(75*(pixelH*pixelGrid*	0.50)))";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "75*(pixelH*pixelGrid*	0.50)";
		};

		class footer: CQC_ctrlStaticFooter {
			idc = -1;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(75*(pixelH*pixelGrid*	0.50)))+(75*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)";
			w = "63*(pixelW*pixelGrid*	0.50)";
			h = "(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5";
		};
	};

	class controls {
		class body: CQC_ctrlListbox {
			idc = 2;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(75*(pixelH*pixelGrid*	0.50)))+(1*(pixelH*pixelGrid*	0.50))";
			w = "(63*(pixelW*pixelGrid*	0.50))-(2*(pixelW*pixelGrid*	0.50))";
			h = "(75*(pixelH*pixelGrid*	0.50))-((((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  )*1.5)-(2*(pixelH*pixelGrid*	0.50))";
		};

		class button1: CQC_ctrlButton {
			idc = 3;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(2*(pixelW*pixelGrid*	0.50))+(30*(pixelW*pixelGrid*	0.50))";
			y = "(	 		safezoneY+(0.5*safezoneH))-(0.5*(75*(pixelH*pixelGrid*	0.50)))+(75*(pixelH*pixelGrid*	0.50))-(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85  *1.25)";
			w = "30*(pixelW*pixelGrid*	0.50)";
			h = "((((safezoneW/safezoneH)min 1.2)/1.2)/25)*0.85";
		};

		class button2: button1 {
			idc = 4;
			x = "(	 		safezoneX+(0.5*safezoneW))-(0.5*(63*(pixelW*pixelGrid*	0.50)))+(1*(pixelW*pixelGrid*	0.50))";
		};
	};
};

#include "infiSTAR_AdminMenu.hpp"