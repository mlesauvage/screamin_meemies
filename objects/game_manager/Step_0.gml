/// @description Insert description here
// You can write your code in this editor
#macro GAME_TORPEDOES_MAX 3
#macro GAME_TORPEDO_RELOAD_TIME 200
#macro GAME_SPAWN_TIME 360
#macro GAME_SPAWN_FROM_TOP_DIVISOR 1
#macro GAME_FADE_TIME_WIN 240
#macro GAME_FADE_TIME_LOSE 90
#macro GAME_MAX_CREW 30
#macro GAME_TIME_BUBBLE_SPAWN 30


#region Torpedo Reloading

if(global.torpedoesLoaded < GAME_TORPEDOES_MAX)
{
	torpedoTimer++;
	if(torpedoTimer > GAME_TORPEDO_RELOAD_TIME)
	{
		global.torpedoesLoaded++;
		audio_play_sound(snd_torpedo_loaded, 5, false);
		torpedoTimer=0;
	}
}

#endregion

#region Crew "Management"
if(global.usedPing  && !global.hellmouthExploding) //No sacrifice if game won.
{
	global.usedPing=false;
	swordSlashSoundIndex =  audio_play_sound(snd_sword_strike, 5, false);
}
if(swordSlashSoundIndex != 0)
{
	if(!audio_is_playing(swordSlashSoundIndex))
	{
		PlayRandomScream();
		swordSlashSoundIndex=0;
		crewRemaining--;
	}
}

#endregion

#region Ghost Attacks
if(global.ghostsAttacked>0 && !global.hellmouthExploding) //Player won. Don't kill people.
{
	if(!audio_is_playing(currentGhostAttackCrewDeathScreamIndex))
	{
		global.ghostsAttacked--;
		currentGhostAttackCrewDeathScreamIndex = PlayRandomScream();
		crewRemaining--;
	}
}
#endregion

#region Spawn Enemies
ghostSpawnTimer++;
if(ghostSpawnTimer > GAME_SPAWN_TIME)
{
	ghostSpawnTimer=0;
	with(instance_create_layer(o_hellmouth.x, o_hellmouth.y, "ghosts_layer", o_ghost))
	{
		cruisingDirection=random_range(70, 110);
		seeking=false;
	}
	ghostSpawnFromTopCounter++;
	if(ghostSpawnFromTopCounter==GAME_SPAWN_FROM_TOP_DIVISOR)
	{
		ghostSpawnFromTopCounter=0;
		with(instance_create_layer(o_hellmouth.x, 50, "ghosts_layer", o_ghost))
		{
			cruisingDirection=random_range(240,300);
			seeking=false;
		}
	}
		
}
#endregion

#region Spawn Bubbles
bubbleTimer++
if(bubbleTimer > GAME_TIME_BUBBLE_SPAWN)
{
	instance_create_layer(0, 0, "bubbles_layer", o_bubble)
	bubbleTimer=0;
}
#endregion

#region Check Game End
if(global.hellmouthExploding)
{
	hellmouthExplosionTimer++;
	if(hellmouthExplosionTimer > GAME_FADE_TIME_WIN)
	{
		global.gameWon=true;
		global.perished=GAME_MAX_CREW-crewRemaining;
		if(global.perished > GAME_MAX_CREW)
			global.perished=GAME_MAX_CREW;
		room_goto(end_room);
	}
}
else if(crewRemaining <=0)
{
	loseGameFadeTimer++;
	if(loseGameFadeTimer > GAME_FADE_TIME_LOSE)
	{
		global.gameWon=false;
		global.perished=GAME_MAX_CREW;
		room_goto(end_room);
	}
}
#endregion
