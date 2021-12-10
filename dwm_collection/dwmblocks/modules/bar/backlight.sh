
icon=💡

info=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ $(( $info / 900  )) -eq 1 ]
then
	info=100
else
	info=$(( $info / 10 ))
fi

printf "$icon$info%%"