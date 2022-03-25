#! /bin/bash
set -e

if [[ ! -f custom.ini ]]; then
    echo > custom.ini
fi


docker-compose up -d
