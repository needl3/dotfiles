
vol_icons=(🔈 🔉 🔊)

vol_magnitude=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
vol_magnitude=${vol_magnitude::-1}

case $( pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}' ) in
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

printf "$icon$vol_magnitude%% "
