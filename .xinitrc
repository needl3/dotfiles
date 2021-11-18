#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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
    redshift -x
    redshift -O 4000

    # Restore my waifu
    nitrogen --restore

    # Start compositor
    # picom
}

getDate(){
    printf "$(date +%I:%M\ %p)"
}

getBacklightStatus(){
    printf " $(cat /sys/class/backlight/intel_backlight/brightness)"
}
getCpuStatus(){
    printf " $(neofetch --disable --funcname cpu_usage | grep -o '[0-9]\{,\}')"
}
getMemoryStatus(){
    total=$(free -m | awk 'FNR == 2 {print $2}')
    used=$(free -m | awk 'FNR == 2 {print $3}')
    mem_info="$used/$total"
    printf " $mem_info"
}
getNetworkStatus(){
    printf "  100  100"
}
getBatteryStatus(){
    icons=(    )
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    if grep -q Charging /sys/class/power_supply/BAT1/status;then
        battery_icon=
    else
        battery_icon=${icons[$(expr $battery_percent % 4)]}
    fi
    printf "$battery_icon $battery_percent"
}
getTemperature(){
    if [ $1 == "cpu" ]
    then
        printf "  `expr $(grep -o [0-9]* /sys/class/thermal/thermal_zone0/temp) / 1000`°C"
    else
        printf ""
    fi
}
getVolume(){
    vol_icons=(   )
    vol_magnitude=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    printf "${vol_icons[$(expr $vol_magnitude % 3)]} $vol_magnitude"
}

updateStatusBar(){
    xsetroot -name "| $(getBacklightStatus) | $(getVolume) | $(getCpuStatus) $(getTemperature cpu) | $(getMemoryStatus) | $(getNetworkStatus) | $(getBatteryStatus) | $(getDate)"
}
while :;
do
    updateStatusBar
    sleep 5s
done &

# initializeNetwork &
# initializePulseAudio &
# while :;
# do
# 	updateStatusBar
#     sleep 5s
# done &

initializeMiscServices &

# Start WM
# exec dwm
  while :; do
 	dwm 2> ~/.dwm.log
 done
