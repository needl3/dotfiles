#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources

initializeMiscServices(){
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
    syndaemon -i 0.5 -t -R -d

    picom --experimental-backend&

}
initializeMiscServices &

# Start WM
while :;do
    dwm 2> ~/.dwm.log
done
