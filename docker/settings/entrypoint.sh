#!/bin/bash
set -e

if [[ "" != "$HOST_DOCKER_INTERNAL" ]]; then
    echo "configurando '$HOST_DOCKER_INTERNAL' host.docker.internal"
    echo "$HOST_DOCKER_INTERNAL host.docker.internal" >> /etc/hosts
else
    echo 'host debug não setado'
fi

exec docker-php-entrypoint "$@"