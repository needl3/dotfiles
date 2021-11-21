
icon=💡

info=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ $(( $info / 900  )) ]
then
	info=100
fi

printf "$icon $info%%"