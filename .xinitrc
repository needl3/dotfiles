#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Make the dhcpcd binary setuid during arch installation
# Then only this sequence will run
# If network card is down or powered off
# sudo rfkill unblock all # Maybe you want to include wirelesscard here instead of all using rfkill list
# ip link set wlan0 up

# Configure Internet Connection
# iwctl station wlan0 connect <Replace with SSID>
# dhcpcd wlan0

# Initialize pulseaudio
pulseaudio &

# Please save my eyes
redshift -O 4500 &

# Restore my waifu
nitrogen --restore &

# Start compositor
picom &

# Start WM
exec dwm
# while :; do
# 	dwm 2> ~/.dwm.log
# done
