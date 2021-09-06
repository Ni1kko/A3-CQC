/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_MuteIcon {
	idd = 1000;
	movingEnable=0;
	duration=1e+011;
	onLoad = "uiNamespace setVariable ['CQC_Rsc_MuteIcon', _this select 0];";

	class controls {
		class Icon : CQC_RscHudIcon {
			idc = 1101;
			text = "icons\muted.paa";
			x = 0.95575 * safezoneW + safezoneX;
			y = 0.624 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};