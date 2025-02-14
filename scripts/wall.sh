WALL_PAPAER_DIR=~/Git-Repositories/anime
IMGS=("$WALL_PAPAER_DIR"/*)

for img in ${IMGS[@]}; do
  echo $img
  mv $img ~/.config/background
  sleep 300
done

