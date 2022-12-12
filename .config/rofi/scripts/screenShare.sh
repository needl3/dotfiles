#!/bin/bash

monitor=""
extendRight="$monitor "
extendLeft="$monitor "
extendUp="$monitor "
extendDown="$monitor "
duplicate="$monitor "

chosen=$(echo "$extendLeft
$extendRight
$extendDown
$extendUp
$duplicate
$killScreen" | rofi -dmenu -i -l 5 -p $monitor)
case $chosen in
	$extendLeft)
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

