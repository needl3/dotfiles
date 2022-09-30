#!/bin/bash
case $BUTTON in
		1) echo "sh /opt/dblocks_modules/bar/bluetooth.sh connect" | xargs st ;;
		3) /opt/dblocks_modules/bar/bluetooth.sh get-connected;;
esac

