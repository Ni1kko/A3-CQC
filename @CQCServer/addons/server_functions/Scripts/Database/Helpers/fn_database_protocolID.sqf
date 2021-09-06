/*
	Nikko Renolds | Ni1kko@outlook.com
	FragSquad CQC
*/

_arr = []; 
for "_i" from 1 to 7 do { 
	_arr pushBack (((toArray "0") select 0) + floor(random(((toArray "9") select 0) - ((toArray "0") select 0))));
}; 
(toString _arr);