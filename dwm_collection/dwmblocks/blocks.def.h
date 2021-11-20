
//
//	Add this line in your .bashrc file
//	export PATH="~/.dblocks_modules/:$PATH"
//

//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/					/*Update Interval*/	/*Update Signal*/
	{"", 		"backlight.sh",				0,					0},
	{"", 		"volume.sh",				0,					1},
	{"", 		"cpu.sh",					5,					2},
	{"", 		"memory.sh",				5,					3},
	{"", 		"network.sh",				5,					4},
	{"",		"updates.sh",				0,					5},
	{"", 		"battery.sh",				120,				6},
	{"", 		"date.sh",					60,					7},
	{"", 		"wifi.sh",					5,					8},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
