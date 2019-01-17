#!/usr/bin/bash

TARGET=$1

/root/cassandra/test/restart.sh $TARGET
/root/cassandra/test/repair.sh $TARGET