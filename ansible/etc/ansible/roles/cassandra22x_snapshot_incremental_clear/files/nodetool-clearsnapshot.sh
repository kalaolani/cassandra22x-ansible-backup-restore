#!/usr/bin/bash
USER=$1
PASSWORD=$2
SNAPSHOTNAME=$3
KEYSPACE=$4
nodetool --username $USER --password $PASSWORD clearsnapshot -t $SNAPSHOTNAME $KEYSPACE