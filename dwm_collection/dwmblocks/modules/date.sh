#!/bin/bash
case $BUTTON in
	1)notify-send "Calendar for Today" "$(date)";;
	3)notify-send "Calendar for Today" "$(/opt/dblocks_modules/bar/date.sh 'nepali')";;
esac