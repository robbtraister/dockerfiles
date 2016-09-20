#!/bin/sh

for d in $(ls); do
  if [[ -d "$d" ]]; then
    (
      cd $d
      if [[ -f "build.sh" ]]; then
        ./build.sh && docker push robbtraister/$d
      else
        if [[ -f "docker-compose.yml" ]]; then
          docker-compose build && docker push robbtraister/$d
        else
          docker build -t robbtraister/$d . && docker push robbtraister/$d
        fi;
      fi;
    )
  fi;
done;
