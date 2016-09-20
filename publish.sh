#!/bin/sh

for d in $(ls); do
  if [[ -d "$d" ]]; then
    (
      cd $d
      (
        if [[ -f "build.sh" ]]; then
          ./build.sh
        else
          if [[ -f "docker-compose.yml" ]]; then
            docker-compose build
          else
            docker build -t robbtraister/$d .
          fi;
        fi;
      ) && docker push robbtraister/$d
    )
  fi;
done;
