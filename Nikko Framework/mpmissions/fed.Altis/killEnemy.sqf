Google_Degen_Init = {
[] call Google_Degen_Disable;
Google_Degen_S = [] spawn {
 	hint "You have entered the enemy's spawn region of protection! Leave or die!";
	sleep 2;
while{true} do {
_hp = getDammage player; // Assign HP the current value of your HP (Likely to be 100)
_hp = _hp + 0.2; // Re assign HP a new value of -10 HP

player setDamage _hp; //player setDamage _hp; // Setting the player's HP to the previous variable we just mentioned
sleep 1; // waiting a second until the whole script runs again
};
};
};

Google_Degen_Enable = {
[] call Google_Degen_Init;
};

Google_Degen_Disable = {
terminate Google_Degen_S;
};