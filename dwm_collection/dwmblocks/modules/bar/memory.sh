
icon=💾

total=$(free -m | awk 'FNR == 2 {print $2}')

used=$(free -m | awk 'FNR == 2 {print $3}')

mem_info="$used"

printf "$icon$mem_info"