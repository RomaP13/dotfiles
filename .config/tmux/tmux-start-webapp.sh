#!/bin/bash

tmux new -s work -d

tmux rename-window -t work editor
tmux send-keys -t editor "cd Projects/spotify-web-app" C-m

tmux send-keys -t editor "nvim ." C-m

tmux new-window -t work
tmux rename-window -t work django

tmux send-keys -t django "cd Projects/spotify-web-app/backend" C-m
tmux send-keys -t django "clear" C-m
tmux send-keys -t django "poetry run python3 manage.py runserver"

tmux new-window -t work
tmux rename-window -t work redis

tmux send-keys -t redis "cd Projects/spotify-web-app/backend" C-m
tmux send-keys -t redis "clear" C-m
tmux send-keys -t redis "sudo docker run -p 6379:6379 -it redis/redis-stack:latest"

tmux select-window -t work:0
tmux attach -t work
