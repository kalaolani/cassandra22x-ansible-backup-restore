#!/usr/bin/bash

SOURCE=$1
DESTINATION=$2

rsync --archive --no-motd $SOURCE $DESTINATION