#!/usr/bin/bash

cp .xinitrc /home/$SUDO_USER
cp .bashrc /home/$SUDO_USER


# Program killer using name-----------------------------------------------------------
# Usage: killProgram <process_name>
echo "ps -A | grep $1 | xargs kill 2> /dev/null" > /usr/local/bin/killProgram
chmod +x /usr/local/bin/killProgram

# Directory containing all source files
src_dir="src"

# Conservation mode toggler------------------------------------------------------------
g++ $(src_dir)/toggleConservation.cpp -o /usr/local/bin
sudo chown root toggleConservationMode
sudo chmod u+s toggleConservationMode

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

# Keyboard Backlight toggler(For Arch)--------------------------------------------------
g++ $(src_dir)/toggleBacklight.cpp -o /usr/local/bin
sudo chown root toggleBacklight
sudo chmod u+s toggleBacklight

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


# SSH Configuration---------------------------------------------------------------------
echo "Do you want to configure openssh?(y/n)"
read ans
if [ $ans = 'y' ]; then
	
	echo "[+] Installing ssh"
	sudo pacman -S openssh --noconfirm
	
	# echo "[+] Not enabling ssh at system start."
	sudo systemctl enable sshd

	# Preparing directories
	mkdir /home/$SUDO_USER/.ssh 2> /dev/null

	
	echo "[+] Generating secret keys"
	ssh-keygen
	cat /$USER/.ssh/id_rsa.pub > /home/$SUDO_USER/.ssh/authorized_keys
	rm /$USER/.ssh/id_rsa.pub
	mv /$USER/.ssh/id_rsa /home/$SUDO_USER/.ssh/
	echo "Now move the /home/$SUDO_USER/.ssh/id_rsa to a secure client machine"

	echo "Updating sshd configuration file"
	sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

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

	sudo systemctl start sshd

	echo "[+] SSH configuration success!"
fi

# Local port forwarding for portmap rule, I have that in my .bashrc file
sudo pacman -S socat openvpn jre11-openjdk-headless --noconfirm