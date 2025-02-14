#!/bin/bash

WALLPAPAER_DIR=~/Git-Repositories/anime
while true; do
  for img in $WALLPAPAER_DIR/*
  do
    if [[ -f "$img" && ("$img" =~ \.jpg$ || "$img" =~ \.png$) ]]; then
      echo "$img"
      cp $img ~/.config/background
      sleep 300
    fi
  done
done


