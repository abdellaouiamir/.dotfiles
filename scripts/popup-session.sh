#!/bin/bash
session_name="popup-session"

if ! tmux has-session -t $session_name 2>/dev/null; then
  tmux new-session -d -s $session_name
  tmux set-option -t "$session_name" detach-on-destroy on
  tmux set-option -t "$session_name" status off
  # tmux unbind-key u
fi
tmux popup \
  -S fg="magenta" \
  -s fg="blue" \
  -T "Scratch" \
  -w "80%" \
  -h "80%" \
  -b rounded \
  -E \
  "tmux attach-session -t \"$session_name\""
