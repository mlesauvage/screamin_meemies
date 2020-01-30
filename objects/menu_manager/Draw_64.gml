/// @description Insert description here
// You can write your code in this editor

var scnCenter = display_get_gui_width()/2;
draw_set_halign(fa_center);

var oldFont=draw_get_font();
draw_set_font(title_font);
draw_text(scnCenter, 80, "Screamin' Meemies");
draw_set_font(oldFont);
draw_text(scnCenter, 140, "A game of dark survival by Mike LeSauvage");

for(var i=0; i<8; i++)
{
	draw_text(scnCenter, 200+30*i, instructions[i]);
}

draw_text(scnCenter, 470, "Please TEST YOUR SONAR system before submerging. (Ensure you can achieve at least volume 15)");
draw_text(scnCenter, 500, "Your microphone volume is: " + string(global.microphone_volume*global.micGain));
draw_rectangle(scnCenter-251, 539, scnCenter+252, 591, true);
draw_set_alpha(0.2);
draw_rectangle(scnCenter-251, 539, scnCenter+252, 591, false);
draw_set_alpha(1);

var micVolumeBarLen=min(global.microphone_volume*2*global.micGain, 500);
if(global.microphone_volume*global.micGain > 15)
	draw_rectangle_color(scnCenter-250, 540, scnCenter-250+micVolumeBarLen, 590,c_green, c_green, c_green, c_green, false);
else
	draw_rectangle_color(scnCenter-250, 540, scnCenter-250+micVolumeBarLen, 590,c_red, c_red, c_red, c_red, false);

draw_set_halign(fa_left);
draw_text_color(scnCenter+265, 555, string(global.micGain), c_white, c_white, c_white, c_white, blinkVisible);
draw_text(scnCenter+280, 555, " <--Microphone gain. Hit +/- to change");

draw_set_halign(fa_center);
draw_text(scnCenter, 555, ds_map_find_value(micInfo[global.recordingFrom], "name"));
draw_text(scnCenter, 610, "(Change device with LEFT/RIGHT arrow keys.)");

oldFont=draw_get_font();
draw_set_font(start_font);
draw_text(scnCenter, 770, "FIND and DESTROY four ghosts");
draw_text(scnCenter, 820, "or press SPACE to commence your ATTACK!");
draw_set_font(oldFont);

draw_set_halign(fa_left);
oldFont=draw_get_font();
draw_set_font(credit_font);
draw_text(10, 800, "Microphone volume extension by HappyTearParakoopa.");
draw_text(10, 815, "Submarine profile from 'Rama', Cc-by-sa-2.0-fr.");
draw_text(10, 830, "Royalty Free Music 'Ofelia's Dream' from Bensound.");
draw_text(10, 845, "Sound effects from GDC giveaway via Sonniss.");
draw_text(10, 860, "Plant life from Open Pixel Project Jungle Theme.");
draw_set_font(oldFont);
