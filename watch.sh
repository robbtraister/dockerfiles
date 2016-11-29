#!/bin/sh

(
  cd $(dirname "$0")

  lastMod="-1"
  while true; do
    thisMod=$(stat -L -c "%Y" "./src/ports" 2> /dev/null)
    if [[ $thisMod -ne $lastMod ]]; then
      lastMod=$thisMod
      killall -9 nginx 2> /dev/null
      sleep 1
      ./start.sh &
    fi;
    sleep 1;
  done;
)
