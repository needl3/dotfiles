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