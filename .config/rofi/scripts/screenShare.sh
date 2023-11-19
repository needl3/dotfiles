#!/bin/bash

monitor=""
prepareSingleSetup="     Prepare single setup"
prepareDualSetup="$monitor     $monitor  Prepare dual setup"
extendRight="$monitor     Extend right"
extendLeft="$monitor     Extend Left"
extendUp="$monitor     Extend up"
extendDown="$monitor     Extend down"
duplicate="$monitor $monitor  Duplicate"

chosen=$(echo "$prepareSingleSetup
$prepareDualSetup
$extendLeft
$extendRight
$extendDown
$extendUp
$duplicate
$killScreen" | rofi -dmenu -i -l 5 -p $monitor)
case $chosen in
	$prepareSingleSetup)
		st -e sudo sh ~/.config/scripts/nvidia_toggle_xorg.sh --amd;;
	$prepareDualSetup)
		st -e sudo sh ~/.config/scripts/nvidia_toggle_xorg.sh --multi-monitor;;
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

