#!/usr/bin/bash

TARGET=$1

/root/cassandra/test/clear_all.sh $TARGET
/root/cassandra/test/snapshot.sh $TARGET