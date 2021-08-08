/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_PlayerHUD {
	idd = -1; 
	duration = 1e+1000; 
	fadeIn = 0; 
	fadeOut = 0; 
	onLoad = "uiNamespace setVariable ['CQC_Rsc_PlayerHUD', _this select 0];"; 
		
	class Controls {
		class jstar_credits {
			type = CT_STATIC;
			style = ST_CENTER;
			idc = 1003;
			text = " Frag Squad CQC";
			x = 0.00051252 * safezoneW + safezoneX;
			//x = -0.00531252 * safezoneW + safezoneX;
			y = 0.976 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			sizeEx = 0.03;
		};
		
		class alecw_playersnear {
			type = CT_STATIC;
			style = ST_LEFT;
			idc = 1004;
			text = "";
			x = 0.00512252 * safezoneW + safezoneX;
			y = 0.963 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			sizeEx = 0.03;
			class Attributes {align = "LEFT";};	
		};
	};
};