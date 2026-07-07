# Atuin. Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# Media
export MEDIA="/run/media/roman/OOS750GB"

# Default editor
export EDITOR="nvim"

# Zsh prompt

PS1='%F{blue}%~ %F{magenta}❯%f '
# PS1='%F{blue}%~ %(?.%F{magenta}❯%f.%F{magenta}❯%f) '

# Aliases

alias clera='clear'
alias download-movie-cover='yarn node ~/Projects/js-imdb-parser/main.js'
alias download-movie-cover='~/Projects/imdb-parser/.venv/bin/python3 ~/Projects/imdb-parser/main.py'
alias download='~/.local/bin/downloader.sh'
alias download_many='~/.local/bin/batch_downloader.sh'

alias gl='git log'
alias glg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias glp='git log --pretty=fuller'

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias n='nvim'
alias grep='grep --color=auto'
alias tmax='~/dots/tmux/.config/tmux/autostart.sh'

alias twitch='~/Projects/linux-stuff/twitch.sh'

nvimrc() {
  cd ~/.config/nvim && nvim .
  cd ~
}

kittyrc() {
  cd ~/.config/kitty && nvim kitty.conf
  cd ~
}

export PATH="$HOME/.local/bin:$PATH"
