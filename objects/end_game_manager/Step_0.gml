/// @description Insert description here
// You can write your code in this editor

#macro END_STATE_TIMER 180
#macro SHOW_CREW_TIMER 20

switch(endState)
{
	case endStates.text1:
		nextStateTimer++;
		if(nextStateTimer > END_STATE_TIMER)
		{
			endState=endStates.text2;
			nextStateTimer=0;
		}
		break;
	case endStates.text2:
		nextStateTimer++;
		if(nextStateTimer > END_STATE_TIMER)
		{
			endState=endStates.showingCrew;
			nextStateTimer=0;
		}
		break;
	case endStates.showingCrew:
		nextCrewTimer++;
		if(nextCrewTimer > SHOW_CREW_TIMER)
		{
			nextCrewTimer=0
			if(crewShown >= global.perished)
			{
				endState=endStates.text3;
			}
			else
			{
				crewShown++;
				audio_play_sound(snd_torpedo_explosion, 5, false);
			}
		}
		break;
	case endStates.text3:
		nextStateTimer++;
		if(nextStateTimer > END_STATE_TIMER)
		{
			nextStateTimer = END_STATE_TIMER;
		}
		break;
	default:
}