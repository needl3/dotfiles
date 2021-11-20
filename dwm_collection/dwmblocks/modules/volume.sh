
vol_icons=(🔇   )

vol_magnitude=$(pactl list sinks | awk 'FNR == 10 {print $5}' | grep -o '[0-9]*')

icon=${vol_icons[$(expr $vol_magnitude / 25)]}

printf "$icon $vol_magnitude%%"
