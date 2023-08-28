#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources

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
