if [[ "$(tty)" == "/dev/tty1" ]];then
	pgrep dwm || startx
fi

export PATH="~/.local/bin:$PATH"
