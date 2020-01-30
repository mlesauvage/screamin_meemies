/// @description Insert description here
// You can write your code in this editor

global.inMenuGhostsKilled=0;
global.inMenu=true;

blinkTimer=0;
blinkVisible=true;
blinking=true;
bubbleTimer=0;

instructions=array_create(5);
instructions[0]="It is Cursemas Eve. Hell's wrath is bubbling up from the depths to consume humanity.";
instructions[1]="";
instructions[2]="PILOT YOUR SUBMARINE to the deep (hold right click)."
instructions[3]="Use your TORPEDOES (left click) to destroy ghosts and the HELLMOUTH.";
instructions[4]="Ghosts are invisible! Find them with your sonar by yelling PING!";
instructions[5]="";
instructions[6]="Your sonar is powered by an ectoplamtic engine that requires you to SACRIFICE a crew member.";
instructions[7]=""

audio_play_sound(snd_music, 20, true);

var deviceCount = audio_get_recorder_count();
micInfo = array_create(deviceCount);

for(var i=0; i<deviceCount; i++)
{
	micInfo[i] = audio_get_recorder_info(i)
}

CreateStartBubbles(170);