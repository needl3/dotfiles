if [[ "$(tty)" == "/dev/tty1" ]];then
	pgrep dwm || startx
fi

export PATH="~/.local/bin:$PATH"
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
. "$HOME/.cargo/env"
