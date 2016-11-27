#!/bin/bash

cat <<EOB
worker_processes auto;

events {
  worker_connections ${WORKERS:-8192};
}

http {
  include /etc/nginx/mime.types;

EOB

IFS=$'\n' lines=($(cat "./ports" | grep -v '^\s*\#')))
for line in ${lines[@]}; do
  IFS=$' \t' values=($line)
  port=${values[0]}
  domains=${values[@]:1}

cat <<EOB
  server {
    listen ${PORT:-8080};
    server_name ${domains};

    location / {
      proxy_set_header "X-Forwarded-For" \$proxy_add_x_forwarded_for;
      proxy_set_header "X-Forwarded-Host" \$host;
      proxy_set_header "Host" \$host;

      proxy_pass http://${HOST_IP:-localhost}:${port};
    }
  }
EOB
done;

cat <<EOB
}
EOB
