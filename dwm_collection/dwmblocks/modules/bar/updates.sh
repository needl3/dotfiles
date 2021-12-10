
icon=🛠

updates=$(pacman -Qu | wc -l)

printf "$icon $updates"