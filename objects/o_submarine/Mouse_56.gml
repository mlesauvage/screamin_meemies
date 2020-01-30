/// @description Insert description here
// You can write your code in this editor

#macro TOO_CLOSE 50
#macro FAR_TARGET_DIST 200

if(!global.inMenu)
	if(global.torpedoesLoaded==0)
		return;
	
var targX = mouse_x;
var targY = mouse_y;

var subAngInRads = GetRadians(image_angle);

var spawnX = x + sprite_xoffset*cos(subAngInRads);
var spawnY = y - sprite_xoffset*sin(subAngInRads);

//Clicked very close to the sub, extend the targeting out.
if(point_distance(x, y, mouse_x, mouse_y) < TOO_CLOSE)
{
	var targetAngle = point_direction(x, y, mouse_x, mouse_y)*pi/180;
	targX = x + FAR_TARGET_DIST*cos(targetAngle);
	targY = y - FAR_TARGET_DIST*sin(targetAngle);
}

with(instance_create_layer(spawnX, spawnY, "projectiles_layer", o_torpedo))
{
	//Launch torp pointed in same direction as the sub
	image_angle = other.image_angle;
	targetX = targX;
	targetY = targY;
}

if(!global.inMenu)
	global.torpedoesLoaded--;