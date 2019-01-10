#!/usr/bin/bash

SEARCH_PATH=$1
REFERENCE_FILE=$2

find $SEARCH_PATH -type f ! -newer $REFERENCE_FILE -delete