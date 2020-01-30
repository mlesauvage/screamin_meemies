/// @description Insert description here
// You can write your code in this editor
#macro HELL_MAX_RED $FF
#macro HELL_MIN_RED $80
#macro HELL_MAX_HEALTH 6
#macro HELL_DAMAGE_SHAKE_TIMER 60

#region Manage Hellmouth Appearance
intensityTimer++;
if(intensityTimer > chosenTime)
{
	chosenTime = irandom_range(20, 90);
	intensityTimer=0;
	redIntensity = irandom_range(HELL_MIN_RED, HELL_MAX_RED);
	
	fadeModifier = choose(-1, 1);
}
redIntensity += fadeModifier;
if(redIntensity > HELL_MAX_RED)
	redIntensity = HELL_MAX_RED;
else if(redIntensity < HELL_MIN_RED)
	redIntensity = HELL_MIN_RED;
#endregion

#region Manage Hellmouth Health
if(torpImpacts > 0)
{
	hellmouthHealth = clamp(hellmouthHealth-torpImpacts, 0, HELL_MAX_HEALTH);
	torpImpacts = 0;
	if(!audio_is_playing(snd_hellmouth_hurt_heavy))
	audio_play_sound(snd_hellmouth_hurt_heavy, 50, false);
	hellmouthShakeCountdownTimer = HELL_DAMAGE_SHAKE_TIMER;
}

if(hellmouthShakeCountdownTimer > 0)
{
	if(hellmouthShakeCountdownTimer%3 == 0)
	{
		xShake = irandom_range(-3, 3);
		yShake =  irandom(5);
	}
	hellmouthShakeCountdownTimer--;
}
else
{
	xShake=0;
	yShake=0;
}


if(hellmouthHealth <=0 && !global.hellmouthExploding)
{
	global.hellmouthExploding=true;
	audio_play_sound(snd_hellmouth_hurt_death, 10, false);
	hellmouthShakeCountdownTimer = 6000;
}

if(global.hellmouthExploding)
{
	explodingTimer++;
	if(explodingTimer>20)
	{
		explodingTimer=0;
		audio_play_sound(snd_torpedo_explosion, 5, false);
		effect_create_above(ef_explosion, x+irandom_range(-30,30), y-5+irandom(-40), 1, $1E60FF);
	}
}

#endregion

	