#!/usr/bin/bash

USER=$1
PASS=$2
SNAPSHOTNAME=$3
KEYSPACE=$4
LOGFILE=$5
nodetool --username $USER --password $PASS snapshot --tag $SNAPSHOTNAME $KEYSPACE > $LOGFILE
