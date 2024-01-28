#!/usr/bin/bash
if [ $1 == "set" ];then
    toggleConservationMode
    notify-send 'Enabled Charging mode for upto 80%'
    while [ $(cat /sys/class/power_supply/BAT*/capacity) -lt 80 ]
    do
        sleep 60
        cat /sys/class/power_supply/BAT*/capacity
    done
    toggleConservationMode
else
    status=$(cat $(find /sys/devices/ | grep conservation_mode))
    if [ $status == "1" ];then
        notify-send "Enabled Charging Mode"
    else
        notify-send "Enabled Conservation Mode"
    fi
    toggleConservationMode
fi
