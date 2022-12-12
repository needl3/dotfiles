#!/bin/bash
icon=📨
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

intfr=$(findActiveInterface)
ip=$(ip a | grep -E ".* inet .* $intfr"| awk '{print $2}' | cut -c 8-)
if [ -z ip ];then
	ip="XXX.XXX.XXX.XXX"
fi
printf "$icon$ip"
