#!/bin/bash

initializeNetwork(){
    # Make the dhcpcd binary setuid during arch installation
    # Then only this sequence will run
    # If network card is down or powered off
    sudo rfkill unblock all # Maybe you want to include wirelesscard here instead of all using rfkill list
    ip link set wlan0 up


    # Configure Internet Connection
    iwctl station wlan0 connect Needle
    dhcpcd wlan0
}
initializePulseAudio(){
    pulseaudio -D
}

initializeMiscServices(){
    # Please save my eyes
    redshift -x
    redshift -O 3000

    # Restore my waifu
    nitrogen --restore

    dwmblocks &

    xbindkeys -f ~/.xbindkeysrc 

    xmodmap .Xmodmap 

    dunst &

    # For flameshot daemon
    flameshot &

    # For gnome-keyring
    source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

    # Disable touchpad while typing
    syndaemon -i 0.5 -t -K -R -d
}
initializeMiscServices &

# Start WM
dwm 2> ~/.dwm.log
