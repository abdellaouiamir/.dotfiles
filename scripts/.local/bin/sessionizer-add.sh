#/usr/bin/env bash

if ! [ $# -eq 1 ]; then
  echo it need one argument, the name of the tmux-session
  exit 1
fi
# select type
selected=$(find ~/Projects/ -mindepth 1 -maxdepth 1 -type d | fzf)

mkdir "$selected/$1"
