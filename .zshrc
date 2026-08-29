# Atuin. Bind ctrl-r but not up arrow

eval "$(atuin init zsh --disable-up-arrow)"

# Zoxide

eval "$(zoxide init zsh)"

# Media

export MEDIA="/mnt/OOS750G"

# Exports

export PATH="$HOME/.local/bin:$PATH"

# Default editor

export EDITOR="nvim"

# Zsh prompt

PS1='%F{blue}%~ %F{magenta}❯%f '

# Aliases

alias clera='clear'
alias download-movie-cover='yarn node ~/Projects/js-imdb-parser/main.js'
alias download-movie-cover='~/Projects/imdb-parser/.venv/bin/python3 ~/Projects/imdb-parser/main.py'
alias download='~/.local/scripts/downloader'
alias download_many='~/.local/scripts/batch-downloader'

alias gl='git log'
alias glg='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias glp='git log --pretty=fuller'

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias n='nvim'
alias grep='grep --color=auto'

alias dots="~/dotfiles/dots.sh"

# Useful commands

cdf() {
  local dir
  dir=$(find . -type d 2> /dev/null | fzf) || return
  cd -- "$dir" || exit
}

editbook() {
  local file="$1"
  local mtime
  mtime=$(stat -c %y "$file")
  echo "Saved: $mtime"

  nvim "$file"

  touch -m -d "$mtime" "$file"
}
