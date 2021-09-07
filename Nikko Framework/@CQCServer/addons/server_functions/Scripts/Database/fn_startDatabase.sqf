/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

if (isFinal "CQC_var_DatabaseLocked")exitWith{
    "Already Initialized" call CQC_fnc_database_log;
};

CQC_fnc_callExtDB = compileFinal (switch (true) do {
    case (('extDB3' callExtension '9:VERSION') != ''): {"'extDB3' callExtension _this"}; 
    case (('extDB2' callExtension '9:VERSION') != ''): {"'extDB2' callExtension _this"}; 
    case (('extDB' callExtension '9:VERSION') != ''): {"'extDB' callExtension _this"}; 
    default {"'[""DLL NOT FOUND"",false]'"};
});

//Version
private _hiveSetup = false;
private _version = ['VERSION'] call CQC_fnc_callDatabase;

if (typeName(_version) isEqualTo 'SCALAR') then
{ 
    if(_version > 1.030)then{
        "Starting" call CQC_fnc_database_log;
        uiNamespace setVariable ['CQC_var_DBInitialized', compileFinal str(true)];
        _hiveSetup = true;
    }else{
        "Failed to initialize - outdated" call CQC_fnc_database_log;
        uiNamespace setVariable ['CQC_var_DBInitialized', compileFinal str(false)]; 
    };
} else {
    "Failed to initialize" call CQC_fnc_database_log;
    uiNamespace setVariable ['CQC_var_DBInitialized', compileFinal str(false)];
};

if(_hiveSetup)then
{
    //Get a new random session ID
    uiNamespace setVariable ['CQC_var_DBprotocolID', compileFinal str([] call CQC_fnc_database_protocolID)];  

    try{
        //Add [Database] from extDB3 config as databaase
        if ((['ADD_DATABASE:Database'] call CQC_fnc_callDatabase) isEqualTo [0,"Database Connection Error"]) throw false;
        //Set Protocol for [Database] and (TEXT2) as SQL Option
        if ((['ADD_DATABASE_PROTOCOL:Database:SQL:' + (call(uiNamespace getVariable 'CQC_var_DBprotocolID')) + ':TEXT2'] call CQC_fnc_callDatabase) isEqualTo [0,"Failed to Load Protocol"]) throw false;
    } catch {
        _hiveSetup = _exception;
    };

    if(_hiveSetup)then{ 
        try{ 
            //Lock database
            if ((['LOCK'] call CQC_fnc_callDatabase) isEqualTo [0]) throw false;
        } catch {
            _hiveSetup = _exception;
        };

        if(_hiveSetup)then{
            //
            CQC_var_DatabaseLocked = compileFinal str(0 call CQC_fnc_getTimeDate);

            //Log succses
            (format["Online [v%1] Connection Established @ %2",_version,(call CQC_var_DatabaseLocked)]) call CQC_fnc_database_log;
        };
    };
};

_hiveSetup