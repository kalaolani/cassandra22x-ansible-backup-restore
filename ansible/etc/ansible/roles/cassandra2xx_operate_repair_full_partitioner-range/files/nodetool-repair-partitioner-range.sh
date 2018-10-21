#!/usr/bin/bash
USER=$1
PASSWORD=$2
LOGFILE=$3
nodetool --username $USER --password $PASSWORD repair --full --partitioner-range > $LOGFILE