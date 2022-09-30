#!/bin/bash

# Color definitions
green=$'\e[0;92m'
red=$'\e[0;91m'
blue=$'\e[1;34m'
yellow=$'\e[0;33m'
reset=$'\e[0m'

function connect(){
	if ! bluetoothctl -v > /dev/null;then
		echo "${red}Blueoothctl not install. Install bluez-utils.${reset}"
	else
		if ! systemctl status bluetooth > /dev/null;then
			echo "${red}Bluetooth service not active. Activate and try again${reset}"
		else
			if [ "$(bluetoothctl show | grep Powered: | awk '{print $2}')" == "no" ];then
				notify-send "Bluetooth powered off"
				exit 1
			fi
			echo "${yellow}----------------------------${reset}"
			local c=$(listConnected)
			if [ "$c" != "" ];then
				echo "${blue}Currently connected to: ${green}$c${reset}"
				read -p "${blue}Do you want to connect to some other device?(Y/N)${green}" d
				if [[ "$d" != "Y" || "$d" != "y" ]];then
					exit 0
				fi
			fi

			echo "${yellow}----------------------------${reset}"
			echo "${blue}Stop scanning if you found your devices: Ctrl+C${reset}"
			for i in $(bluetoothctl devices | awk '{print $2}');do
				bluetoothctl remove $i
			done
			bluetoothctl scan on
			dev=$(bluetoothctl devices | tr ' ' '\n')
			echo "${yellow}----------------------------${reset}"
			echo "${blue}Select device to connect from list:${green}"
			mac=false
			name=false
			MAC=()
			NAME=()
			dev_no=-1
			for i in $dev;do
				if [ "$i" == 'Device' ];then
					mac=true
					dev_no="$( expr $dev_no + 1)"
				elif $mac;then
					MAC+=($i)
					mac=false
					name=true
					NAME+=()
				elif $name;then
					NAME[$dev_no]+=" $i"
				fi
			done
			for (( i=0;i<=$dev_no;i++)) ;do
				echo "$i: ${NAME[$i]} - ${MAC[$i]}"
			done
			invalidInput=true
			while $invalidInput;do
				echo "${yellow}----------------------------${reset}"
				read -p "${blue}Enter device number: ${green}" no
				echo "${yellow}----------------------------${reset}"
				re='^[0-9]+$'
				if [[ "$no" =~ $re && $no -ge 0 && $no -le $dev_no ]];then
					bluetoothctl disconnect
					bluetoothctl trust ${MAC[no]}
					bluetoothctl pair ${MAC[no]}
					if bluetoothctl connect ${MAC[no]};then
						notify-send "Connected to ${NAME[$no]}"
					else
						notify-send "Failed to connect"
					fi
					invalidInput=false
				else
					echo "${red}Invalid input${reset}"
				fi
			done	
		fi
	fi
}
function listConnected(){
	local connected=""
	for i in $(bluetoothctl devices | awk '{print $2}');do
		if [ "$(bluetoothctl info $i | grep Connected: | awk '{print $2}')" == "yes" ];then
			connected=$(bluetoothctl info $i | grep Name: | awk '{print $2}');
		fi
	done
	printf "$connected"
}

function getConnected(){
	if [ "$(bluetoothctl show | grep Powered: | awk '{print $2}')" == "no" ];then
		notify-send "Bluetooth powered off"
		exit 1
	fi
	if [ "$(bluetoothctl show | grep Discoverable: | awk '{print $2}')" == "no" ];then
		bluetoothctl discoverable yes
		bluetoothctl pairable yes
		notify-send "Making device visible"
	else
		bluetoothctl discoverable no
		bluetoothctl pairable no
		notify-send "Disabling visibility"
	fi
}

if [ "$1" == "connect" ];then
	connect
elif [ "$1" == "get-connected" ];then
	getConnected
else
	if [ "$(bluetoothctl show | grep Powered: | awk '{print $2}')" == "no" ];then
		printf "⛔"
	else
		if [ listConnected != "" ];then
			printf "🎧"
		else
			printf "💤"
		fi
	fi
fi
