#!/usr/bin/bash

SEARCH_PATH=$1
REFERENCE_FILE_NEWER=$2
REFERENCE_FILE_NOT_NEWER=$3
LINK_DEST=$4
SOURCE=$5
DESTINATION=$6

find $SEARCH_PATH -type f -newer $REFERENCE_FILE_NEWER ! -newer $REFERENCE_FILE_NOT_NEWER -printf %P\\0|rsync --archive --no-motd --files-from=- --from0 --exclude=manifest.json --link-dest=$LINK_DEST $SOURCE $DESTINATION