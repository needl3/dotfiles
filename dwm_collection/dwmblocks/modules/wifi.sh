#!/bin/bash

interface=$(ip a list | awk 'FNR==9 {print $2}' | grep -o '[a-z0-9]*')

connect(){
	notify-send "Opening Connection Instance"
	iwctl station $interface scan
	st bash -c "\
	clear;\
	echo Scanning for WiFi Networks.....;\
	sleep 1;\
	read ssid;\
	iwctl station $interface connect $ssid;\
	"&
	disown
	sleep 1
	max=0
	for i in $(ls /dev/pts)
	do
	  test $i -gt $max 2> /dev/null
	  if [ $? -le 1 ]
	  then
	    max=$i
	  fi
	done
	iwctl station wlan0 get-networks > /dev/pts/$max;
	echo "Enter WiFi Name to connect to" > /dev/pts/$max
}
sendNotification(){
	if ! ip a | grep $interface | grep inet > /dev/null;then
		notify-send "Disconnected"
		connect
	elif ip a | grep $interface | grep DOWN; then
		notify-send "No interface" "$(st bash -c "ip a;read")"
	elif ip a | grep $interface | grep UP; then
		notify-send " Wifi" "$(iwconfig | grep $interface)"
	fi
}
case $BUTTON in
	1) sendNotification;;
	3) connect;;
esac