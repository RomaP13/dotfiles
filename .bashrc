# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Neovim
path_to_add="/opt/nvim/"
export_line="export PATH=\"\$PATH:$path_to_add\""
export PATH="$PATH:/opt/nvim/"

# Aliases

alias __git_find_on_cmdline='__git_find_subcommand'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias clera='clear'
alias download-movie-cover='yarn node /home/roman/Projects/js-imdb-parser/main.js'
alias edit-in-kitty='kitten edit-in-kitty'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gl='git log'
alias glg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias glp='git log --pretty=fuller'
alias grep='grep --color=auto'
alias kitten='/home/roman/.local/kitty.app/bin/kitten'
alias kitty='/home/roman/.local/kitty.app/bin/kitty'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias n='nvim'
alias tw='/home/roman/Projects/linux-stuff/twitch.sh'
alias yt='mov-cli -s youtube'

# Env vars

# export ATUIN_HISTORY_ID=01960ba3542d740f8915b79a61235df8
# export ATUIN_PREEXEC_BACKEND=1:bash-preexec
# export ATUIN_SESSION=019609a1bec7730293c7b9db24b1c344
# export ATUIN_STTY=4500:5:bf:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
export BASH_COMMAND='set > ~/recovered_set.txt'
export BASH_COMPLETION_VERSINFO=([0]="2" [1]="11")
export BP_PIPESTATUS=([0]="0")
export COLORTERM=truecolor
export EDITOR=/opt/nvim/nvim
export HISTCONTROL=ignoredups:
export HISTFILE=/home/roman/.bash_history
export HISTFILESIZE=20000
export HISTSIZE=20000
export KITTY_INSTALLATION_DIR=/home/roman/.local/kitty.app/lib/kitty
# export PATH=/home/roman/.local/openjdk-21/bin:/home/roman/.local/kitty.app/bin:/home/roman/.atuin/bin:/home/roman/.cargo/bin:/home/roman/.local/bin:/home/roman/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/nvim/:/home/roman/.local/bin/:/home/roman/.fzf/bin


. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

export PATH="$HOME/.local/share/lua-language-server/bin:$PATH"

export TERMINAL=/home/roman/.local/kitty.app/bin/kitty
