class JSt4r_RSC_Progress
{
	type = 8;
	style = 0;
	idc = -1;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.1;
	y = 0.1;
	w = 1;
	h = 0.03;
};
class myProgressBar
{
	idd = 1;
	onLoad = "";
	class Controls
	{
		class Progress: JSt4r_RSC_Progress 
		{
			idc = -1;
			x = 0.1;
			y = 0.1;
		};
	};
};

class jstar_itemJStar
{
	idd = 500;
	name= "jstar_itemmenu";
	onLoad = "_this execVM 'scripts\jstar_itemmenu\jstar_menu.sqf'";
	controlsBackground[] = {title, background, footer};
	controls[] = {button, RscListbox_1500};

	class title: CQC_ctrlStaticTitle
	{
		idc = 1;

		text = "Items"; //--- ToDo: Localize;
		x = 0.395852 * safezoneW + safezoneX;
		y = 0.31674 * safezoneH + safezoneY;
		w = 0.208348 * safezoneW;
		h = 0.0187 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	};
	
	class background: CQC_ctrlStaticBackground
	{
		idc = 1001;
		x = 0.395852 * safezoneW + safezoneX;
		y = 0.33324 * safezoneH + safezoneY;
		w = 0.208348 * safezoneW;
		h = 0.333333 * safezoneH;
		colorText[] = {1,1,1,1};
	};

	class footer: CQC_ctrlStaticFooter
	{
		idc = 1002;
		x = 0.395852 * safezoneW + safezoneX;
		y = 0.6386 * safezoneH + safezoneY;
		w = 0.208348 * safezoneW;
		h = 0.02805 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.3};
	};

	class button: CQC_ctrlButton
	{
		idc = 3;

		x = 0.539537 * safezoneW + safezoneX;
		y = 0.64322 * safezoneH + safezoneY;
		w = 0.0625044 * safezoneW;
		h = 0.0187 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,1};
		text = "Close";
		action = "closeDialog 1;";
	};

	class RscListbox_1500: CQC_ctrlListbox
	{
		idc = 518;
		x = 0.399078 * safezoneW + safezoneX;
		y = 0.3394 * safezoneH + safezoneY;
		w = 0.201845 * safezoneW;
		h = 0.2948 * safezoneH;
		onLBSelChanged = "[_this] execVM 'scripts\jstar_itemmenu\jstar_options.sqf'";
	};

};

class jon_KDA
{
	idd = 500;
	name= "jon_kda";
	onLoad = "_this execVM 'scripts\jstar_itemmenu\jon_kda.sqf'";
	controlsBackground[] = {Background};
	controls[] = {LocationSelect, TeleportText, Close};
	
	class Background: IGUIBack
	{
		idc = 2200;
		x = 0.421035 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.144769 * safezoneW;
		h = 0.252 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
	class TeleportText: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "Menu"; //--- ToDo: Localize;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.402 * safezoneH + safezoneY;
		w = 0.118447 * safezoneW;
		h = 0.042 * safezoneH;
		tooltip = "JSt4r_Menu"; //--- ToDo: Localize;
	};
	class Close: JSt4r_RSC_Button
	{
		idc = 1600;
		action = "closeDialog 1;";
		text = "x"; //--- ToDo: Localize;
		x = 0.559224 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.00658041 * safezoneW;
		h = 0.014 * safezoneH;
		tooltip = "Close"; //--- ToDo: Localize;
	};
	class LocationSelect: JSt4r_RSC_ListBox
	{
		idc = 518;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.118447 * safezoneW;
		h = 0.168 * safezoneH;
		onLBSelChanged = "[_this] execVM 'scripts\jstar_itemmenu\jstar_options.sqf'";
	};
};

class empty {
	idd = 7529;
	idc = 7612;
};

class jstar_items {
  idd = 10022;
  class controls {
	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0.414455 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.144769 * safezoneW;
		h = 0.336 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
	class JSt4r_RSC_StructuredText_1100: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "Item Menu"; //--- ToDo: Localize;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.402 * safezoneH + safezoneY;
		w = 0.105287 * safezoneW;
		h = 0.042 * safezoneH;
		tooltip = "JSt4r_Item_Menu"; //--- ToDo: Localize;
	};
	class JSt4r_RSC_Button_1602: JSt4r_RSC_Button
	{
		idc = 1602;
		action = "closeDialog 1;";
		text = "x"; //--- ToDo: Localize;
		x = 0.552643 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.00658041 * safezoneW;
		h = 0.014 * safezoneH;
		tooltip = "Close"; //--- ToDo: Localize;
	};
	class JSt4r_RSC_Button_1606: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""20Rnd_762x51_Mag"";";
	};
	class JSt4r_RSC_Button_1607: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_762x39_Mag_F"";";
	};
	class JSt4r_RSC_Button_1608: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_65x39_caseless_mag"";";
	};
	class JSt4r_RSC_Button_1609: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_65x39_caseless_green_mag_Tracer"";";
	};
	/* class JSt4r_RSC_Button_1610: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.682 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addItem  ""FirstAidKit"";";
	}; */
	class JSt4r_RSC_Button_1611: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""20Rnd_762x51_Mag"";";
	};
	class JSt4r_RSC_Button_1612: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_762x39_Mag_F"";";
	};
	class JSt4r_RSC_Button_1613: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_65x39_caseless_mag"";";
	};
	class JSt4r_RSC_Button_1614: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_65x39_caseless_green_mag_Tracer"";";
	};
	/* class JSt4r_RSC_Button_1615: JSt4r_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.682 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeItem ""FirstAidKit"";";
	}; */
	class JSt4r_RSC_StructuredText_1101: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "7.62 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class JSt4r_RSC_StructuredText_1102: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "7.62 AK Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class JSt4r_RSC_StructuredText_1103: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "6.5 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class JSt4r_RSC_StructuredText_1104: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "Caseless 6.5 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	/* class JSt4r_RSC_StructuredText_1105: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "First Aids"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.682 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	}; */
  };
};

class jstar_veh
{
	idd = 634;
	name= "jstar_veh";
	onLoad = "_this execVM 'scripts\jstar_repair\jstar_menu.sqf'";
	controlsBackground[] = {Background};
	controls[] = {LocationSelect, TeleportText, Close};
	
	class Background: IGUIBack
	{
		idc = 2200;
		x = 0.421035 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.144769 * safezoneW;
		h = 0.252 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
	class TeleportText: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "Repair"; //--- ToDo: Localize;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.402 * safezoneH + safezoneY;
		w = 0.118447 * safezoneW;
		h = 0.042 * safezoneH;
		tooltip = "JSt4r_Veh"; //--- ToDo: Localize;
	};
	class Close: JSt4r_RSC_Button
	{
		idc = 1600;
		action = "closeDialog 1;";
		text = "x"; //--- ToDo: Localize;
		x = 0.559224 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.00658041 * safezoneW;
		h = 0.014 * safezoneH;
		tooltip = "Close"; //--- ToDo: Localize;
	};
	class LocationSelect: JSt4r_RSC_ListBox
	{
		idc = 518;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.118447 * safezoneW;
		h = 0.168 * safezoneH;
		onLBSelChanged = "[_this] execVM 'scripts\jstar_repair\jstar_options.sqf'";
	};
};

class jstar_respawn 
{
	idd = 500;
	name = "jstar_respawn";
	onLoad = "_this execVM ""scripts\jstar_teleport\jstar_menu.sqf""; escKeyEH = (_this select 0) displayAddEventHandler [""KeyDown"", ""if (((_this select 1) isEqualTo 1)) then {true};""];";
	controlsBackground[] = {Background, Background1};
	controls[] = {LocationSelect, TeleportText, Spawn};

	class Background: IGUIBack
	{
		idc = 2200;
		x = -0.0310938 * safezoneW + safezoneX;
		y = -0.00599999 * safezoneH + safezoneY;
		w = 1.05843 * safezoneW;
		h = 1.056 * safezoneH;
		colorBackground[] = {0.5,0.5,0.5,1};
	};
	class Background1: IGUIBack
	{
		idc = 2200;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.379 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.253 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
	class TeleportText: JSt4r_RSC_StructuredText
	{
		idc = 1100;
		text = "Respawn"; //--- ToDo: Localize;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.39 * safezoneH + safezoneY;
		w = 0.111867 * safezoneW;
		h = 0.042 * safezoneH;
		tooltip = "JSt4r_Respawn"; //--- ToDo: Localize;
	};
	class LocationSelect: JSt4r_RSC_ListBox
	{
		idc = 518;
		onLBSelChanged = "[_this] execVM 'scripts\jstar_teleport\jstar_move.sqf'";
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.125028 * safezoneW;
		h = 0.182 * safezoneH;
	};
	class Spawn: JSt4r_RSC_Button
	{
		idc = 1602;
		action = "closeDialog 1;";
		text = "Back To Spawn"; //--- ToDo: Localize;
		x = 0.448438 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.0929352 * safezoneW;
		h = 0.033 * safezoneH;
	};
};
