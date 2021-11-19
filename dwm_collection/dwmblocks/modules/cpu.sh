
icon=

info=$(neofetch --disable --funcname cpu_usage | grep -o '[0-9]\{,\}')

printf "$icon $info"