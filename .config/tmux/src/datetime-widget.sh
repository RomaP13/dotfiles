#!/usr/bin/env bash

SHOW_DATETIME=$(tmux show-option -gv @show_datetime 2> /dev/null)
if [[ $SHOW_DATETIME == "0" ]]; then
  exit 0
fi

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/theme.sh"

RESET="#[default]"
time_string=$(date +"%H:%M")
separator="▒"

echo "$RESET#[fg=${THEME[white]}]$separator 󰥔 $time_string"
