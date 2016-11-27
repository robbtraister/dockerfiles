#!/bin/sh

(
  cd $(dirname "$0")

  ./nginx.conf.sh > ./nginx.conf

  echo "Starting nginx"

  nginx -p ./ \
        -c ./nginx.conf \
        -g "daemon off; pid ./nginx.pid;"
)
