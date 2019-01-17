#!/usr/bin/bash

TARGET=$1

/root/cassandra/test/flush.sh $TARGET
echo "$(date): sleep 15 seconds"
sleep 15
/root/cassandra/test/snapshot.sh $TARGET