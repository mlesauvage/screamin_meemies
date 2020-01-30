/// @description Insert description here
// You can write your code in this editor

#macro TORP_CLOSE_ENOUGH 3
#macro TORP_TURN_RATE 4
#macro TORP_MAX_SPEED 4
#macro TORP_SLOW_ACCEL .03
#macro TORP_FAST_ACCEL .1
#macro TORP_EXPLOSION_RADIUS 70
#macro TORP_TRIGGER_RADIUS 20
#macro TORP_HELLMOUTH_SHIELD_MIN_DIST 285 //Had to determine these empirically.
#macro TORP_HELLMOUTH_SHIELD_MAX_DIST 300

#region Movement
//Rotate towards target
if(seeking)
{
	var targetAngle = point_direction(x, y, targetX, targetY);
	var turnRemaining = angle_difference(image_angle, targetAngle);
	
	if(abs(turnRemaining) < TORP_CLOSE_ENOUGH)
	{
		seeking = false;
		image_angle = targetAngle;
		motion_set(image_angle, speed);
	}
	else
	{
		image_angle -= sign(turnRemaining)*TORP_TURN_RATE;
		motion_add(image_angle, TORP_SLOW_ACCEL);
	}
}
else
{
	motion_add(image_angle, TORP_FAST_ACCEL);
}

if(speed > TORP_MAX_SPEED)
	speed = TORP_MAX_SPEED;
#endregion

#region Proximity Explosion

var explosionTarget = instance_nearest(x, y, o_ghost);
if(explosionTarget != noone)
{
	var dist = distance_to_object(explosionTarget);

	if(dist < TORP_TRIGGER_RADIUS)
	{
		with(o_ghost) //Fuck it, just check them all.
		{
			dist = distance_to_object(other);
			if(dist < TORP_EXPLOSION_RADIUS)
				instance_destroy();
		}
		
		exploded=true;
		instance_destroy();
	}
}

//This was the code before I tried to make a HTML5 build.
//It was fine on windows, but due to how object destruction is handled on 
//the other platform, created an infinite loop.

//var explosionTarget = instance_nearest(x, y, o_ghost);
//if(explosionTarget != noone)
//{
//	var dist = distance_to_object(explosionTarget);

//	if(dist < TORP_TRIGGER_RADIUS)
//	{
//		exploded=true;
//		instance_destroy();
//		instance_destroy(explosionTarget);
//		var moreTargets = true;

//		while(moreTargets)
//		{
//			explosionTarget = instance_nearest(x, y, o_ghost);
//			if(explosionTarget == noone) //No more enemies in room;
//			{
//				moreTargets = false;
//			}
//			else
//			{
//				dist = distance_to_object(explosionTarget);
		
//				if(dist < TORP_EXPLOSION_RADIUS)
//				{
//					instance_destroy(explosionTarget);
//				}
//				else
//				{
//					moreTargets = false;
//				}
//			}
//		}
//	}
//}


#endregion

#region Bounds Detection

var impactBounds=false
if(x<GetXIntercept(y,true))
	impactBounds=true;
else if(x>GetXIntercept(y,false))
	impactBounds=true;
else if(y>2699)
	impactBounds=true;
else if(y<0)
	instance_destroy();

if(!global.inMenu)
{
	var distToHellmouth = distance_to_point(o_hellmouth.x, o_hellmouth.y);

	if(distToHellmouth >TORP_HELLMOUTH_SHIELD_MIN_DIST && distToHellmouth < TORP_HELLMOUTH_SHIELD_MAX_DIST)
		impactBounds = true;
}

if(impactBounds)
{
	impactedBounds=true;
	instance_destroy();
}

#endregion