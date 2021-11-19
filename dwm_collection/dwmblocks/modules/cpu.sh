#!/usr/bin/bash

icon=

info=$(expr $(neofetch --disable --funcname cpu_usage | grep -o '[0-9]\{,\}') / 4)

temp=$($(dirname "$0")/cpu_temp.sh)

printf "$icon $info $temp"