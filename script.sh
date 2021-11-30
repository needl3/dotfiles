#!/usr/bin/bash

# All pacman packages to install
packages_pacman=(socat openvpn xorg-xsetroot neofetch htop\
				xorg-xev xbindkeys gscreenshot mpd rofi\
				ranger 
				)

# All yay packages to install
packages_yay = (picom-ibhagwan-git)

# All system services to enable
services=(mpd iwd dhcpcd)

# Directory containing all source files
src_dir="src"
dest_dir="/usr/local/bin"

placeFiles(){
	cp .xinitrc /home/$SUDO_USER
	cp .bashrc /home/$SUDO_USER
	cp .Xmodmap /home/$SUDO_USER
}

configureBrightnessModifier(){
	g++ $src_dir/changeBacklight.cpp -o $dest_dir/changeBacklight
	chown root $dest_dir/changeBacklight
	chmod u+s $dest_dir/changeBacklight
}

configureKiller(){
	# Program killer using name-----------------------------------------------------------
	# Usage: killProgram <process_name>
	echo "ps -A | grep $1 | xargs kill 2> /dev/null" > /usr/local/bin/killProgram
	chmod +x /usr/local/bin/killProgram
}

configureConservationMode(){
	# Conservation mode toggler------------------------------------------------------------
	g++ $(src_dir)/toggleConservation.cpp -o $dest_dir/toggleConservationMode
	chown root $dest_dir/toggleConservationMode
	chmod u+s $dest_dir/toggleConservationMode

	# Create menu entry
	desContent="[Desktop Entry]
	Name=Toggle Battery Mode
	Type=Application
	Icon=/home/$SUDO_USER/.local/share/icons/battery.png
	Exec=toggleConservationMode"

	echo $desContent > /home/$SUDO_USER/.local/share/applications/ToggleBtteryMode.desktop
	mkdir /home/$SUDO_USER/.local/share/icons
	cp assets/battery.png /home/$SUDO_USER/.local/share/icons/

	# Initiate conservation mode
	toggleConservationMode
}
configureBacklight(){
	# Keyboard Backlight toggler(For Arch)--------------------------------------------------
	g++ $(src_dir)/toggleBacklight.cpp -o $dest_dir/toggleBacklight
	chown root $dest_dir/toggleBacklight
	chmod u+s $dest_dir/toggleBacklight

	# Turn the backlight on
	toggleBacklight

	# Create a menu entry
	desContent="[Desktop Entry]
	Name=Toggle Backlight
	Type=Application
	Icon=/home/$SUDO_USER/.local/share/icons/rgb_keyboard.png
	Exec=toggleBacklight"

	echo $desContent > /home/$SUDO_USER/.local/share/applications/ToggleBacklight.desktop
	cp assets/rgb_keyboard.png /home/$SUDO_USER/.local/share/icons/
}
configureSSH(){
	# SSH Configuration---------------------------------------------------------------------
	echo "Do you want to configure openssh?(y/n)"
	read ans
	if [ $ans = 'y' ]; then
		
		echo "[+] Installing ssh"
		pacman -S openssh --noconfirm
		
		# echo "[+] Not enabling ssh at system start."
		systemctl enable sshd

		# Preparing directories
		mkdir /home/$SUDO_USER/.ssh 2> /dev/null

		
		echo "[+] Generating secret keys"
		ssh-keygen
		cat /$USER/.ssh/id_rsa.pub > /home/$SUDO_USER/.ssh/authorized_keys
		rm /$USER/.ssh/id_rsa.pub
		mv /$USER/.ssh/id_rsa /home/$SUDO_USER/.ssh/
		echo "Now move the /home/$SUDO_USER/.ssh/id_rsa to a secure client machine"

		echo "Updating sshd configuration file"
		cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

		echo "The default port is 22 (Unchanged) change it?(y/n)"
		read op
		if [ [op=="y"] ]; then
			while : ; do
				echo "Enter port number:"
				read portNum
				if timeout 1 bash -c "echo testing > /dev/tcp/google.com/$portNum"; then
					echo "Port already in use. Enter another port."
				else
					sed -i "s/^#Port .*/Port $portNum/" /etc/ssh/sshd_config
					break
				fi
			done
		fi

		systemctl start sshd

		echo "[+] SSH configuration success!"
	fi
}
install_dwm(){
	echo "[+] Installing DWM"
	cd dwm_collection/dwm
	make clean install
	make clean
	cd ../../
}

install_dwmblocks(){
	echo "[+] Installing dwmblocks"
	cd dwm_collection/dwmblocks
	make clean install
	make clean
	cd ../../
}

install_st(){
	echo "[+] Installing Simple Terminal(ST)"
	cd st
	git clone https://git.suckless.org/st
	cd st
	patch -p1 < ../alpha_scroll_focus.diff
	make clean install
	make clean
	cd ../
	rm -r st
	cd ../
}
configure_dotfiles(){
	echo "[+] Configuring dotfiles"
	mkdir /home/$SUDO_USER/.config 2> /dev/null
	cp -r .config/* /home/$SUDO_USER/.config/
	cp .Xmodmap .xinitrc .xbindkeysrc .bashrc /home/$SUDO_USER/
	cp 70-synaptics.conf /usr/share/X11/xorg.conf.d/70-synaptics.conf
	cp .bashrc /root/
}

#######################
# Running Functions   #
#######################
placeFiles
configureKiller
configureConservationMode
configureBacklight
configureBrightnessModifier
configureSSH
install_dwm
install_dwmblocks
install_st
configure_dotfiles

# Local port forwarding for portmap rule, I have that in my .bashrc file

# Install all dependencies
pacman -Syyu ${packages_pacman[@]} --noconfirm
yay -S ${packages_yay[@]} --cleanafter

# Enable all services
systemctl enable ${services[@]}

# Reboot for changes to properly take effect
echo "Reboot machine to render proper changes. Reboot Now? (Y/N)"
read reb
if [ reb == "y" || reb == "Y" ]
then
	reboot
fi