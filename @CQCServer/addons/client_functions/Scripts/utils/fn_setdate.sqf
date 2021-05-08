nightWeapons = 1;
nightVision = nightVisionParam;
if (isServer) then
{
	switch (nightOrDay) do
	{
		case 0:
		{
			setDate [1985, 8, 30, 9, 0];
			nightWeapons = 0;
			nightVision = -1;
		};
		case 1:
		{
			
			setDate [1985, 12, 13, 4, 40];
		};
		case 2:
		{
			//setDate [1985, 7, 12, 2, 0];
		};
		case 3:
		{
		
			setDate [1985, 10, 8, 2, 0];
		};
		case 4:
		{
			setDate [1985, 1, 1, 0, 0];
		};
	};
};