#!/bin/sh

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
    redshift -O 4000

    # Restore my waifu
    nitrogen --restore

    # Start compositor
    picom -b

    dwmblocks &

    xbindkeys -f ~/.xbindkeysrc &

    xmodmap .Xmodmap &

    dunst &

}

initializeMiscServices &

# Start WM
# exec dwm
  while :; do
    dwm 2> ~/.dwm.log
 done