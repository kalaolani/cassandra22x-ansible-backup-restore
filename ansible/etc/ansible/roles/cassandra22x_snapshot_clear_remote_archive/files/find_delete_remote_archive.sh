#!/usr/bin/bash

SEARCH_PATH=$1
SNAPSHOT=$2

find $SEARCH_PATH -type f -name $SNAPSHOT -delete