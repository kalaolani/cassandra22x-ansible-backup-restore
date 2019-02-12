#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh 15s cluster220 cass10.deltakappa.com /var/lib/cassandra/test/cql_scripts/killr_incr_insert_video_1-1000.sql

WAIT=$1
TARGET=$2
CQL_TARGET=$3
CQL_SCRIPT=$4

echo "$(date): /var/lib/cassandra/test/scripts/exec_cql_flush.sh"
/root/cassandra/test/exec_cql.sh $CQL_TARGET $CQL_SCRIPT
echo "$(date): sleep $WAIT"
sleep $WAIT
/root/cassandra/test/flush.sh $TARGET