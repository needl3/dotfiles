//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/					/*Update Interval*/	/*Update Signal*/
	{"", 		"modules/backlight.sh",				0,					0},
	{"", 		"modules/volume.sh",				0,					1},
	{"", 		"modules/cpu.sh",					5,					2},
	{"", 		"modules/memory.sh",				5,					3},
	{"", 		"modules/network.sh",				5,					4},
	{"",		"modules/updates.sh",				0,					5},
	{"", 		"modules/battery.sh",				120,				6},
	{"", 		"modules/date.sh",					60,					7},
	{"", 		"modules/wifi.sh",					5,					8},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
