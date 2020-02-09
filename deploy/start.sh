#! /bin/bash
set -e
echo 'HOST_DOCKER_INTERNAL='$(hostname -I | awk '{print $1}') > .env

docker-compose up -d