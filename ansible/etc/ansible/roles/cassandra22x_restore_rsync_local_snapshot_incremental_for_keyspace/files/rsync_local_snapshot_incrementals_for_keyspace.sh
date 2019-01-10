#!/usr/bin/bash

LINK_DEST=$1
SOURCE=$2
DESTINATION=$3

rsync --archive --no-motd --exclude=manifest.json --link-dest=$LINK_DEST $SOURCE $DESTINATION