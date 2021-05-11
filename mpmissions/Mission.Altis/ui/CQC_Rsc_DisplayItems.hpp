/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_DisplayItems {
  idd = 10022;
  class controls {
	class CQC_RSC_IGUIBack_2200: CQC_RSC_IGUIBack
	{
		idc = 2200;
		x = 0.414455 * safezoneW + safezoneX;
		y = 0.388 * safezoneH + safezoneY;
		w = 0.144769 * safezoneW;
		h = 0.336 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
	class CQC_RSC_StructuredText_1100: CQC_RSC_StructuredText
	{
		idc = 1100;
		text = "Item Menu"; //--- ToDo: Localize;
		x = 0.434196 * safezoneW + safezoneX;
		y = 0.402 * safezoneH + safezoneY;
		w = 0.105287 * safezoneW;
		h = 0.042 * safezoneH;
		tooltip = "JSt4r_Item_Menu"; //--- ToDo: Localize;
	};
	class CQC_RSC_Button_1602: CQC_RSC_Button
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
	class CQC_RSC_Button_1606: CQC_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""20Rnd_762x51_Mag"";";
	};
	class CQC_RSC_Button_1607: CQC_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_762x39_Mag_F"";";
	};
	class CQC_RSC_Button_1608: CQC_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_65x39_caseless_mag"";";
	};
	class CQC_RSC_Button_1609: CQC_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addMagazine ""30Rnd_65x39_caseless_green_mag_Tracer"";";
	};
	/* class CQC_RSC_Button_1610: CQC_RSC_Button
	{
		idc = 1600;
		text = "+"; //--- ToDo: Localize;
		x = 0.532902 * safezoneW + safezoneX;
		y = 0.682 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player addItem  ""FirstAidKit"";";
	}; */
	class CQC_RSC_Button_1611: CQC_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""20Rnd_762x51_Mag"";";
	};
	class CQC_RSC_Button_1612: CQC_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_762x39_Mag_F"";";
	};
	class CQC_RSC_Button_1613: CQC_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_65x39_caseless_mag"";";
	};
	class CQC_RSC_Button_1614: CQC_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeMagazine ""30Rnd_65x39_caseless_green_mag_Tracer"";";
	};
	/* class CQC_RSC_Button_1615: CQC_RSC_Button
	{
		idc = 1600;
		text = "-"; //--- ToDo: Localize;
		x = 0.427616 * safezoneW + safezoneX;
		y = 0.682 * safezoneH + safezoneY;
		w = 0.0131608 * safezoneW;
		h = 0.028 * safezoneH;
		action = "player removeItem ""FirstAidKit"";";
	}; */
	class CQC_RSC_StructuredText_1101: CQC_RSC_StructuredText
	{
		idc = 1100;
		text = "7.62 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.458 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class CQC_RSC_StructuredText_1102: CQC_RSC_StructuredText
	{
		idc = 1100;
		text = "7.62 AK Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.514 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class CQC_RSC_StructuredText_1103: CQC_RSC_StructuredText
	{
		idc = 1100;
		text = "6.5 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.57 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	class CQC_RSC_StructuredText_1104: CQC_RSC_StructuredText
	{
		idc = 1100;
		text = "Caseless 6.5 Mags"; //--- ToDo: Localize;
		x = 0.447357 * safezoneW + safezoneX;
		y = 0.626 * safezoneH + safezoneY;
		w = 0.0789649 * safezoneW;
		h = 0.028 * safezoneH;
	};
	/* class CQC_RSC_StructuredText_1105: CQC_RSC_StructuredText
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