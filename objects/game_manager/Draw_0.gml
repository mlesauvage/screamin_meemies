/// @description Insert description here
// You can write your code in this editor

if(global.debug)
{
	with(o_torpedo)
	{
		draw_circle(GetXIntercept(y,true),y, 10, true);
		draw_circle(GetXIntercept(y,false),y, 10, true);
	}
	with(o_submarine)
	{
		draw_circle(GetXIntercept(y,true),y, 10, true);
		draw_circle(GetXIntercept(y,false),y, 10, true);
	}
}