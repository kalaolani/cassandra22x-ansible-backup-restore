#!/usr/bin/bash
USER=$1
PASSWORD=$2
KEYSPACE=$3
LOGFILE=$4
nodetool --username $USER --password $PASSWORD repair --full --partitioner-range $KEYSPACE > $LOGFILE