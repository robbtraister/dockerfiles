#!/bin/sh

for d in $(ls); do
  if [[ -d "$d" ]]; then
    docker build -t robbtraister/$d $d && docker push robbtraister/$d
  fi;
done;
