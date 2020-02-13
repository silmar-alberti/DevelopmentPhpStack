#! /bin/bash
set -e
echo 'HOST_DOCKER_INTERNAL='$(hostname -I | awk '{print $1}') > .env

if [[ ! -f custom.ini ]]; then
    echo > custom.ini
fi


docker-compose up -d