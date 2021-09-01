/*
	Script to toggle conservation mode on of depending in previous state
	Chown the genereated binary as root
	Set a setuid bit to the binary as root
	Add the binary to /usr/local/bin
*/

#include <iostream>
#include <fstream>
int main(){
	std::string txt;

	std::fstream fin("/sys/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/conservation_mode", std::ios::in);
	std::fstream fout("/sys/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/conservation_mode", std::ios::out);

	if (!fout.is_open()){
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
