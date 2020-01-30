/// @description HOW TO USE

/*

    1. Disable or enable drawing in the script below
    2. Add this object to a room and make it persistent if desired.
    3. Get microphone_volume from this object. It contains the volume.

*/

/* */
///Begin audio recording - DISABLE DRAWING HERE!!

//Disable or enable drawing of the graph
//Beware that the list is never shortened and this slows everything down FAST
drawing = false;
if (drawing)
    graph = ds_list_create();

global.microphone_volume = 0;
us_old = -1;
//Begin audio recording and create buffer and graph
if (audio_get_recorder_count() == 0) {
    //There is no microphone or recording is not supported.
    exit;
}

//Use this buffer irrespecitve of which device is being recorded.
audio_buffer = buffer_create(4800*2, buffer_fixed, 2);

if(audio_get_recorder_count() < global.recordingFrom+1)
{
	global.recordingFrom = 0;
	global.switchToMicrophone=0;
}
else
{
	global.switchToMicrophone=global.recordingFrom;
}

audioIndex=audio_start_recording(global.recordingFrom);

	


lastFrameTime = current_time;
timeSinceLastAudioUpdate = current_time;
lastAudioTime = current_time;
