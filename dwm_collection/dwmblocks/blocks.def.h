//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Identifier*/	/*Command*/								/*Update Interval*/	/*Update Signal*/
	{"", 		"/opt/dblocks_modules/bar/wifi.sh",						5,					9},
	{"", 		"/opt/dblocks_modules/bar/network.sh",					5,					5},
	{"", 		"/opt/dblocks_modules/bar/ip.sh",						10,					5},
//	{"", 		"/opt/dblocks_modules/bar/backlight.sh",				0,					1},
//	{"", 		"/opt/dblocks_modules/bar/volume.sh",					10,					10},
	{"", 		"/opt/dblocks_modules/bar/cpu.sh",						5,					3},
	{"", 		"/opt/dblocks_modules/bar/memory.sh",					5,					4},
//	{"",		"/opt/dblocks_modules/bar/updates.sh",					0,					6},
	{"", 		"/opt/dblocks_modules/bar/date.sh",						60,					8},
	{"", 		"/opt/dblocks_modules/bar/bluetooth.sh",				60,					2},
	{"", 		"/opt/dblocks_modules/bar/battery.sh",					120,				7},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
