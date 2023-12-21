#!/usr/bin/bash
RED=$'\e[31m'
YELLOW=$'\e[33m'
GREEN=$'\e[32m'
ENDCOLOR=$'\e[0m'

if ! xrandr -v &> /dev/null;then
	echo "${RED}[X] XRANDR not installed${ENDCOLOR}" 
	exit 1
fi
# Get active displays
DISPLAYS=()
xrandr --listactivemonitors | awk 'FNR>1 {print $4}' | while read l; 
do
	DISPLAYS+=("$l")
done

PRIMARY="$(xrandr --listactivemonitors | awk 'FNR==2 {print $4}')"
SECONDARY="$(xrandr --listactivemonitors | awk 'FNR==3 {print $4}')"

RES="$(xrandr | grep "\*" | awk '{print $1}' | head -n 1)"

[[ $SECONDARY == "" ]] && SECONDARY="HDMI-1-0"
xrandr --output "$SECONDARY" --auto

if [[ $1 == "r" ]];then
	xrandr --output "$PRIMARY" --mode $RES --left-of "$SECONDARY"
elif [[ $1 == "l" ]];then
	xrandr --output "$PRIMARY" --mode $RES --right-of "$SECONDARY"
elif [[ $1 == "u" ]];then
	xrandr --output "$PRIMARY" --mode $RES --below "$SECONDARY" 
elif [[ $1 == "d" ]];then
	xrandr --output "$PRIMARY" --mode $RES --above "$SECONDARY"
elif [[ $1 == "k" ]];then
	xrandr --output "$SECONDARY" --off
elif [[ $1 == "m" ]];then
	xrandr --output "$SECONDARY" --auto --mode $RES --same-as "$PRIMARY"
else
	echo "${YELLOW}Usage: ./extendMonitor.sh {l/r/u/d}${ENDCOLOR}"
	if notify-send -v &> /dev/null;then
		notify-send "Failed to extend to $1"
		exit 1
	fi
fi

