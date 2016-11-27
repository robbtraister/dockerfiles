#!/bin/sh

(
  cd $(dirname "$0")

  lastMod=0
  while true; do
    thisMod=$(stat -L -c "%Y" "./ports")
    if [[ $thisMod -ne $lastMod ]]; then
      lastMod=$thisMod
      killall -9 nginx 2> /dev/null
      sleep 1
      ./start.sh &
    fi;
    sleep 1;
  done;
)
