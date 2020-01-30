/// @description Insert description here
// You can write your code in this editor

global.debug=false;

global.hellmouthExploding=false;
global.torpedoesLoaded = 3;
global.usedPing = false;
global.ghostsAttacked = 0;


torpedoFrame=0;
torpedoAnimationTimer=0;
crewRemaining = GAME_MAX_CREW;
torpedoTimer = 0;
swordSlashSoundIndex = 0;
currentGhostAttackCrewDeathScreamIndex=0;
ghostSpawnTimer=0;
ghostSpawnFromTopCounter=0;
hellmouthExplosionTimer=0;
loseGameFadeTimer=0;
bubbleTimer=0;

randomize();
CreateStartBubbles(170); //Basically the amount that fills the game on normal play.
