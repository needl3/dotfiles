#/usr/bin/bash

#Color definitions
green=$'\e[0;92m'
red=$'\e[0;91m'
blue=$'\e[1;34m'
reset=$'\e[0m'

# All pacman packages to install
packages_pacman=(xorg-server xorg-xinit xorg-xsetroot xorg-xrandr xbindkeys\
				neofetch htop flameshot mpd rofi ranger wget curl redshift\
				base-devel go nitrogen synaptics pulseaudio pavucontrol\
				ttf-joypixels ttf-jetbrains-mono\
				socat openvpn dunst libcanberra\
			)

# All yay packages to install
packages_yay=(picom-jonaburg-git libxft-bgra nerd-fonts-complete)

# All system services to enable
services=(mpd iwd dhcpcd)

# Directory containing all source files
base_dir=$(realpath $(dirname "$0"))
src_dir="$base_dir/src"
dest_dir="/usr/local/bin"

placeFiles(){
	echo "${blue}Placing Files${reset}"
	dotfiles=( .xinitrc .bashrc .Xmodmap .xbindkeysrc .bash_profile .vimrc )
	for i in ${dotfiles[@]};do
		sudo ln -sf $base_dir/$i /home/$SUDO_USER
	done
	sudo cp 70-synaptics.conf /usr/share/X11/xorg.conf.d/70-synaptics.conf
	sudo cp .bashrc /root/
}

configureBrightnessModifier(){
	echo "${blue}Configuring brightnessModifier${reset}"
	g++ $src_dir/changeBacklight.cpp -o $dest_dir/changeBacklight
	chown root $dest_dir/changeBacklight
	chmod u+s $dest_dir/changeBacklight
}

configureKiller(){
	# Program killer using name-----------------------------------------------------------
	# Usage: killProgram <process_name>
	echo "${blue}Configuring process killer${reset}"
	sudo echo "ps -A | grep $1 | xargs kill 2> /dev/null" > /usr/local/bin/killProgram
	sudo chmod +x /usr/local/bin/killProgram
}

configureConservationMode(){
	# Conservation mode toggler------------------------------------------------------------
	echo "${blue}Configuring Conservation Mode${reset}"
	sudo g++ $src_dir/toggleConservation.cpp -o $dest_dir/toggleConservationMode
	sudo chown root $dest_dir/toggleConservationMode
	sudo chmod u+s $dest_dir/toggleConservationMode

	# Create menu entry
	echo "[Desktop Entry]\
	Name=Toggle Battery Mode
	Type=Application
	Icon=/home/$SUDO_USER/.local/share/icons/battery.png
	Exec=toggleConservationMode" > /home/$SUDO_USER/.local/share/applications/ToggleBtteryMode.desktop
	mkdir /home/$SUDO_USER/.local/share/icons
	cp assets/battery.png /home/$SUDO_USER/.local/share/icons/

	# Initiate conservation mode
	toggleConservationMode
}
configureBacklight(){
	# Keyboard Backlight toggler(For Arch)--------------------------------------------------
	echo "${blue}Configuring Keyboard Backlight${reset}"
	sudo g++ $src_dir/toggleBacklight.cpp -o $dest_dir/toggleBacklight
	sudo chown root $dest_dir/toggleBacklight
	sudo chmod u+s $dest_dir/toggleBacklight

	# Turn the backlight on
	toggleBacklight

	# Create a menu entry
	echo "[Desktop Entry]\
	Name=Toggle Backlight
	Type=Application
	Icon=/home/$SUDO_USER/.local/share/icons/rgb_keyboard.png
	Exec=toggleBacklight" > /home/$SUDO_USER/.local/share/applications/ToggleBacklight.desktop
	cp assets/rgb_keyboard.png /home/$SUDO_USER/.local/share/icons/
}
configureSSH(){
	# SSH Configuration---------------------------------------------------------------------
	read -p "${green}Do you want to configure openssh?(y/n): ${reset}" ans
	echo "${blue}Configuring SSH${reset}"
	if [[ $ans == 'y' ]]; then
		
		echo "${blue}[+] Installing ssh${reset}"
		pacman -S openssh --noconfirm
		
		# echo "[+] Not enabling ssh at system start."
		systemctl enable sshd

		# Preparing directories
		mkdir /home/$SUDO_USER/.ssh 2> /dev/null

		
		echo "${blue}[+] Generating secret keys${reset}"
		ssh-keygen
		cat /$USER/.ssh/id_rsa.pub > /home/$SUDO_USER/.ssh/authorized_keys
		rm /$USER/.ssh/id_rsa.pub
		mv /$USER/.ssh/id_rsa /home/$SUDO_USER/.ssh/
		echo "${blue}Now move the /home/$SUDO_USER/.ssh/id_rsa to a secure client machine${reset}"

		systemctl start sshd

		echo "${green}[+] SSH configuration success!${reset}"
	fi
}
installDwm(){
	echo "${blue}[+] Installing DWM${reset}"
	cd dwm_collection/dwm
	sudo make clean install
	make clean
	cd ../../
}

installDwmblocks(){
	echo "${blue}[+] Installing dwmblocks${reset}"
	cd dwm_collection/dwmblocks
	sudo make clean install
	make clean
	cd ../../
}

installSt(){
	echo "${blue}[+] Installing Simple Terminal(ST)${blue}"
	cd st
	wget https://dl.suckless.org/st/st-0.8.5.tar.gz
	tar -xf st-0.8.5.tar.gz
	cd st-0.8.5

	echo "${blue}[+] Patching scroll+overflow${reset}"
	patch -p1 < ../st-scroll-overflow.diff
	echo "[+] Patching alpha"
	patch -p1 < ../alpha.diff
	echo "${blue}[+] Patching focus-unfocus effect${reset}"
	patch -p1 < ../focus-unfocus.diff
	echo "${blue}[+] Patching fix for anysize bug${reset}"
	patch -p1 < ../anysize-bug-fix.diff
	sudo make clean install
	cd ../
	rm -rf st-0.8.5*
	cd ../
}
configureDotfiles(){
	echo "${blue}[+] Configuring dotfiles${reset}"
	sudo mkdir /home/$SUDO_USER/.config
	cp -r .config/* /home/$SUDO_USER/.config/
	chown -R $SUDO_USER:$SUDO_USER .config/
	placeFiles
}
configureAurHelper(){
	echo "${blue}[+] Configuring YAY(Aur Helper)${reset}"
	sudo git clone https://aur.archlinux.org/yay-git.git
	cd yay-git
	makepkg -si
	cd ../
	rm -rf yay-git
}

# Program Entry

#Check for root user
if [ $UID != 0 ];then
	echo "${red}Run it as root${reset}"
	exit 1
fi

# Install all dependencies
pacman -Syyu ${packages_pacman[@]} --noconfirm

configureDotfiles

configureAurHelper

echo "${packages_yay[@]}"
read -p "${green}Do you want to install above packages from AUR?${reset}" ch
if [[ $ch == "y" || $ch == "Y" ]];then
	echo "${blue}[+] Installing aur packages${reset}"
	sudo yay -S ${packages_yay[@]} --cleanafter --removemake --noredownload
else
	echo "${red}[-] Skipping AUR packages${red}"
fi

#######################
# Running Functions   #
#######################
configureKiller
configureConservationMode
configureBacklight
configureBrightnessModifier
configureSSH
installDwm
installDwmblocks
installSt
configureDotfiles

# Enable all services
systemctl enable ${services[@]}

# Reboot for changes to properly take effect
read -p "${green}Reboot machine to render proper changes. Reboot Now? (Y/N): ${reset}" reb
if [[ $reb == "y" || $reb == "Y" ]];then
	reboot
fi
