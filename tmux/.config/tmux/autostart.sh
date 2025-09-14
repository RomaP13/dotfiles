#!/usr/bin/env bash

# Load project list from config
CONFIG="$HOME/.config/tmux/projects.conf"
[ -f "$CONFIG" ] && source "$CONFIG"

# Create 'playground' session if it doesn't exist
if ! tmux has-session -t=playground 2>/dev/null; then
  tmux new-session -ds playground -c ~
fi

# Loop through projects from config
for PROJECT in "${PROJECTS[@]}"; do
  if ! tmux has-session -t=$PROJECT 2>/dev/null; then
    tmux new-session -ds $PROJECT -c "$HOME/Projects/$PROJECT"
  fi
done

# Attach to the first session (playground)
tmux attach-session -t playground
