/*
	Script to change Brightness
	Chown the genereated binary as root
	Set a setuid bit to the binary as root
	Add the binary to /usr/local/bin


	BASH ONELINER
	g++ changeBacklight.cpp -o changeBacklight && sudo chown changeBacklight && sudo chmod u+s changeBacklight && ./changeBacklight
*/

#include <iostream>
#include <fstream>

int main(int argc, char **argv){
	if(argc != 3){
		std::cout << "Usage: changeBacklight [ Option ] <percent_to_increase>\
					\nOptions:\
					\n\t--inc : increase\
					\n\t--dec : decrease\
					\nEg: changeBacklight --inc 1\t(Will increase brightness by 1%)";
		return 1;
	}

	std::string arg_mod = argv[1];
	std::string arg_delta = argv[2];
	int sign;

	if(arg_mod == "--inc")
		sign = 1;
	else
		sign = -1;

	std::string max_val, current_val;
	char brightness_file[] = "/sys/class/backlight/intel_backlight/brightness";
	char max_brightness_file[] = "/sys/class/backlight/intel_backlight/max_brightness";

	std::fstream mfin(max_brightness_file, std::ios::in);
	std::fstream fin(brightness_file, std::ios::in);
	std::fstream fout(brightness_file, std::ios::out);

	if (!fout.is_open()){
		std::cout <<"[-] Cannot open file to write.";
		return 1;
	}

	std::getline(mfin, max_val);
	std::getline(fin,current_val);

	int final_val = (std::stoi(current_val)+sign*std::stof(arg_delta)/100.0f*std::stof(max_val));

	std::cout << "\nMax: " << max_val << "\nCurrent Val: " << current_val << "\nFinal Val: " << final_val;

	if (final_val < 5)
		fout << 5;
	else if(final_val > std::stoi(max_val))
		fout << std::stoi(max_val);
	else
		fout << final_val;

	fin.close();
	fout.close();
	mfin.close();	
	return 0;
}