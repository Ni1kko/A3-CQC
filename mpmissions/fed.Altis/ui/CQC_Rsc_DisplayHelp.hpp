/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

class CQC_Rsc_DisplayHelp {
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