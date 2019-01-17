#!/usr/bin/bash

TARGET=$1
CQL_TARGET=$2
CQL_SCRIPT=$3

/root/cassandra/test/exec_cql.sh $CQL_TARGET $CQL_SCRIPT
echo "$(date): sleep 15 seconds"
sleep 15
/root/cassandra/test/flush.sh $TARGET
echo "$(date): sleep 15 seconds"
sleep 15
/root/cassandra/test/snapshot.sh $TARGET
/root/cassandra/test/test_get_state.sh $TARGET