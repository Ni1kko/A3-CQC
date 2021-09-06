/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

#define true 1
#define false 0

class CfgPatches
{
	class server_functions
	{
		name = "server_functions";
		author[] = {"Nikko"};
		requiredVersion = 2.04;
		requiredAddons[] = {"client_functions"};
		units[] = {};
		weapons[] = {};
		fileVersion = 0.050;
		antiHack = true;
	};
};

rptFileLimit=1;

class CfgFunctions
{
    class AutoCompile
	{
		class CfgBootstrap 
		{
			tag = "CQC";//Tag_fnc_example
			file = "\server_functions";
			fileClient = "\client_functions";
			dontCompile[] = {};//array of any files that you don't want too auto compile (if files is "fn_example.sqf" you would add "example" to the array | dontCompile[] = {"example"})
			compileFinal = true;//compileFinal = true | compile = false, can be useful for debuging

			///////////////////////////////////////////////////////////////////////////////////
			class preInit {preInit = true;};// Don't edit this loads the auto compile system //
			///////////////////////////////////////////////////////////////////////////////////
    	};
	};
	
	class CQC 
	{
		//--- Extremo Finite State Machine
        class FiniteStateMachine
		{
			file="\server_functions\FSM";
			class scheduler {ext=".fsm";};
		};
	};
};