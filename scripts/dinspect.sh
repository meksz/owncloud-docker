#!/bin/bash

echo "Use: dinspect.sh [container id]"
CID="$1"
if [ -z "$1" -o "$1"=="" -o "$1"==" " ]; then
   CID=$(docker ps | grep "meksz/owncloud:v1" | awk {'print $1'})
fi

IPAddress=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $CID)

echo "IP address (Container Id $CID) : $IPAddress"
