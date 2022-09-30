#!/bin/bash

case $BUTTON in
	1) /opt/dblocks_modules/bar/wifi.sh sendNotification;;
	3) echo "sh /opt/dblocks_modules/bar/wifi.sh connect" | xargs st;;
esac
