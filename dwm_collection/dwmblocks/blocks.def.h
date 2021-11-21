//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Identifier*/	/*Command*/								/*Update Interval*/	/*Update Signal*/
	{"\x01", 		"/opt/dblocks_modules/backlight.sh",				0,					0},
	{"\x02", 		"/opt/dblocks_modules/volume.sh",					0,					1},
	{"\x03", 		"/opt/dblocks_modules/cpu.sh",						5,					2},
	{"\x04", 		"/opt/dblocks_modules/memory.sh",					5,					3},
	{"\x05", 		"/opt/dblocks_modules/network.sh",					5,					4},
	{"\x06",		"/opt/dblocks_modules/updates.sh",					0,					5},
	{"\x07", 		"/opt/dblocks_modules/battery.sh",					120,				6},
	{"\x08", 		"/opt/dblocks_modules/date.sh",						60,					7},
	{"\x09", 		"/opt/dblocks_modules/wifi.sh",						5,					8},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "|";
static unsigned int delimLen = 5;
