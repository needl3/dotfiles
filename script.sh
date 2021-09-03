#!/usr/bin/bash

# Program killer using name
# Usage: killProgram <process_name>
echo "ps -A | grep $1 | xargs kill 2> /dev/null" > /usr/local/bin/killProgram
chmod +x /usr/local/bin/killProgram

# Conservation mode toggler
g++ toggleConservation.cpp -o toggleConservationMode
sudo chown root toggleConservationMode
sudo chmod u+s toggleConservationMode
mv toggleConservationMode /usr/local/bin/

desContent="[Desktop Entry]
Name=Toggle Battery Mode
Type=Application
Icon=/home/$USER/.local/share/icons/battery.png
Exec=toggleConservationMode"

echo $desContent > /home/$USER/.local/share/applications/ToggleBtteryMode.desktop
mv assets/battery.png /home/$USER/.local/share/icons/

