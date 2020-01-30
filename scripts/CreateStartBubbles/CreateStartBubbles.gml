/// @function CreateStartBubbles(numBubbles)
/// @description Creates a number of starting bubbles and positions them across the y axis randomly.


//Hard coded room dimensions because jam game dear lord.
var numBubbles = argument0;

var yIntercept=0;
var bub;

for(var i=0; i<numBubbles; i++)
{
	bub=instance_create_layer(0, 0, "bubbles_layer", o_bubble)
	yIntercept = GetYIntercept(bub.x);
	bub.y=random_range(yIntercept,0);
}
