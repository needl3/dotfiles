#!/usr/bin/bash

# Choose appropriate icon
icon=
if ip a | grep wlan0 | grep DOWN > /dev/null;then
	icon=🚫
elif ! ip a | grep wlan0 | grep inet > /dev/null;then
	icon=📡
elif iwctl station wlan0 show | grep Connected > /dev/null;then
	icon=💚
fi

printf "$icon"