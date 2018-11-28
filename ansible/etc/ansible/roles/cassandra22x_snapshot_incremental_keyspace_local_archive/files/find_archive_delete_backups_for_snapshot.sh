#!/usr/bin/bash

SEARCH_PATH=$1
REFERENCE_FILE=$2
ARCHIVE_FILE=$3
ARCHIVE_FORMAT=$4

if [ $ARCHIVE_FORMAT -eq 'gz' ]; then
		find $SEARCH_PATH -type f -newer $REFERENCE_FILE -print0 | tar -czf $ARCHIVE_FILE --remove-files --null -T -
elif [ $ARCHIVE_FORMAT -eq 'bz2' ]; then
        find $SEARCH_PATH -type f -newer $REFERENCE_FILE -print0 | tar -cjf $ARCHIVE_FILE --remove-files --null -T -
elif [ $ARCHIVE_FORMAT -eq 'xz' ]; then
        find $SEARCH_PATH -type f -newer $REFERENCE_FILE -print0 | tar -cJf $ARCHIVE_FILE --remove-files --null -T -
else
        find $SEARCH_PATH -type f -newer $REFERENCE_FILE -print0 | tar -cf $ARCHIVE_FILE --remove-files --null -T -
fi