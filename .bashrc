# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d "$HOME/.cargo" ]; then
	if [ -f "$HOME/.cargo/env" ]; then
		. "$HOME/.cargo/env"
	fi
fi

export PATH="$PATH:/opt/nvim-linux64/bin"

alias sudo="sudo "
alias py310="sudo update-alternatives --set python3 /usr/bin/python3.10"
alias py311="sudo update-alternatives --set python3 /usr/bin/python3.11"
alias py312="sudo update-alternatives --set python3 /usr/bin/python3.12"

uvs(){
	uvicorn main:app --reload --port "$1"
}

[[ -s "/home/zhuanpop/.gvm/scripts/gvm" ]] && source "/home/zhuanpop/.gvm/scripts/gvm"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

alias postrun="$HOME/Postman/app/postman"

bind -x '"\C-f": "$HOME/.local/scripts/tmux-session"'

gcremote(){
	git remote remove origin
	git remote add origin "$1"
}

nvconf(){
	cd "$HOME/.config/nvim" && nvim .
}
i3conf(){
	cd "$HOME/.config/i3" && nvim .
}
mongo3t(){
	cd "$HOME/studio3t"
	./Studio-3T
}
kthemes(){
	cd "$HOME/.config/kitty"
	ln -sfn ./kitty-themes/themes/"$1".conf "$HOME"/.config/kitty/theme.conf
	kill -SIGUSR1 $(pgrep kitty)
}
devterminal(){
	"$HOME/.local/scripts/tmux-dev-terminal"
}

goRunWatch(){
	nodemon --exec go run $(pwd)/main.go --signal SIGTERM
}
