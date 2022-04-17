2#!/bin/bash

case $1 in 
	"1" )
		pactl set-sink-volume @DEFAULT_SINK@ +2000 ;;
	"2" )
		pactl set-sink-volume @DEFAULT_SINK@ -2000 ;;
	"3" )
		pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
	"4" )
		pactl set-source-mute @DEFAULT_SOURCE@ toggle ;;
	*	)
		echo "Invalid signal"
		exit;;
esac

vol_magnitude=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Arbitrary but unique message tag
msgTag="myvolume"

if [[ $vol_magnitude == 0 || "$muted" == "yes" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted-symbolic.symbolic -h string:x-dunst-stack-tag:$msgTag "Volume muted" 
elif [[ $1 == "4" ]];then
	#Show muted mic
	if pactl get-source-mute @DEFAULT_SOURCE@ | grep yes;then
		dunstify -a "changeVolume" -i microphone-disabled-symbolic.symbolic -u low -h string:x-dunst-stack-tag:$msgTag "Mic muted"
	else
		dunstify -a "changeVolume" -i microphone-sensitivity-high-symbolic.symbolic -u low -h string:x-dunst-stack-tag:$msgTag "Mic unmuted"
	fi
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high-symbolic.symbolic -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$vol_magnitude" "Volume: ${vol_magnitude}"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
