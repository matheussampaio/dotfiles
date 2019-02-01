#! /bin/bash

SESSION=`basename $PWD`

tmux new-session -d -s $SESSION 'vim'

# Rename first window and create a horizontal pane
tmux rename-window -t $SESSION:1 vim
tmux split-window -h
tmux select-pane -t 1
tmux resize-pane -R 30

# Create a window for git and a horizontal pane
tmux new-window -t $SESSION -a -n git
tmux split-window -h
tmux select-pane -t 1
tmux resize-pane -R 30

# Create a general-purpose window
tmux new-window -t $SESSION -a -n general-purpose
tmux split-window -h
tmux select-pane -t 1


# Select first window
tmux select-window -t $SESSION:1
tmux attach -t $SESSION
