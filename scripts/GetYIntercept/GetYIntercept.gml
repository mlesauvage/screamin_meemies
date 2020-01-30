/// @function GetYIntercept(x)
/// @description Returns the y intercept based on x position
/// @param x The x position across the game.


//Hard coded room dimensions because jam game dear lord.
var posX=argument0;

if(posX < 400)
	return posX*6.75
else if(posX < 1200)
	return 2700;
else
	return 2700-(posX-1200)*6.75;
