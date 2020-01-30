/// @description Insert description here
// You can write your code in this editor
var screenWidth = display_get_gui_width();

draw_set_halign(fa_center);

var y1=200;
var y2=260;
var y4=600;


var crewSpacing=100;
var crewSpacingImageRemoved=crewSpacing-15

if(endState == endStates.text1)
{
	draw_set_alpha(nextStateTimer/END_STATE_TIMER);
	if(global.gameWon)
		draw_text(screenWidth/2, y1, "You closed the Hellmouth and saved humanity from Cursemas.");
	else
		draw_text(screenWidth/2, y1, "The hellmouth remains open.");
	draw_set_alpha(1);
}	
else if(endState == endStates.text2)
{
	if(global.gameWon)
		draw_text(screenWidth/2, y1, "You closed the Hellmouth and saved humanity from Cursemas.");
	else
		draw_text(screenWidth/2, y1, "The hellmouth remains open.");

	draw_set_alpha(nextStateTimer/END_STATE_TIMER);
	if(global.gameWon)
	{
		if(global.perished > 0)
			draw_text(screenWidth/2, y2, "But at what cost?");
		else
			draw_text(screenWidth/2, y2, "Miraculously, not a soul was lost.");
	}
	else
		draw_text(screenWidth/2, y2, "Humanity will forever remember your failure.");
	draw_set_alpha(1);
}
else if(endState == endStates.showingCrew || endState==endStates.text3)
{
	if(global.gameWon)
	{
		draw_text(screenWidth/2, y1, "You closed the Hellmouth and saved humanity from Cursemas.");
		if(global.perished > 0)
			draw_text(screenWidth/2, y2, "But at what cost?");
		else
			draw_text(screenWidth/2, y2, "Miraculously, not a soul was lost.");
	}
	else
	{
		draw_text(screenWidth/2, y1, "The hellmouth remains open.");
		draw_text(screenWidth/2, y2, "Humanity will forever remember your failure.");
	}


	var firstLine=global.perished;
	var remainder=0;
	if(global.perished > 15)
	{
		var remainder = global.perished-15;
		var firstLine=15;
	}

	
	var xCrew = 800-(firstLine*15 + (firstLine-1)*crewSpacingImageRemoved)/2
	var yCrew=350;
	var y3=380;

	var maxFirstRow = min(firstLine, crewShown);
	for(var i=0; i<maxFirstRow; i++)
	{
		draw_sprite_ext(spr_crew_tiny, 0, xCrew+(i*crewSpacing), yCrew, 1, 1, 0, c_white, 1);
		draw_text(xCrew+7+(i*crewSpacing), y3, names[randomNameIndex[i]]);
	}
	
	xCrew = 800-(remainder*15 + (remainder-1)*crewSpacingImageRemoved)/2
	yCrew = 450;
	y3 = 480;
	var maxSecondRow = min(remainder, crewShown-15);
	for(var i=0; i<maxSecondRow; i++)
	{
		draw_sprite_ext(spr_crew_tiny, 0, xCrew+(i*crewSpacing), yCrew, 1, 1, 0, c_white, 1);
		draw_text(xCrew+7+(i*crewSpacing), y3, names[randomNameIndex[i+15]]);
	}
	
}

if(endState==endStates.text3)
{
	draw_set_alpha(nextStateTimer/END_STATE_TIMER);
	if(global.gameWon)
	{
		if(global.perished == 0)
			draw_text(screenWidth/2, y4, "You kept your crew alive, eager to breathe fresh air alongside a safe and curseless world.");
		else
			draw_text(screenWidth/2, y4, "Their families take solace in the knowledge that their loved ones will be remembered forever.");
	}
	else
		draw_text(screenWidth/2, y4, "There is no one left to write letters to the bereaved. Cursemas comes to us all.");
	draw_set_alpha(1);

}


	