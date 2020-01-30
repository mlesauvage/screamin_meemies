/// @description Insert description here
// You can write your code in this editor

#macro SUB_SPEED_SLOWDOWN 0.997
#macro SUB_MAX_SPEED 2.5
#macro SUB_ACCELERATION 0.02
#macro SUB_BOUNDS_ACCELERATION 0.08
#macro SUB_BOUNDS_PIXEL_BUFFER 30
#macro SUB_ROTATION 1.5
#macro SUB_PING_INTERVAL 60
#macro SUB_PING_VOLUME 15
#macro SUB_PROPELLER_ANIMATION_NOT_DRIVING 0.8
#macro SUB_PROPELLER_ANIMATION_MIN_SPEED 0.3

#region Submarine Movement
speed=speed*SUB_SPEED_SLOWDOWN;

var facingRight = false;
var playerDriving = false;
var angle = image_angle;
var diveOrClimb = false;

if(mouse_check_button(mb_right))
{

	angle = point_direction(x, y, mouse_x, mouse_y);

	playerDriving = true;
}
//else
//{
	
//	if((image_angle >= 0 && image_angle <=90) || (image_angle >=270 && image_angle <=360))
//	{
//		facingRight = true;
//	}

//	//Handle elevators first.
//	if(keyboard_check(ord("W")) || keyboard_check(vk_up))
//	{
//		if(facingRight)
//			angle += SUB_ROTATION;
//		else
//			angle -= SUB_ROTATION;
//		playerDriving = true;
//		diveOrClimb = true;
//	}
//	else if(keyboard_check(ord("S")) || keyboard_check(vk_down))
//	{
//		if(facingRight)
//			angle -= SUB_ROTATION;
//		else
//			angle += SUB_ROTATION;
//		playerDriving = true;
//		diveOrClimb = true;
//	}

//	//Now left/right. If they're not changing elevation, then flatten.
//	if(keyboard_check(ord("A")) || keyboard_check(vk_left))
//	{
//		if(facingRight)
//			angle = 180-image_angle;
//		playerDriving = true;
	
//		if(!diveOrClimb) //Only horizontal, so return to level.
//		{
//			var diff = angle_difference(180, angle)
//				angle += SUB_ROTATION * sign(diff);
//		}
//	}
//	else if(keyboard_check(ord("D")) || keyboard_check(vk_right))
//	{
//		if(!facingRight)
//			angle = 180-image_angle;
//		playerDriving = true;

//		if(!diveOrClimb) //Only horizontal, so return to level.
//		{
//			var diff = angle_difference(0, angle)
//				angle += SUB_ROTATION * sign(diff);
//		}

//	}
//}

if(playerDriving)
{
	//Constrain the calculations from 0..359.999
	if(angle < 0)
		angle+=360;
	angle = angle % 360;

	//Constrain to reasonable submarine angles (not too steep);
	
	if(angle > 50 && angle <90)
		angle = 50;
	else if(angle > 90 && angle <130)
		angle=130;
	else if(angle > 230 && angle < 270)
		angle = 230;
	else if(angle > 270 && angle < 310)
		angle = 310;
	
	image_angle = angle;

	//Add speed based on angle sub is pointing
	motion_add(image_angle, SUB_ACCELERATION);

	if(speed > SUB_MAX_SPEED)
		speed = SUB_MAX_SPEED;

	image_speed = 1; //For animation.
}
else
{
	image_speed = clamp(speed/SUB_MAX_SPEED*SUB_PROPELLER_ANIMATION_NOT_DRIVING,0,1);
	if(image_speed < SUB_PROPELLER_ANIMATION_MIN_SPEED)
		image_speed=0;
}

//Change the image from the sprite sheet based on facing.
if((image_angle >= 0 && image_angle <=90) || (image_angle >=270 && image_angle <=360))
	sprite_index = spr_submarine_right;
else
	sprite_index = spr_submarine_left;


#endregion

#region Submarine Audio
if(playerWasDriving)
{
	if(!playerDriving)
		audio_sound_gain(subSound,0,1500);
}
else
{
	if(playerDriving)
		audio_sound_gain(subSound,1,500);
}
playerWasDriving = playerDriving;

#endregion

#region Collisions
var collided=false;
if(x-SUB_BOUNDS_PIXEL_BUFFER<GetXIntercept(y,true))
{
	motion_add(0, SUB_BOUNDS_ACCELERATION);
	collided=true;
}
else if(x+SUB_BOUNDS_PIXEL_BUFFER>GetXIntercept(y,false))
{
	motion_add(180, SUB_BOUNDS_ACCELERATION);
	collided=true;
}
if(y<10)
{
	motion_add(270, SUB_BOUNDS_ACCELERATION);
	//Play a sploosh sound?
}
else if(!global.inMenu && y>2690)
{
	motion_add(90, SUB_BOUNDS_ACCELERATION);
	collided=true;
}
else if(global.inMenu && y>890)
{
	motion_add(90, SUB_BOUNDS_ACCELERATION);
	collided=true;
}
if(collided)
{
	if(!wasInCollision)
	{
		audio_play_sound(snd_collision, 5, false);
	}
	wasInCollision=true;
}
else
{
	wasInCollision=false;
}

#endregion

#region Pinging

pingTimer++;
if(!pingReady && pingTimer > SUB_PING_INTERVAL)
{
	pingReady = true;
	pingTimer=0;
}

if(global.microphone_volume*global.micGain > SUB_PING_VOLUME && pingReady)
{
	global.usedPing=true;
	effect_create_above(ef_ring, x, y, 2, $C4F0C2);
	pingReady = false;
	pingTimer=0;
	with(o_ghost)
	{
		pinged=true;
		pingedDistance=point_distance(x, y, other.x, other.y);
	}
}

#endregion

#region Depth Sounds
if(!reachedDepthOneThird && y>900)
{
	reachedDepthOneThird=true;
	audio_play_sound(snd_depth_one_third, 1, false);
}
else if(!reachedDepthTwoThirds && y>1800)
{
	reachedDepthTwoThirds=true;
	audio_play_sound(snd_depth_two_thirds, 1, false);
}
#endregion