#!/usr/bin/bash

if ps aux | grep -E "[0-9]+:[0-9]+ waybar$";
then
  killall waybar
else
  waybar
fi
