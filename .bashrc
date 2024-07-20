#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=vim

# Aliases with color
alias ls="ls --color"
alias cds="cd ~/coding/job/stf-web"
alias cdd="cd ~/gitClones/dotfiles"

f(){
	find $1 -type f 2> /dev/null | grep -i $2
}

downloadMusic()
{
	# Downloads youtube music playlist
	# Usage: downloadMusic <playlist url with or without index parameter>
	if [ "$1" != "" ];
	then
		youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" --yes-playlist "https://youtube.com/playlist?$(echo $1 | grep -E -o 'list=.*' | grep -E -o '^[^&]+')"
	else
		echo "No url provided. Please pass playlist url"
	fi
}
_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING=1
neofetch --config $HOME/.config/neofetch/config-bashrc.conf

eval "$(rbenv init - bash)"

export NVM_DIR="$HOME/.nvm"
export GNUPGHOME="$HOME/.gnupg"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

cd ~
. "$HOME/.cargo/env"
eval "$(starship init bash)"
eval "$(direnv hook bash)"
