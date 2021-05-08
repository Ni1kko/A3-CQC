class ProgressBaseTextHUD
{
	access = 0;
	type = CT_STATIC;
	style = ST_CENTER;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,0.8};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0;
	w = 0;
	shadow = 2;
	font = "puristaMedium";
	sizeEx = "0.035";  
};
class RscProgressBar 
{
	type = 8;
	style = 0;
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	texture = "";
	shadow = 2;
	colorFrame[] = {0, 0, 0, 1};
	colorBackground[] = {0,0,0,0.7};
	colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
};
class MyProgressBar2
{
	name = "MyProgressBar2";
	idd = 37200;
	fadein=0;
	duration = 99999999999;
	fadeout=0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable ['PBarProgress',_this select 0];";
	class Controls
	{
﻿		class background: ProgressBaseTextHUD
		{
			idc = 37201;

			x = 0.292948 * safezoneW + safezoneX;
			y = 0.72101 * safezoneH + safezoneY;
			w = 0.65; h = 0.05;
			colorBackground[] = {0,0,0,0.7};
		};
		class Progress: RscProgressBar
		{
			idc = 37202;

			x = 0.292948 * safezoneW + safezoneX;
			y = 0.72101 * safezoneH + safezoneY;
			w = 0.65; h = 0.05;
		};
		class ProgressText: ProgressBaseTextHUD
		{
			idc = 37203;
	
			text = "$STR_DIALOG_PROGRESS_FUEL";
			x = 0.420365 * safezoneW + safezoneX;
			y = 0.72101 * safezoneH + safezoneY;
			w = 0.286687 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
	};
};