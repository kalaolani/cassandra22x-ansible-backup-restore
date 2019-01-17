#!/usr/bin/bash

TARGET=$1

/root/cassandra/test/clear_all.sh $TARGET
/root/cassandra/test/repair.sh $TARGET
/root/cassandra/test/restart.sh $TARGET
/root/cassandra/test/snapshot.sh $TARGET