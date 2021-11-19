#!/usr/bin/bash

icons=(    )

bat_dir="/sys/class/power_supply/BAT1"

battery_percent=$(cat $bat_dir/capacity)

case $(cat $bat_dir/status) in
    "Unknown")
        battery_icon=🔋;;
    
    "Discharging")
        battery_icon=${icons[$(expr $battery_percent % 4)]};;
    
    "Charging")
        battery_icon=⚡;;
    *)
        battery_icon=🚫;;
esac

printf "$battery_icon $battery_percent"