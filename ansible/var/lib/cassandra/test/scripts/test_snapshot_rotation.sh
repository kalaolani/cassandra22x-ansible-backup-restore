#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/test_snapshot_rotation.sh 30s cluster22 cass1.deltakappa.com cass2.deltakappa.com cass3.deltakappa.com
# sh /var/lib/cassandra/test/scripts/test_snapshot_rotation.sh 30s cluster220 cass10.deltakappa.com cass20.deltakappa.com cass30.deltakappa.com

WAIT=$1
TARGET=$2
NODE1=$3
NODE2=$4
NODE3=$5
LOG=/var/log/ansible/cassandra22x/test_snapshot_rotation.log


echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start test_snapshot_rotation" |& tee -a $LOG

echo "$(date): start - clear_all.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/clear_all.sh $TARGET
echo "$(date): end - clear_all.sh $TARGET" |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_insert_video_1-1000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_insert_video_1001-2000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_insert_video_2001-3000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_delete_video_1-1000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_delete_video_1001-2000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql_flush.sh $WAIT $TARGET $NODE2 /var/lib/cassandra/test/cql_scripts/killr_incr_delete_video_2001-3000.sql |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG


echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/exec_cql.sh $NODE2 /var/lib/cassandra/test/cql_scripts/killrvideo_alter_videos_gc_0.sql |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/repair.sh $TARGET |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/compact_keyspace.sh $TARGET killrvideo |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

sh /var/lib/cassandra/test/scripts/exec_cql.sh $NODE2 /var/lib/cassandra/test/cql_scripts/killrvideo_alter_videos_gc_864000.sql |& tee -a $LOG

echo "$(date): start - sleep $WAIT" |& tee -a $LOG
sleep $WAIT
echo "$(date): end - sleep $WAIT" |& tee -a $LOG

echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG
echo "$(date): start - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG
sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh $TARGET
echo "$(date): end - operate_snapshot_rotation.sh $TARGET" |& tee -a $LOG

echo "$(date): start - test_get_state.sh $TARGET" |& tee -a $LOG
sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) $TARGET $NODE1 $NODE2 $NODE3
echo "$(date): end - test_get_state.sh $TARGET" |& tee -a $LOG

echo "$(date): end test_snapshot_rotation" |& tee -a $LOG
echo "********************************************************************************************************************************************************************************************" |& tee -a $LOG