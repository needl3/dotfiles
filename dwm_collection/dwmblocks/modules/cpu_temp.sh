
icon=

info="$(expr $(grep -o [0-9]* /sys/class/thermal/thermal_zone0/temp) / 1000)°C"

printf " $icon $info"