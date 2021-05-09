/*
#   Author: Frag Squad CQC Development Team
#   Description: Displays all the options.
#   For: Frag Squad CQC
*/

#include "common.hpp"
#include "jstar_defines.hpp"
#include "jstar_dialogs.hpp" 
#include "RscDisplayGarage.hpp"

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

class CQC_EDITBOX
{
	idd=-1341;
	movingenable=true;
	class controls
	{
		class RscEditMultiSTAR:RscEdit_CQC_multi
		{
			idc=1336;
			x=0.25;
			y=0.25;
			w=0.5;
			h=0.5;
		};
	};
};
class CQC_EDITBOX2
{
	idd=-1341;
	movingenable=true;
	class controls
	{
		class RscEditMultiSTAR:RscEdit_CQC_multi{autocomplete="scripting";};
		class RscEditSingle1STAR:RscEdit_CQC_ss{idc=1380;};
		class RscEditSingle2STAR:RscEdit_CQC_ss{idc=1381;};
		class RscEditSingle3STAR:RscEdit_CQC_ss{idc=1382;};
		class RscEditSingle4STAR:RscEdit_CQC_ss{idc=1383;};
		class infi_LIST1384:RscListBox_CQC{idc=1384;x=-0.25;y=0.2;w=0.25;h=0.9;sizeEx=0.027;};
	};
};
class CQC_CHAT
{
	idd=-1340;
	movingenable=false;
	onKeyDown="call fnc_chat_onKeyDown;";
	class controls
	{
		class RscListbox_1500:RscListBox_CQC
		{
			idc = 1500;
			x = 0.133846 * safezoneW + safezoneX;
			y = 0.0929318 * safezoneH + safezoneY;
			w = 0.165027 * safezoneW;
			h = 0.792133 * safezoneH;
			onLoad="uiNamespace setVariable ['chat_playerlist', _this select 0];call fnc_fill_chat_playerlist;(_this select 0) lbSetCurSel 0;";
			onLBSelChanged="call fnc_chat_onLBSelChanged;";
		};
		class RscListbox_1501:RscListBox_CQC
		{
			idc = 1501;
			x = 0.298873 * safezoneW + safezoneX;
			y = 0.0929318 * safezoneH + safezoneY;
			w = 0.505396 * safezoneW;
			h = 0.71512 * safezoneH;
			sizeEx=0.03;
			onLoad="uiNamespace setVariable ['chat_msgbox', _this select 0];call fnc_fill_chat_history;";
		};
		class RscEdit_1401:RscEdit_CQC_multi
		{
			idc = 1401;
			x = 0.298873 * safezoneW + safezoneX;
			y = 0.808052 * safezoneH + safezoneY;
			w = 0.505396 * safezoneW;
			h = 0.0770129 * safezoneH;
			onLoad="uiNamespace setVariable ['chat_inputfield', _this select 0];";
		};
		class RscButton_1600:RscButton_CQC
		{
			idc = 1600;
			text = "close";
			x = 0.752698 * safezoneW + safezoneX;
			y = 0.885064 * safezoneH + safezoneY;
			w = 0.051571 * safezoneW;
			h = 0.0330055 * safezoneH;
			action = "(findDisplay -1340) closeDisplay 0;";
		};
		class RscButton_1601:RscButton_CQC
		{
			idc = 1601;
			text = "send";
			x = (0.752698 * safezoneW + safezoneX)-((0.051571 * safezoneW)*1.1);
			y = 0.885064 * safezoneH + safezoneY;
			w = 0.051571 * safezoneW;
			h = 0.0330055 * safezoneH;
			action = "call fnc_chat_send;";
		};
		class RscButton_1602:RscButton_CQC
		{
			idc = 1602;
			text = "refresh list";
			x = 0.133846 * safezoneW + safezoneX;
			y = 0.885064 * safezoneH + safezoneY;
			w = 0.051571 * safezoneW;
			h = 0.0330055 * safezoneH;
			action = "call fnc_fill_chat_playerlist;";
		};
		class RscText_1000:RscText_CQC
		{
			idc = 1000;
			x = 0.133846 * safezoneW + safezoneX;
			y = 0.0599262 * safezoneH + safezoneY;
			w = 0.670423 * safezoneW;
			h = 0.0330055 * safezoneH;
			colorText[]={1,1,1,0.9};
			colorBackground[]={0,0,0,0.6};
			text = "Chatpartner";
			onLoad="uiNamespace setVariable ['chat_text1', _this select 0];";
		};
	};
};
class CQC_AdminMenu
{
	idd=-1338;
	movingenable=false;
	controls[]=
	{
	infi_TXT2,
	infi_BTN10,
	infi_BTN11,
	infi_BTN12,
	infi_LIST1500,
	infi_LIST1501,
	infi_BTN20,
	infi_BTN21,
	infi_BTN23,
	infi_BTN24,
	infi_BTN25,
	infi_EDIT1,
	infi_EDIT2,
	infi_BTN36,
	infi_BTN37,
	infi_BTN38,
	infi_HTML_1
	};
	class infi_LIST1500:RscListBox_CQC
	{
	idc=1500;
	x=4.99852e-005 * safezoneW + safezoneX;
	y=0.0617197 * safezoneH + safezoneY;
	w=0.189063 * safezoneW;
	h=0.938333 * safezoneH;
	};
	class infi_LIST1501:RscListBox_CQC
	{
	idc=1501;
	x=0.188975 * safezoneW + safezoneX;
	y=0.0617197 * safezoneH + safezoneY;
	w=0.344271 * safezoneW;
	h=0.945999 * safezoneH;
	};
	class infi_EDIT1:RscEdit_CQC
	{
	idc=100;
	text="";
	x=0.1964 * safezoneW + safezoneX;
	y=0.125933 * safezoneH + safezoneY;
	w=0.326563 * safezoneW;
	h=0.044 * safezoneH;
	};
	class infi_EDIT2:RscEdit_CQC_multi
	{
	idc=103;
	show=0;
	};
	class infi_TXT2:RscText_CQC
	{
	idc=2;
	text="CQC.de";
	x=-5.31323e-005 * safezoneW + safezoneX;
	y=-7.50085e-005 * safezoneH + safezoneY;
	w=1 * safezoneW;
	h=0.0341667 * safezoneH;
	colorText[]={1,1,1,0.9};
	colorBackground[]={0.56,0.04,0.04,1};
	};
	class infi_HTML_1:RscHTML_CQC
	{
	idc=1;
	x=0.535 * safezoneW + safezoneX;
	y=0.06 * safezoneH + safezoneY;
	w=0.40 * safezoneW;
	h=0.35 * safezoneH;
	onLoad="uiNamespace setVariable ['RscHTML_CQC_Admin', _this select 0]";
	onUnload="uiNamespace setVariable ['RscHTML_CQC_Admin', displayNull]";
	};
	class infi_BTN10:RscButton_CQC
	{
	idc=10;
	text="Alphabet";
	x=0.005 + safezoneX;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.06 * safezoneW;
	h=0.02 * safezoneH;
	action="SortRangePlease=nil;SortAlphaPlease=true;SortGroupsPlease=nil;[] call fnc_fill_CQC_Player;[] call fnc_setFocus;";
	};
	class infi_BTN11:RscButton_CQC
	{
	idc=11;
	text="Groups";
	x=0.01 + safezoneX + (0.06 * safezoneW);
	y=0.0379694 * safezoneH + safezoneY;
	w=0.06 * safezoneW;
	h=0.02 * safezoneH;
	action="SortAlphaPlease=nil;SortRangePlease=nil;SortGroupsPlease=true;[] call fnc_fill_CQC_Player;[] call fnc_setFocus;";
	};
	class infi_BTN12:RscButton_CQC
	{
	idc=12;
	text="Range";
	x=0.015 + safezoneX + (0.06 * safezoneW)*2;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.06 * safezoneW;
	h=0.02 * safezoneH;
	action="SortAlphaPlease=nil;SortRangePlease=true;SortGroupsPlease=nil;[] call fnc_fill_CQC_Player;[] call fnc_setFocus;";
	};
	class infi_BTN20:RscButton_CQC
	{
	idc=20;
	default="true";
	text="MainMenu";
	x=0.202072 * safezoneW + safezoneX;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.0625001 * safezoneW;
	h=0.02 * safezoneH;
	};
	class infi_BTN21:RscButton_CQC
	{
	idc=21;
	text="SpawnMenu";
	x=0.287975 * safezoneW + safezoneX;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.0625001 * safezoneW;
	h=0.02 * safezoneH;
	};
	class infi_BTN23:RscButton_CQC
	{
	idc=23;
	text="AHLog";
	x=0.373981 * safezoneW + safezoneX;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.0625001 * safezoneW;
	h=0.02 * safezoneH;
	};
	class infi_BTN24:RscButton_CQC
	{
	idc=24;
	text="AdminLog";
	x=0.459884 * safezoneW + safezoneX;
	y=0.0379694 * safezoneH + safezoneY;
	w=0.0625001 * safezoneW;
	h=0.02 * safezoneH;
	};
	class infi_BTN25:RscButton_CQC
	{
	idc=25;
	x=0.535 * safezoneW + safezoneX + (0.15 * safezoneW);
	y=0.0379694 * safezoneH + safezoneY;
	w=0.0625001 * safezoneW;
	h=0.02 * safezoneH;
	action="call fnc_btn_html";
	};
	class infi_BTN36:RscButton_CQC
	{
	idc=36;
	text="Items";
	x=0.219294 * safezoneW + safezoneX;
	y=0.0819514 * safezoneH + safezoneY;
	w=0.0916667 * safezoneW;
	h=0.0329999 * safezoneH;
	};
	class infi_BTN37:RscButton_CQC
	{
	idc=37;
	text="Vehicles";
	x=0.316644 * safezoneW + safezoneX;
	y=0.0819514 * safezoneH + safezoneY;
	w=0.0916667 * safezoneW;
	h=0.0329999 * safezoneH;
	};
	class infi_BTN38:RscButton_CQC
	{
	idc=38;
	text="Trader";
	x=0.414097 * safezoneW + safezoneX;
	y=0.0819514 * safezoneH + safezoneY;
	w=0.0916667 * safezoneW;
	h=0.0329999 * safezoneH;
	};
};