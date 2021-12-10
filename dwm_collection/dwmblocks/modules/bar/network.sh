#!/usr/bin/bash

upicon=🔺
downicon=🔻

upinfo=
downinfo=


sleep_time=5

# Check if system is freshly booted and create temp network counter files

if [ ! -f /tmp/rx ];then
	echo 0 > /tmp/rx
	echo 0 > /tmp/tx
fi

#####################
#	Download Speed	#
#####################

prev_B=$(cat /tmp/rx)
current_B=$(cat /sys/class/net/wlan0/statistics/rx_bytes)

echo $current_B > /tmp/rx

received_B=$(expr $current_B - $prev_B)

if [ $(expr $received_B / 1024)  -gt 1024 ]
then
	downinfo="$(expr $received_B / $(expr $sleep_time \* 1024 \* 1024))MB/s"
else
	downinfo="$(expr $received_B / 1024 )KB/s"
fi


#####################
#	Upload Speed	#
#####################
prev_B=$(cat /tmp/tx)
current_B=$(cat /sys/class/net/wlan0/statistics/tx_bytes)

echo $current_B > /tmp/tx

received_B=$(expr $current_B - $prev_B)

if [ $(expr $received_B / 1024)  -gt 1024 ];then
	upinfo="$(expr $received_B / $(expr $sleep_time \* 1024 \* 1024))MB/s"
else
	upinfo="$(expr $received_B / 1024 )KB/s"
fi

printf "$upicon$upinfo $downicon$downinfo\n"