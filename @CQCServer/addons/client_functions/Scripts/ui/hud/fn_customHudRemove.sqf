showHUD [true, true, true, true ,true, true, true, true];
//terminate hudLoop;
{
	ctrlDelete ((findDisplay 46) displayCtrl _x)
} forEach [1,2,3,4,6,7,8,9,10,11,12,13,14];