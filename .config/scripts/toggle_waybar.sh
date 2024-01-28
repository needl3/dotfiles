#!/usr/bin/bash

if ps aux | grep -E waybar$;
then
  killall waybar
else
  waybar
fi
