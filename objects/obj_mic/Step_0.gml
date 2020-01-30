/// @description Insert description here
// You can write your code in this editor

if(global.switchToMicrophone != global.recordingFrom)
{
	if(audio_get_recorder_count() < global.switchToMicrophone+1)
	{
		global.recordingFrom = 0;
		global.switchToMicrophone=0;
	}
	else
	{
		global.recordingFrom = global.switchToMicrophone;
	}

audio_stop_recording(audioIndex);
	audioIndex=audio_start_recording(global.recordingFrom);
}
