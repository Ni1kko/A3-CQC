_currentdeath = profileNamespace getVariable "cqc_death";
_currentkills = profileNameSpace getVariable "cqc_kills";
_kda = _currentkills / _currentdeath;

profileNameSpace setVariable ["cqc_kda", _kda];