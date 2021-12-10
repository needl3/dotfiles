#!/usr/bin/bash

# Choose appropriate icon
icon=

interface=$(ip a list | awk 'FNR==9 {print $2}' | grep -o '[a-z0-9]*')

if ip a | grep $interface | grep DOWN > /dev/null;then
	icon=🚫
elif ! ip a | grep $interface | grep inet > /dev/null;then
	icon=📡
elif iwctl station $interface show | grep Connected > /dev/null;then
	icon=💚
fi

printf "$icon"