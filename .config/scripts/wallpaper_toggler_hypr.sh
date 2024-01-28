#!/bin/bash

# If /tmp has array and current pointer to wallpaper
	# increase or decrease the pointer
	# create new symlink to currently pointed wallpaper
	# restore nitrogen
# Else 
	# Store all files in an array
	# Get an index to current wallpaper
	# Store the array and pointer to /tmp/wallpaper
	# Repeat If clause

changeWallpaper()
{
	readarray -t arr < /tmp/wallpaper/list
	cpt=$(cat /tmp/wallpaper/current)
	len=$(expr $(ls ~/.wallpaper | wc -l) - 1 )
	next=$(expr $(expr $(expr $cpt + $1) + $len) % $len)
	echo $next > /tmp/wallpaper/current
	ln -s -f ~/.wallpaper/${arr[next]} ~/.wallpaper/wallpaper
}

if [ -d /tmp/wallpaper ];then
	changeWallpaper $1;
else
	# This clause will only execute in first toggle
	cpt=0
	num=$(expr $(ls ~/.wallpaper | wc -l) - 1)
	arr=()

	# Store wallpapers to array and eventually to /tmp/wallpaper/list
	for i in $(ls ~/.wallpaper);do
		if [ ! -L ~/.wallpaper/$i ];then
			arr+=( $i )
		fi
	done

	# Store current wallpaper index
	for (( i=0; i<$num; i++));do
		if diff ${arr[$i]} ~/.wallpaper/wallpaper;then
			echo $i > /tmp/wallpaper/current
			break
		fi
	done

	# Paste array contents to /tmp/wallpaper/list
	mkdir /tmp/wallpaper
	for i in ${arr[@]};do
		echo $i >> /tmp/wallpaper/list
	done

	# Finally change the wallpaper
	changeWallpaper $1
fi
killall hyprpaper
hyprpaper
