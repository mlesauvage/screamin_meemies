/// @description Insert description here
// You can write your code in this editor

#macro HELL_SHIELD_START 300
#macro HELL_SHIELD_THICKNESS 5

var healthModifier = 1 - (HELL_MAX_HEALTH - hellmouthHealth)*0.12;

draw_sprite_ext(spr_hellmouth, 0, x+xShake, y+yShake, 1, 1, 0, redIntensity*healthModifier, 1);

for(var i=0; i<HELL_SHIELD_THICKNESS; i++)
	draw_circle_color(x, y, HELL_SHIELD_START+i, c_teal, redIntensity*healthModifier, true);

draw_set_alpha(healthModifier);
draw_circle_color(x, y, HELL_SHIELD_START+HELL_SHIELD_THICKNESS-1, c_teal, c_white, true);
draw_set_alpha(1);

