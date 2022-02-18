#!/usr/bin/bash

bat_dir="/sys/class/power_supply/BAT1"

battery_percent=$(cat $bat_dir/capacity)

case $(cat $bat_dir/status) in
    "Unknown")
        battery_icon=🔋;;
    
    "Discharging")
        battery_icon=⚡
        if [ $battery_percent -lt 20 ]
        then
             notify-send "Low battery!
  Computer will shutdown at 15%" -u critical -i /usr/share/icons/Adwaita/32x32/status/battery-level-20-symbolic.symbolic.png
            canberra-gtk-play -i audio-volume-change -d "LowBattery"

            if [ $battery_percent -lt 15 ]
            then
                shutdown +1
            fi

        fi
        ;;
    
    "Charging")
        battery_icon=🔌;;
    *)
        battery_icon=🚫;;
esac

printf "$battery_icon$battery_percent"