/* 
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-05-15 06:41:02
* @Last Modified by:   DnA
* @Last Modified time: 2014-09-25 08:48:54
*/

#define true 1
#define false 0
#include "ui\config.hpp"

class NMD_CfgVehicleSkins {

	// Ifrit
	class O_MRAP_02_F {
		class Skin0 {
			displayName = "Purple Ifrit (VIP)";
			textures[] = { "Skins\PurpleIfrit\1.jpg", "Skins\IfritBlackBack.jpg" };
			VIP = true;
		};

		class Skin1 {
			displayName = "Red Ifrit (VIP)";
			textures[] = { "Skins\RedIfrit\1.jpg", "Skins\IfritBlackBack.jpg" };
			VIP = true;
		};

		class Skin2 {
			displayName = "George Floyd Ifrit (VIP)";
			textures[] = { "Skins\GFloydIfrit\1.jpg", "Skins\GFloydIfrit\2.jpg" };
			VIP = true;
		};

		class Skin3 {
			displayName = "Bang Energy Ifrit (VIP)";
			textures[] = { "Skins\BangIfrit\1.jpg", "Skins\BangIfrit\2.jpg" };
			VIP = true;
		};
	};

	// Qilin (Unarmed)
	class O_T_LSV_02_unarmed_F {
		class Skin0 {
			displayName = "Brazzers Qilin (VIP)";
			textures[] = { "Skins\BrazzersQilin\1.jpg", "Skins\BrazzersQilin\2.jpg", "Skins\BrazzersQilin\3.jpg" };
			VIP = true;
		};

		class Skin1 {
			displayName = "Monster Qilin (VIP)";
			textures[] = { "Skins\MonsterQilin\1.jpg", "Skins\MonsterQilin\2.jpg", "Skins\MonsterQilin\3.jpg" };
			VIP = true;
		};
	};
	
	// Hunter
	class B_MRAP_01_F {
		class Skin0 {
			displayName = "James Charles Hunter (VIP)";
			textures[] = { "Skins\JCharlesHunter\1.jpg", "Skins\JCharlesHunter\2.jpg" };
			VIP = true;
		};

		class Skin1 {
			displayName = "";
			textures[] = { "", "" };
			VIP = true;
		};
	};
};