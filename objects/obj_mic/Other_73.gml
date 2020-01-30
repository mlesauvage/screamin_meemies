/// @description Get audio volume

//Get length of audio and copy part of buffer
len = async_load[? "data_len"];
buffer_seek(audio_buffer,buffer_seek_start,0);
buffer_copy(async_load[? "buffer_id"], 0, len, audio_buffer, 0);

//Alpha used for lowpass
var alpha = 0.003;
/** Looping through PCM output **/
for (var i = 0;i < len/16; i++) {
    var us = buffer_read(audio_buffer, buffer_s16);
    us = abs(us);
    
    /** Lowpass **/
    if (us_old == -1) us_old = us;
    us = alpha * us + (1.0 - alpha) * us_old;
    us_old = us;
    /**/
    
	//Audio data is a signed, 16-bit integer, so can go from -32,768 to +32,767
	//us has used abs() to remove the sign, so it is from 0->32,768
	//Dividing by 320 gives a range roughly from 0->100
    global.microphone_volume = clamp(us/320, 0, 100);
    if (drawing)
        ds_list_insert(graph,0,us);
    
}

timeSinceLastAudioUpdate = current_time - lastAudioTime;
lastAudioTime = current_time;


/* */
/*  */
