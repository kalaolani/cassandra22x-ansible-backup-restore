#!/usr/bin/bash

TARGET=$1

/root/cassandra/test/repair.sh $TARGET
/root/cassandra/test/snapshot.sh $TARGET