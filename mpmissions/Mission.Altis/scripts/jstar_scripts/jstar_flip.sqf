["Unflipping vehicle in 5 seconds stand back! (Stay within 20 metres)"] spawn CQC_fnc_Notification;
sleep 5;

// Locate nearby vehicle.
_veh = nearestobjects [player,["car","motorcycle","tank","air"],20];   
// Flip vehicle 0.5m above ground. 
{ 
   _newPos = getPos _x;                          // get the position of the current vehicle in the array 
   _newPos set [2, (_newPos select 2)+0.5];   // add 0.5m to Z-Coord 

   _x setPos _newPos;                             // set the new position 
} forEach _veh; 

["Vehicle Unflipped"] spawn CQC_fnc_Notification;