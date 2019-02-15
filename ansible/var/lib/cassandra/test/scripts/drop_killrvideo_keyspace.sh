#!/usr/bin/bash
#sh /var/lib/cassandra/test/scripts/drop_killrvideo_keyspace.sh cluster22 cass1.deltakappa.com

# parameters
TARGET=$1
CQL_TARGET=$2

# variables
SCRIPT_PATH=/var/lib/cassandra/test/scripts
CQL_SCRIPT_PATH=/var/lib/cassandra/test/cql_scripts

# drop killrvideo keyspace
echo "$(date): drop killrvideo keyspace, delete data path for killrvideo, and run clear_all.sh"
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_drop_keyspace.cql
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_data_path }}/killrvideo"