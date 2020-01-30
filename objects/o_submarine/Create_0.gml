/// @description Insert description here
// You can write your code in this editor
pingTimer = 0;
pingReady = true;
playerWasDriving=false;
wasInCollision=false;
reachedDepthOneThird=false;
reachedDepthTwoThirds=false;

subSound=audio_play_sound(snd_submarine_powered, 5, true);
audio_sound_gain(subSound,0,0);
