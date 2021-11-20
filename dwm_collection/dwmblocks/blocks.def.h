//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/								/*Update Interval*/	/*Update Signal*/
	{"", 		"/opt/dblocks_modules/backlight.sh",				0,					0},
	{"", 		"/opt/dblocks_modules/volume.sh",					0,					1},
	{"", 		"/opt/dblocks_modules/cpu.sh",						5,					2},
	{"", 		"/opt/dblocks_modules/memory.sh",					5,					3},
	{"", 		"/opt/dblocks_modules/network.sh",					5,					4},
	{"",		"/opt/dblocks_modules/updates.sh",					0,					5},
	{"", 		"/opt/dblocks_modules/battery.sh",					120,				6},
	{"", 		"/opt/dblocks_modules/date.sh",						60,					7},
	{"", 		"/opt/dblocks_modules/wifi.sh",						5,					8},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
