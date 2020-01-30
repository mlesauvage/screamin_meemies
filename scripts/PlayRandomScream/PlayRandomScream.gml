/// @function PlayRandomScream()
/// @description Plays one crew scream at random.


var soundToPlay=choose(snd_scream_a, snd_scream_b, snd_scream_c, snd_scream_d, snd_scream_e, snd_scream_f);
return audio_play_sound(soundToPlay, 5, false);
