/// @description Insert description here
// You can write your code in this editor

if(exploded)
{
	effect_create_above(ef_explosion, x, y, 0, $1E606E);
	audio_play_sound(snd_torpedo_explosion, 5, false);
}
else if(impactedBounds)
{
	
	effect_create_above(ef_smoke, x, y, 0, c_white);
	audio_play_sound(snd_torpedo_impact, 5, false);
}
