#!/bin/bash

echo "Starting..."
docker run --rm --name hugo-builder -d -v $(pwd):/cstate -e PUID=$(id -u) -e PGID=$(id -g) ghcr.io/linuxserver/baseimage-alpine-nginx:3.13 > /dev/null
docker exec -it hugo-builder apk add go git > /dev/null
docker exec -it hugo-builder wget https://github.com/gohugoio/hugo/releases/download/v0.83.1/hugo_0.83.1_Linux-64bit.tar.gz > /dev/null
docker exec -it hugo-builder tar xf hugo_0.83.1_Linux-64bit.tar.gz > /dev/null
docker exec -it -u abc hugo-builder bash -c "cd /cstate && /hugo"
docker stop hugo-builder > /dev/null
echo "Done."
