#!/bin/bash

# Original script idea using fzf from Jake@Linux. Adapted by The Linux Cast for movie watching reasons.
# 2023-11-28: Adapted to work with directory trees by barfooss
# Dependencies: fzf 

# This is the path to your movies folder
moviesDir="/home/barfooss/Videos"

# Create associative array for mapping movie names to paths (so we can have a clean fzf menu and also the complete path to the file)
declare -A movies 
while IFS=" " read -r moviePath ; do
  base=$(basename $moviePath)
  movies["$base"]="$moviePath"
done < <(find $moviesDir -type f)  

# Just some debug output, printing all movies and where they are located
for movie in "${!movies[@]}" ; do
  echo "found movie: $movie -> ${movies[$movie]}"
done

# Show our menu
menu=$(printf "%s\n" "${!movies[@]}" | uniq -u | fzf --height=100% --reverse --header-first)

# Play the file
echo "playing - ${movies[$menu]}"
exec nohup mpv "${movies[$menu]}" >/dev/null 2>&1 


