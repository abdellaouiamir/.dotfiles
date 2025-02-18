#!/bin/bash

languages=`echo "python c golang java lua cpp typescript nodejs" | tr ' ' '\n'`
core_util=`echo "xargs sed awk find git" | tr ' ' '\n'`
selected=`printf "$languages\n$core_util" | fzf`
echo $selected
read -p "qurey: " query 
if `echo $languages | grep -qs $selected`; then
  tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'`& while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
