#!/usr/bin/env bash

languages=~/.config/tmux/tmux-cht-languages
commands=~/.config/tmux/tmux-cht-commands

selected=$(cat $languages $commands | fzf)
if [[ -z $selected ]]; then
  exit 0
fi

read -rp "Enter Query: " query

if grep -qs "$selected" "$languages"; then
  query=$(echo "$query" | tr ' ' '+')
  tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
