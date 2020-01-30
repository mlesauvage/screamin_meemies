/// @description Insert description here
// You can write your code in this editor
nextStateTimer=0;
nextCrewTimer=0
crewShown=0;

enum endStates {
	text1,
	text2,
	showingCrew,
	text3
}

endState=endStates.text1;

names=array_create(100);
var i, file;
file = file_text_open_read("names.txt");
for (i = 0; i < 100; i += 1)
{
	names[i] = file_text_read_string(file);
	file_text_readln(file);
}
file_text_close(file);

randomNameIndex=array_create(30);
for(i=0; i<30; i++)
	randomNameIndex[i]=irandom(99);

