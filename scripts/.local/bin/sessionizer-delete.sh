#/usr/bin/env bash

types=$(find ~/tmux/ -mindepth 1 -maxdepth 1 -type d)
selected=$(find $types -mindepth 1 -maxdepth 1 -type d | fzf)
rm -rf "$selected"
