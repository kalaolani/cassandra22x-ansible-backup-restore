#!/usr/bin/bash
USER=$1
PASSWORD=$2
LOGFILE=$3
nodetool --username $USER --password $PASSWORD ring | grep $(hostname --ip-address) | awk '{print $NF ","}' | xargs > $LOGFILE