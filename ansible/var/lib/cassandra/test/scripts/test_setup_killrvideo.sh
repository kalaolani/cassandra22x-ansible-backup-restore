#!/usr/bin/bash

#sh /var/lib/cassandra/test/scripts/test_setup_killrvideo.sh cluster22 cass1.deltakappa.com

# parameters
TARGET=$1
CQL_TARGET=$2

# variables
SCRIPT_PATH=/var/lib/cassandra/test/scripts
CQL_SCRIPT_PATH=/var/lib/cassandra/test/cql_scripts

echo "$(date): START: killrvideo keyspaces setup"
##
# drop killrvideo keyspace
echo "$(date): drop killrvideo keyspace, delete data path for killrvideo, and run clear_all.sh"
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_drop_keyspace.cql
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_data_path }}/killrvideo"
sh $SCRIPT_PATH/clear_all.sh $TARGET
##
# create killrvideo keyspace
echo "$(date): create killrvideo keyspace"
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_create_schema.cql
##
# import test data
echo "$(date): create killrvideo keyspace"
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_data_import.cql

echo "$(date): get state"
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET