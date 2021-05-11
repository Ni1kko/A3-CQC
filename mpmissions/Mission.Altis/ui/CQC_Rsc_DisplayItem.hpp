/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_DisplayItem
{
	idd = 500;
	name= "jstar_itemmenu";
	onLoad = "_this spawn CQC_fnc_itemmenu";
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
		onLBSelChanged = "[_this] spawn CQC_fnc_options";
	};

};