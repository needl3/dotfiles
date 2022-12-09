#!/bin/bash

monitor=""
extendRight="$monitor "
extendLeft="s"
extendUp="$monitor "
extendDown="$monitor "
duplicate="$monitor "

chosen=$(echo "$extendRight
	$extendLeft
	$extendDown
	$extendUp
	$duplicate" | rofi -dmenu -i -l 5 -p $monitor)
echo $chosen
case $chosen in
	"s")
		sh ~/.config/scripts/extendMonitor.sh l;;
	$extendRight)
		sh ~/.config/scripts/extendMonitor.sh r;;
	$extendUp)
		sh ~/.config/scripts/extendMonitor.sh u;;
	$extendDown)
		sh ~/.config/scripts/extendMonitor.sh d;;
	$duplicate)
		sh ~/.config/scripts/extendMonitor.sh m;;
	*)
		echo "Invalid extension";;
esac

