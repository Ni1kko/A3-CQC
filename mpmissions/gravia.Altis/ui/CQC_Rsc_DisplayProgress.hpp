/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_DisplayProgress
{
	type = 8;
	style = 0;
	idc = -1;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.1;
	y = 0.1;
	w = 1;
	h = 0.03;
};