
vol_icons=(   )

vol_magnitude=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

icon=${vol_icons[$(expr $vol_magnitude % 3)]}

printf " $icon $vol_magnitude"
