#!/usr/bin/env bash

SHOW_UPTIME=$(tmux show-option -gv @show_uptime 2> /dev/null)
if [[ "$SHOW_UPTIME" == "0" ]]; then
  exit 0
fi

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/theme.sh"

RESET="#[default]"
UPTIME_RAW=$(uptime -p 2> /dev/null || uptime)
UPTIME_STR=$(echo "$UPTIME_RAW" | sed -e 's/up //' -e 's/,//g' -e 's/ hours\?/h/g' -e 's/ hour\?/h/g' -e 's/ minutes\?/m/g' -e 's/ minute\?/m/g' -e 's/ days\?/d/g' -e 's/ day\?/d/g')

separator="▒"

echo "$RESET#[fg=${THEME[orange]}]$separator 󰔟 $UPTIME_STR"
