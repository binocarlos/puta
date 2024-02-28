#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
SESSION=$USER

command="$@"

if [[ "$command" == "stop" ]]; then
	tmux kill-session -t $SESSION
else

  if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session $SESSION already exists. Attaching..."
    sleep 1
    tmux -2 attach -t $SESSION
    exit 0;
  fi

	tmux -2 new-session -d -s $SESSION

  if [[ "$command" == "horizontal" ]]; then
    tmux split-window -h
    tmux select-pane -t 0
    tmux split-window -v
    tmux select-pane -t 2
    tmux split-window -v
    tmux select-pane -t 0
  else
    tmux split-window -v
    tmux select-pane -t 1
    tmux split-window -v
    tmux select-pane -t 0
    tmux split-window -v
  fi

	tmux -2 attach-session -t $SESSION
fi
