
vol_icons=(🔈 🔉 🔊)

vol_magnitude=$(pactl list sinks | awk 'FNR == 10 {print $5}' | grep -o '[0-9]*')

case $( pactl info | awk 'FNR==13 {print $3}' | xargs pactl get-sink-mute | awk '{print $2}' ) in
	"yes" )
		icon=🔇;;
	"no" )
		icon=${vol_icons[$(expr $vol_magnitude / 33)]}
		if [ $((vol_magnitude / 100)) ]
		then
			icon=${vol_icons[2]}
		fi;;
		*)
		icon=🔇;;
esac

printf "$icon$vol_magnitude%%"
