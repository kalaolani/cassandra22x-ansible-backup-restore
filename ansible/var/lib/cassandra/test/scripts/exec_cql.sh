#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/exec_cqls.sh target_node cql_script

CQL_TARGET=$1
CQL_SCRIPT=$2

echo "$(date): cqlsh execute file $CQL_SCRIPT on $CQL_TARGET"
echo "$(date): cqlsh $CQL_TARGET -f $CQL_SCRIPT -u cassandra -p cassandra"
cqlsh $CQL_TARGET -f $CQL_SCRIPT -u cassandra -p cassandra