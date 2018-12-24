#!/usr/bin/bash

INCLUDE=$1
SOURCE=$2
DESTINATION=$3

rsync --archive --no-motd --include=$INCLUDE --exclude=* $SOURCE $DESTINATION