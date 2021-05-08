/*
#   Author: Frag Squad CQC Development Team
#   Description: Displays all the options.
#   For: Frag Squad CQC
*/

#include "common.hpp"
#include "jstar_defines.hpp"
#include "jstar_dialogs.hpp"
#include "infiSTAR_AdminMenu.hpp"
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