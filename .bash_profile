# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

export PATH="~/.local/bin:$PATH"
export PATH="~/go/bin":$PATH

if [[ "$(tty)" == "/dev/tty1" ]];then
  Hyprland
fi

