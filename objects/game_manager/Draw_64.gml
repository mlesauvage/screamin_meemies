/// @description Insert description here
// You can write your code in this editor
var screenWidth = display_get_gui_width();
var screenHeight = display_get_gui_height();

#region Crew Remaining
draw_sprite_ext(spr_submarine_white_ui, 0, -60, screenHeight-155, 4, 4, 0, c_white, 0.66);
for(var row=0; row<2; row++)
{
	for(var i=0; i<15; i++)
	{
		draw_sprite_ext(spr_crew_tiny, 0, 10+(i*16), screenHeight-85+(row*18), 0.66, 0.66, 0, c_white, 1);
		if(row*15+i+1>crewRemaining)
		{
			
			draw_sprite_ext(spr_x_death, 0, 10+(i*16), screenHeight-85+(row*18), 0.6, 0.66, 0, c_white, 1);
		}

	}
}
	
#endregion

#region Torpedo Readiness Display

draw_set_halign(fa_center)
draw_text(screenWidth-110, screenHeight-150, "TORPS LOADED");
draw_set_alpha(0.25);
draw_rectangle(screenWidth-170, screenHeight-130, screenWidth-50, screenHeight-30, false);
draw_set_alpha(1);

for(var i=0 ; i<global.torpedoesLoaded; i++)
{
	draw_sprite_ext(spr_torpedo, (torpedoFrame+i)%4, screenWidth-150+i*40, screenHeight-80, 3, 3, 90, c_white, 1);
}
torpedoAnimationTimer++;
if(torpedoAnimationTimer > 15)
	torpedoAnimationTimer = 0;
torpedoFrame=floor(torpedoAnimationTimer/4);
#endregion

#region Blank the Screen for game end
if(global.hellmouthExploding)
{
	draw_set_alpha(clamp(hellmouthExplosionTimer/GAME_FADE_TIME_WIN,0,1));
	draw_rectangle_color(0, 0, screenWidth, screenHeight,c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

if(crewRemaining<=0)
{
	draw_set_alpha(clamp(loseGameFadeTimer/GAME_FADE_TIME_LOSE,0,1));
	draw_rectangle_color(0, 0, screenWidth, screenHeight,c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

#endregion
