#!/bin/bash

SESSION='screeps'

tmux has-session -t $SESSION 2>/dev/null

if [ $? -eq 0 ]; then
  tmux attach -t $SESSION
  exit
fi

if [ -f ~/screeps.vim ]; then
  COMMAND='vim -S ~/screeps.vim'
else
  COMMAND="vim -c ':Obsession ~/screeps.vim'"
fi

tmux new-session -d -s $SESSION -c ~/git/screeps \; \
  send-keys "$COMMAND" C-m \; \
  new-window -n cmd -c ~/git/screeps \; \
  new-window -n server -c ~/git/screeps/others/screeps-server \; \
  send-keys 'npx screeps start' C-m \; \
  split-window -h -c ~/git/screeps/others/screeps-server \; \
  send-keys 'npx screeps cli' \; \
  select-window -t 1 \; \
  split-window -h -p 6 -c ~/git/screeps \; \
  send-keys 'SCREEPS_BRANCH=sim SCREEPS_PRIVATE_SERVER=true npm run dev' C-m \; \
  split-window -v -c ~/git/screeps/others/screeps-logs \; \
  send-keys 'SCREEPS_PRIVATE_SERVER=true npm start' C-m \; \
  select-pane -t 1 \; \
  attach \;
