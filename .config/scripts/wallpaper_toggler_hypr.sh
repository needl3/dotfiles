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

WALLPAPER_DIR="../../.wallpaper"

changeWallpaper()
{
	readarray -t arr < /tmp/wallpaper/list
	cpt=$(cat /tmp/wallpaper/current)
	len=$(expr $(ls $WALLPAPER_DIR | wc -l) - 1 )
	next=$(expr $(expr $(expr $cpt + $1) + $len) % $len)
	echo $next > /tmp/wallpaper/current
	ln -s -f $WALLPAPER_DIR/${arr[next]} $WALLPAPER_DIR/wallpaper
}

if [ -d /tmp/wallpaper ];then
	changeWallpaper $1;
else
	# This clause will only execute in first toggle
	cpt=0
	num=$(expr $(ls $WALLPAPER_DIR | wc -l) - 1)
	arr=()

	# Store wallpapers to array and eventually to /tmp/wallpaper/list
	for i in $(ls $WALLPAPER_DIR);do
		if [ ! -L $WALLPAPER_DIR/$i ];then
			arr+=( $i )
		fi
	done

	# Store current wallpaper index
	for (( i=0; i<$num; i++));do
		if diff ${arr[$i]} $WALLPAPER_DIR/wallpaper;then
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
