#!/bin/bash

echo "Use: dconnect.sh [container id]"
CID="$1"
if [ -z "$1" -o "$1"=="" -o "$1"==" " ]; then
   CID=$(docker ps | grep "meksz/owncloud:v1" | awk {'print $1'})
fi

echo "About to connect " $CID

PID=$(docker inspect --format '{{.State.Pid}}' $CID)

sudo nsenter --target $PID --mount --uts --ipc --net --pid
