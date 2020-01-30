/// @description Insert description here
// You can write your code in this editor
#macro MENU_TIME_BUBBLE_SPAWN 30

#region Volume Boost Display
if(blinking)
{
	blinkTimer++;
	if(blinkVisible && blinkTimer > 40)
	{
		blinkVisible=false;
		blinkTimer=0;
	}
	else if(!blinkVisible && blinkTimer > 10)
	{
		blinkVisible=true;
		blinkTimer=0;
	}
}
else
	blinkVisible=true;
#endregion

#region Ghost Tracker
if(global.inMenuGhostsKilled >3 || keyboard_check_released(vk_space))
{
	room_goto(game_room);
	global.inMenu = false;
}
#endregion	

#region Microphone Controls
//Handle +/- presses to change microphone gain.
if(keyboard_check_released(187) || keyboard_check_released(vk_add))
{
	global.micGain++;
	blinking=false;
}

if(keyboard_check_released(189) || keyboard_check_released(vk_subtract))
{
	global.micGain--
	blinking=false;
}

global.micGain = clamp(global.micGain, 1, 20);


//Handle left/right arrow presses to change the recording device
if(keyboard_check_released(vk_right))
{
	var nextDevice = global.recordingFrom+1;
	if(nextDevice >= array_length_1d(micInfo))
		nextDevice=0;
	global.switchToMicrophone = nextDevice;
}

if(keyboard_check_released(vk_left))
{
	var nextDevice = global.recordingFrom-1;
	if(nextDevice <0)
		nextDevice = array_length_1d(micInfo)-1;
	global.switchToMicrophone = nextDevice;

}
#endregion

#region Bubbles
bubbleTimer++
if(bubbleTimer > MENU_TIME_BUBBLE_SPAWN)
{
	instance_create_layer(0, 0, "bubbles_layer", o_bubble)
	bubbleTimer=0;
}
#endregion