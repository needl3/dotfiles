#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

dwmstatusbar_info=("" "" "" "" "")

# Sleeping time for modules
backlightsleep=10s
memorysleep=5s
cpusleep=5s
batterysleep=1m
networksleep=5s

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
    pulseaudio --start
}

initializeMiscServices(){
    # Please save my eyes
    # redshift -x
    # redshift -O 4000

    # Restore my waifu
    nitrogen --restore

    # Start compositor
    # picom
}

getBacklightStatus(){
    dwmstatusbar_info[0]="\t$(cat /sys/class/backlight/intel_backlight/brightness)"
}
getCpuStatus(){
    dwmstatusbar_info[1]="\t$(neofetch --disable --funcname cpu_usage | grep -o '[0-9]\{,\}')"
}
getMemoryStatus(){
    mem_info=$(neofetch --disable --funcname memory_usage | grep -o '[0-9]\{,\}')
    dwmstatusbar_info[2]="\t`echo $mem_info | grep -o '^[0-9]*'`"
}
getNetworkStatus(){
    dwmstatusbar_info[3]="$(cat /sys/class/backlight/intel_backlight/brightness)"
}
getBatteryStatus(){
    icons=(    )
    battery_percent=$(neofetch --disable --funcname battery | grep -o '[0-9]\{2,\}')
    battery_icon=${icons[$(expr $battery_percent % 4)]}
    dwmstatusbar_info[4]="$battery_icon\t$battery_percent"
}

updateStatusBar(){
    getBatteryStatus
    getNetworkStatus
    getMemoryStatus
    getCpuStatus
    getBacklightStatus

    statusbar=""
    for i in $dwmstatusbar_info
    do
        statusbar+=$i
        echo $statusbar
    done


    xsetroot -name $statusbar

}


# initializeNetwork &
# initializePulseAudio &
# while :;
# do
# 	updateStatusBar
#     sleep 5s
# done &

initializeMiscServices &

# Start WM
exec dwm
#  while :; do
#	dwm 2> ~/.dwm.log
# done
