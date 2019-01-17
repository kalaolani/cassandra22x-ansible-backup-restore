#!/usr/bin/bash

#sh /var/lib/cassandra/test/scripts/test_regression_restore_snapshot_same_cluster_use_cases.sh $(date +%Y%m%d_%H%M%S) $(uuidgen) cluster22 cass1.deltakappa.com true

# parameters
LOG_FILE_DATE=$1
SNAPSHOT_UUID=$2
TARGET=$3
CQL_TARGET=$4
STABILITY=$5

# variables
SNAPSHOT_YML=snapshot_${SNAPSHOT_UUID}.yml
SNAPSHOT_KEYSPACE_YML=snapshot_${SNAPSHOT_UUID}_killrvideo.yml
TEST_LOG=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.0.TEST.log
SCRIPT_PATH=/var/lib/cassandra/test/scripts
CQL_SCRIPT_PATH=/var/lib/cassandra/test/cql_scripts
ANSIBLE_PLAYBOOK_PATH=/etc/ansible/playbooks/cassandra22x

echo "$(date): START: test" | tee $TEST_LOG

##
# clear all snapshots reset
echo "$(date): clear all and get state before test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/clear_all.sh $TARGET | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $LOG_FILE_DATE $TARGET

#
# create local snapshot test
#
echo "$(date): functional test operate_snapshot.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_snapshot.yml --extra-vars "target=$TARGET snapshot_uuid=$SNAPSHOT_UUID" | tee -a $TEST_LOG
echo "$(date): get state after operate_snapshot.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

#
# clear older than snapshot incrementals test
#
echo "$(date): functional test operate_snapshot_incremental_clear.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_snapshot_incremental_clear.yml --extra-vars "target=$TARGET snapshot_yml=$SNAPSHOT_YML" | tee -a $TEST_LOG
echo "$(date): get state after operate_snapshot_incremental_clear.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

echo "$(date): COMPLETED: create local snapshot test and clear older than snapshot incrementals test" | tee -a $TEST_LOG

##
# truncate tables in killrvideo
echo "$(date): truncate tables in killrvideo..." | tee -a $TEST_LOG
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_truncate_tables.cql | tee -a $TEST_LOG
echo "$(date): get state after truncating tables in killrvideo" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

#
# restore local snapshot test
#
echo "$(date): functional test operate_restore_local_snapshot_keyspace.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_restore_local_snapshot_keyspace.yml --extra-vars "target=$TARGET snapshot_keyspace_yml=$SNAPSHOT_KEYSPACE_YML" | tee -a $TEST_LOG
echo "$(date): get state after operate_restore_local_snapshot_keyspace.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET
if $STABILITY="true";then
	sh $SCRIPT_PATH/test_regression.sh $TEST_LOG $SCRIPT_PATH $TARGET
fi
echo "$(date): COMPLETED: restore local snapshot test" | tee -a $TEST_LOG

##
# drop killrvideo keyspace
echo "$(date): drop killrvideo keyspace" | tee -a $TEST_LOG
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_drop_keyspace.cql | tee -a $TEST_LOG
echo "$(date): get state after dropping killrvideo" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

#
# restore local snapshot new schema test
#
echo "$(date): functional test operate_restore_local_snapshot_keyspace_new_schema.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_restore_local_snapshot_keyspace_new_schema.yml --extra-vars "target=$TARGET snapshot_keyspace_yml=$SNAPSHOT_KEYSPACE_YML" | tee -a $TEST_LOG
echo "$(date): get state after operate_restore_local_snapshot_keyspace_new_schema.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET
if $STABILITY="true";then
	sh $SCRIPT_PATH/test_regression.sh $TEST_LOG $SCRIPT_PATH $TARGET
fi
echo "$(date): COMPLETED: restore local snapshot new schema test" | tee -a $TEST_LOG

##
# drop killrvideo keyspace
echo "$(date): drop killrvideo keyspace" | tee -a $TEST_LOG
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_drop_keyspace.cql | tee -a $TEST_LOG
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_data_path }}/killrvideo" | tee -a $TEST_LOG
find /etc/ansible/roles/cassandra22x_restore/vars -type f -name 'snapshot_*_killrvideo_new_schema.yml' -exec rm -fR {} +
echo "$(date): get state after dropping killrvideo, removing new_schema.ymls, and removing local killrvideo keyspace location" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

#
# restore local archived snapshot new schema test
#
echo "$(date): functional test operate_restore_local_archive_snapshot_keyspace_new_schema.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_restore_local_archive_snapshot_keyspace_new_schema.yml --extra-vars "target=$TARGET snapshot_keyspace_yml=$SNAPSHOT_KEYSPACE_YML" | tee -a $TEST_LOG
echo "$(date): get state after operate_restore_local_archive_snapshot_keyspace_new_schema.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET
if $STABILITY="true";then
	sh $SCRIPT_PATH/test_regression.sh $TEST_LOG $SCRIPT_PATH $TARGET
fi
echo "$(date): COMPLETED: restore local archived snapshot new schema test" | tee -a $TEST_LOG

##
# drop killrvideo keyspace
echo "$(date): drop killrvideo keyspace" | tee -a $TEST_LOG
sh $SCRIPT_PATH/exec_cql.sh $CQL_TARGET $CQL_SCRIPT_PATH/killrvideo_drop_keyspace.cql | tee -a $TEST_LOG
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_data_path }}/killrvideo" | tee -a $TEST_LOG
ansible $TARGET -m shell -a "rm -f {{ cassandra22x_log_path }}/snapshot_*.*" | tee -a $TEST_LOG
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_local_archive_path }}/*" | tee -a $TEST_LOG
find /etc/ansible/roles/cassandra22x_restore/vars -type f -name 'snapshot_*_killrvideo_new_schema.yml' -exec rm -fR {} +
echo "$(date): get state after dropping killrvideo, removing local killrvideo keyspace location, removing new_schema.ymls, local snapshot metadata, and the local archive" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET

#
# restore remote archived snapshot new schema test
#
echo "$(date): functional test operate_restore_remote_archive_snapshot_keyspace_new_schema.yml" | tee -a $TEST_LOG
ansible-playbook $ANSIBLE_PLAYBOOK_PATH/operate_restore_remote_archive_snapshot_keyspace_new_schema.yml --extra-vars "target=$TARGET snapshot_keyspace_yml=$SNAPSHOT_KEYSPACE_YML" | tee -a $TEST_LOG
echo "$(date): get state after operate_restore_remote_archive_snapshot_keyspace_new_schema.yml test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET
if $STABILITY="true";then
	sh $SCRIPT_PATH/test_regression.sh $TEST_LOG $SCRIPT_PATH $TARGET
fi
echo "$(date): COMPLETED: restore remote archived snapshot new schema test" | tee -a $TEST_LOG