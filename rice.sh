#!/bin/bash

#
# NOTE: This script hasn't been tested
# TODO: Test this script
#

#Color definitions
green=$'\e[0;92m'
red=$'\e[0;91m'
blue=$'\e[1;34m'
reset=$'\e[0m'

# All pacman packages to install
packages_pacman=(neofetch htop flameshot mpd rofi ranger wget curl redshift\
                  base-devel go synaptics pulseaudio pavucontrol lazygit\
                  ttf-joypixels ttf-iosevka-nerd ttf-jetbrains-mono libnotify\
                  socat openvpn dunst libcanberra bluez bluez-utils lm_sensors\
                  meson ninja brightnessctl cmake kitty\
                )

# All yay packages to install
packages_yay=(nerd-fonts-complete ttf-iosevka)

# Directory containing all source files
base_dir=$(realpath $(dirname "$0"))
src_dir="$base_dir/src"
dest_dir="/usr/local/bin"

configureConservationMode(){
	# Conservation mode toggler------------------------------------------------------------
	echo "${blue}Configuring Conservation Mode${reset}"
	sudo g++ $src_dir/toggleConservation.cpp -o $dest_dir/toggleConservationMode
	sudo chown root $dest_dir/toggleConservationMode
	sudo chmod u+s $dest_dir/toggleConservationMode

	# Initiate conservation mode
	toggleConservationMode
}

configureDotfiles(){
	echo "${blue}[+] Configuring dotfiles${reset}"
	sudo mkdir /home/$SUDO_USER/.config
	cp -r .config/* /home/$SUDO_USER/.config/
	chown -R $SUDO_USER:$SUDO_USER .config/

        echo "${blue}Placing Files${reset}"
	dotfiles=( .bash_profile .vimrc )
	for i in ${dotfiles[@]};do
		sudo ln -sf $base_dir/$i /home/$SUDO_USER
	done
	sudo cp .bashrc /root/
}

configureAurHelper(){
	echo "${blue}[+] Configuring YAY(Aur Helper)${reset}"
	git clone https://aur.archlinux.org/yay-git.git
	cd yay-git
	sudo makepkg -si
	cd ../
	rm -rf yay-git/
}

configureSystemdUnits(){
    services=(iwd dhcpcd bluetooth)

    # Enable all services
    systemctl enable ${services[@]}
}

configureHyprlock(){
    git clone https://github.com/hyprwm/hyprlock/
    cd hyprlock
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
    cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
    sudo cmake --install build
    cd ..
    rm -rf hyprlock
}

# Program Entry
#Check for root user
if [ $UID != 0 ];then
	echo "${red}Run it as root${reset}"
	exit 1
fi

# Install all dependencies
pacman -Syyu ${packages_pacman[@]} --noconfirm

configureAurHelper

echo "${packages_yay[@]}"
read -p "${green}Do you want to install above packages from AUR?${reset}" ch
if [[ $ch == "y" || $ch == "Y" ]];then
	echo "${blue}[+] Installing aur packages${reset}"
	sudo -u $SUDO_USER yay -S ${packages_yay[@]} --cleanafter --removemake --noredownload
else
	echo "${red}[-] Skipping AUR packages${red}"
fi

#######################
# Running Functions   #
#######################
configureConservationMode
installSt
configureDotfiles
configureSystemdUnits
configureHyprlock

# Reboot for changes to properly take effect
read -p "${green}Reboot machine to render proper changes. Reboot Now? (Y/N): ${reset}" reb
if [[ $reb == "y" || $reb == "Y" ]];then
	reboot
fi
