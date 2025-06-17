#!/bin/bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/tmux/docker ~/tmux/Notes ~/tmux/work ~/tmux/study ~/tmux/go ~/tmux/vim-with-me ~/tmux/github_repo -mindepth 1 -maxdepth 1 -type d | fzf)
fi
# no option selected
if [[ -z $selected ]]; then
  exit 0
fi
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# Condition: outside of tmux and it's not running in the background
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected
  exit 0
fi
# Condition: Create session if it's not has been created
if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi
# Condition: outside of tmux and it's running in the background
if [[ -z $TMUX ]]; then
  tmux a -t $selected_name
  exit 0
fi
# Condition: inside of tmux
tmux switch-client -t $selected_name
