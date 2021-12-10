#!/bin/bash
case $BUTTON in
	1)notify-send "Calendar for Today" "$(date)";;
	3)notify-send "Opening Nepali Calendar in browser";xdg-open https://nepalicalendar.rat32.com/;;
esac