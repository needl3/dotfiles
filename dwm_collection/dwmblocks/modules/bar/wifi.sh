#!/usr/bin/bash

findActiveInterface()
{
	intfr=
	for i in $( ip a list | grep BROADCAST | awk '{print $2}' | grep -o 'wlan[0-9]*');
	do
		if iwctl station $i show | grep disconnected > /dev/null;then
			continue
		else
			intfr=$i
		fi
	done
	if [ -z $intfr ];then
		intfr=wlan0
	fi
	printf $intfr
}

interface=$(findActiveInterface)

connect(){
	iwctl station wlan0 scan
	echo "Scanning wifi...."
	sleep 1
	networks=()
	n=0
	for i in $(iwctl station $interface get-networks | grep "\*\*\*" | awk 'FNR>1 {print $1}');do
		echo "$n: $i"
		networks+=( $i )
		n=$( expr $n + 1 )
	done

	if iwctl station $interface show | grep disconnected;then
		iwctl station $interface disconnect
	fi
	read -e -p "=> " ssid
	re='^[0-9]+$'
	if [[ $ssid =~ $re ]];then
		ssid=${networks[$ssid]}
	fi

	if [ ! $(iwctl station $interface connect "$ssid") ];then
		notify-send "Connected to WiFi network" "$ssid"
	else
		notify-send "Coundn't connect to WiFi Network" "$ssid"
	fi

}

sendNotification(){
	if ! ip a | grep $interface | grep inet;then
		notify-send "Disconnected"
		echo "/opt/dblocks_modules/bar/wifi.sh connect" | xargs st
	elif ip a | grep $interface | grep DOWN; then
		notify-send "No interface"
	elif ip a | grep $interface | grep UP; then
		notify-send " WiFi Connected" "$(iwctl station $interface show | grep Connected\ network | awk '{print $3}')"
	fi
}

if [ "$1" == "connect" ];then
	connect
elif [ "$1" == "sendNotification" ];then
	sendNotification
else
	# Choose appropriate icon
	icon=
	interface=$(findActiveInterface)

	if ip a | grep $interface | grep DOWN > /dev/null;then
		icon=🚫
	elif ! ip a | grep $interface | grep inet > /dev/null;then
		icon=📡
	elif iwctl station $interface show | grep Connected > /dev/null;then
		icon=💚
	fi

	printf "$icon"
fi
