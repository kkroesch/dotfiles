#!/bin/zsh

# Kill all Tmux sessions
alias killsessions="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"

# Restoring Tmux session -- scripted
# Inspired by: https://blog.htbaa.com/news/tmux-scripting

SESSION=$USER
tmux -2 new-session -d -s $SESSION

# Setup SSH sessions
tmux new-window -t $SESSION:1 -n 'SSH'
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "ssh nx" C-m
tmux select-pane -t 1
tmux send-keys "ssh nas" C-m
tmux select-pane -t 2
tmux send-keys "ssh ime" C-m

tmux select-pane -t 0
tmux split-window -v
tmux resize-pane -D 20

# Setup a MySQL window
tmux new-window -t $SESSION:2 -n 'MySQL' 'mysql -uroot -p'

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
