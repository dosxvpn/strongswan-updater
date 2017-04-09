#!/usr/bin/env sh
set -e
CONTAINER="dosxvpn"
IMAGE="dosxvpn/strongswan"
CID=$(docker ps -q -f name=dosxvpn)
docker pull $IMAGE

LATEST=`docker inspect --format "{{.Id}}" $IMAGE`
RUNNING=`docker inspect --format "{{.Image}}" $CID`
echo "Latest:" $LATEST
echo "Running:" $RUNNING
if [ "$RUNNING" != "$LATEST" ];then
    echo "Upgrading $CONTAINER"
    # just stop - let systemd handle starting container
    docker stop $CONTAINER
else
    echo "$CONTAINER up to date"
fi
