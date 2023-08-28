/*
	Script to toggle conservation mode on of depending in previous state
	Chown the genereated binary as root
	Set a setuid bit to the binary as root
	Add the binary to /usr/local/bin


	BASH ONELINER
	g++ toggleBacklight.cpp -o toggleBacklight && sudo chown toggleBacklight && sudo chmod u+s toggleBacklight && ./toggleBacklight
*/

#include <iostream>
#include <fstream>

std::string gimmeFileName(){
	std::string incFile = "/sys/class/leds/input",incFile1="::scrolllock/brightness",tempFile,cmd = "find ";
	char *ch_cmd;
	bool found = false;
	for (int i=0;i<100;i++){

		//Prepare filename
		tempFile.append(incFile);
		tempFile.append(std::to_string(i));
		tempFile.append(incFile1);

		//Prepare command
		cmd.append(tempFile);
		cmd.append(" 2> /dev/null");
		ch_cmd = &cmd[0];
		if (!system(ch_cmd)){
			if (found)
				return tempFile;
			found = true;
		}

		cmd = "find ";
		tempFile = "";
	}
	return "";
}

int main(){
	std::string txt,filename;
	filename = gimmeFileName();
	std::fstream fin(filename, std::ios::in);
	std::fstream fout(filename, std::ios::out);

	if (!fout.is_open() || !filename.length()){
		std::cout <<"[-] Cannot open file.";
		return 1;
	}

	std::getline(fin,txt);
	if (txt == "1")
		fout << 0;
	else
		fout << 1;
	fin.close();
	fout.close();
	return 0;
}
