#!/bin/bash

SHARING_PATH="/home/umut/projects/bayindir/docker/shared"

VOLUME1="$SHARING_PATH/mysql:/var/lib/mysql"
VOLUME2="$SHARING_PATH/oc-data:/var/owncloud/data"
VOLUME3="$SHARING_PATH/oc-www:/var/www/owncloud"

#docker run -d -i -t -m 1g -p 80:80 --name owncloud -v $VOLUME1 -v $VOLUME2 meksz/owncloud:v1

docker run -d -i -t -p 80:80 -p 443:443 --name owncloud -v $VOLUME1 -v $VOLUME2 -v $VOLUME3 meksz/owncloud:v1
