#!/usr/bin/bash
if [ $1 == "set" ];then
    toggleConservationMode
    notify-send 'Enabled Charging mode for upto 80%'
    while [ $(cat /sys/class/power_supply/BAT1/capacity) -lt 80 ]
    do
        sleep 60
        cat /sys/class/power_supply/BAT1/capacity
    done
    toggleConservationMode
else
    status=$(cat /sys/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/conservation_mode)
    if [ $status == "1" ];then
        notify-send "Enabled Charging Mode"
    else
        notify-send "Enabled Conservation Mode"
    fi
    toggleConservationMode
fi