#!/usr/bin/bash

bat_dir="/sys/class/power_supply/BAT*"

battery_percent=$(cat $bat_dir/capacity)

case $(cat $bat_dir/status) in
    "Discharging")
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
esac
