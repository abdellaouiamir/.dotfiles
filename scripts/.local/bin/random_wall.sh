#!/bin/bash

WALLPAPAER_DIR=~/wallpapers
while true; do
  for img in $WALLPAPAER_DIR/*
  do
    if [[ -f "$img" && ("$img" =~ \.jpg$ || "$img" =~ \.png$) ]]; then
      sleep 300
      cp $img ~/.config/background
    fi
  done
done


