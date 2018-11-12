#!/bin/bash
TARGET=$1
USERNAME=$2
PASSWORD=$3
PATH=$4
LOG=$5

/usr/bin/sstableloader --verbose --nodes $TARGET --username $USERNAME --password $PASSWORD $PATH &>> $LOG