
icon=🌡

info=$(sensors | grep Tctl | awk '{print $2}')

printf "$icon$info"
