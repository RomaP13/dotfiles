#!/bin/bash

# start a new session called server 
tmux new -s work -d

# rename the window to vim
tmux rename-window -t work server

tmux send-keys -t server "cd Projects/miniapp/" C-m
tmux send-keys -t server "pipenv shell" C-m

# Wait for a moment to ensure pipenv shell is fully activated
sleep 2

tmux send-keys -t server "clear" C-m

# Open a new window
tmux new-window -t work
tmux rename-window -t work editor
tmux send-keys -t work "cd Projects/miniapp/" C-m
tmux send-keys -t work "pipenv shell" C-m

# Wait for a moment to ensure pipenv shell is fully activated
sleep 2

# Send the nvim command
tmux send-keys -t work "nvim ." C-m

tmux select-window -t work:1
tmux attach -t work
