/*
	Author: Chris(tian) "infiSTAR" Lorenzen
	Contact: infiSTAR23@gmail.com // www.infiSTAR.de
	
	Copyright infiSTAR - 2011 - 2019. All rights reserved.
	Christian (Chris) L. (infiSTAR23@gmail.com) Developer of infiSTAR
*/
class CfgPatches
{
	class a3_infiSTAR
	{
		requiredVersion = 0.0;
		requiredAddons[] = {};
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
		author[]= {"Chris(tian) 'infiSTAR' Lorenzen"};
		website[]= {"https://infiSTAR.de"};
		contact[]= {"admin@infiSTAR.de","infiSTAR23@gmail.com"};
		version = 'v0260';
		licensed = "no.no@no";
	};
};
class CfgFunctions
{
	class a3_infiSTAR
	{
		class main
		{
			file = "a3_infiSTAR";
			class postInit { postInit = 1; };
		};
	};
};