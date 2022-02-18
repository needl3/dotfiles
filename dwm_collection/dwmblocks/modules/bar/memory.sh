
icon=💾

total=$(cat /proc/meminfo | awk 'FNR == 1 {print $2}')

available=$(cat /proc/meminfo | awk 'FNR == 3 {print $2}')

used="$(expr $total - $available)"

printf "$icon$( expr $used / 1024 )"