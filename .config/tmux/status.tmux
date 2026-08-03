#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$HOME/.config/tmux/src"

source "$CURRENT_DIR/src/theme.sh"

# Status inverval & length limits
tmux set-option -g status-interval 2
tmux set-option -g status-left-length 80
tmux set-option -g status-right-length 150

# Left status bar (Session name)
tmux set-option -g status-left "#[fg=${THEME[accent_text]},bg=${THEME[accent]},bold]  #S #[fg=${THEME[accent]},bg=default,nobold]▒#[default] "

# Window tabs
tmux set-window-option -g window-status-format "#[fg=${THEME[tab_fg]},bg=${THEME[tab_bg]}] #I:#W #[default]"
tmux set-window-option -g window-status-current-format "#[fg=${THEME[accent_text]},bg=${THEME[accent]},bold] #I:#W#F #[default]"

# Right status bar
git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
uptime="#($SCRIPTS_PATH/uptime-widget.sh)"
date_and_time="#($SCRIPTS_PATH/datetime-widget.sh)"

right_status="$git_status $uptime $date_and_time"
tmux set-option -g status-right "$right_status"
