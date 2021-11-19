
icons=(    )

battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)

if grep -q Charging /sys/class/power_supply/BAT1/status;then
    battery_icon=
else
    battery_icon=${icons[$(expr $battery_percent % 4)]}
fi

printf "$battery_icon $battery_percent"