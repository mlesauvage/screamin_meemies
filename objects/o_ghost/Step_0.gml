/// @description Insert description here
// You can write your code in this editor

#macro GHOST_BOUNCE_SPEED 0.5
#macro GHOST_WAX_WANE_TIMER 60
#macro GHOST_FADE_RATE 0.97
#macro GHOST_HOLD_VISIBLE_TIMER 90
#macro GHOST_PING_DROPOFF_RANGE 800
#macro GHOST_PING_MAX_POWER_RANGE 100
#macro GHOST_SPEED_MIN 1
#macro GHOST_SPEED_MAX 1.5
#macro GHOST_ATTACK_DISTANCE 20
#macro GHOST_ATTACK_TIME 20
#macro GHOST_MAX_CRUISE_TIME 360
#macro GHOST_SEEK_DISTANCE 300

if(!global.inMenu)
{
	
#region Handle Movement

var angleToSub = point_direction(x, y, o_submarine.x, o_submarine.y);
var angleToSubRadians = GetRadians(angleToSub);


if(seeking) //They are faster during the attack.
{
	x += selectedSpeed*cos(angleToSubRadians);
	y -= selectedSpeed*sin(angleToSubRadians);
}
else if(attacking)
{
	x += SUB_MAX_SPEED*cos(angleToSubRadians);
	y -= SUB_MAX_SPEED*sin(angleToSubRadians);
}
else
{
	var cruisingDirectionRadians=GetRadians(cruisingDirection);
	x += selectedSpeed*cos(cruisingDirectionRadians);
	y -= selectedSpeed*sin(cruisingDirectionRadians);

	var distToSub = point_distance(x, y, o_submarine.x, o_submarine.y);
	if(distToSub < GHOST_SEEK_DISTANCE)
	{
		seeking=true;
	}
	
	cruiseTimer++;
	if(cruiseTimer > GHOST_MAX_CRUISE_TIME)
	{
		seeking=true;
	}
	
	angleToSub = cruisingDirection;
}

//Handle ghost "bouncy" movement.
waxWaneTimer++;
if(waxWaneTimer > GHOST_WAX_WANE_TIMER)
{
	waxing = !waxing;
	waxWaneTimer = 0;
}

if((angleToSub > 45 && angleToSub < 135) || (angleToSub > 225 && angleToSub < 315))
{

	if(waxing)
		x += GHOST_BOUNCE_SPEED;
	else
		x-= GHOST_BOUNCE_SPEED;
}
else
{
	if(waxing)
		y += GHOST_BOUNCE_SPEED;
	else
		y-= GHOST_BOUNCE_SPEED;
}
#endregion

#region Handle Attacking

var dist = distance_to_point(o_submarine.x, o_submarine.y);
if(attacking)
{
	attackTimer++;
	if(attackTimer > GHOST_ATTACK_TIME)
	{
		global.ghostsAttacked++;
		instance_destroy();
	}
}
else if(dist < GHOST_ATTACK_DISTANCE)
{
	attacking=true;
	attackTimer=0;
	audio_play_sound(snd_ghost_attack, 20, false);
}

#endregion

}

#region Handle fading in/out
if(pinged)
{
	pingHoldTimer=0;
	pinged = false;
	if(pingedDistance > GHOST_PING_MAX_POWER_RANGE)
	{
		var dropoff = (pingedDistance-GHOST_PING_MAX_POWER_RANGE)/GHOST_PING_DROPOFF_RANGE
		dropoff = 1-clamp(dropoff, 0, 1);
		image_alpha=dropoff;
	}
	else
	{
		image_alpha=1;
	}
}
if(pingHoldTimer < GHOST_HOLD_VISIBLE_TIMER)
{
	pingHoldTimer++;
}
else
{
	image_alpha *= GHOST_FADE_RATE;
}
if(attacking)
	image_alpha = 1;

#endregion
