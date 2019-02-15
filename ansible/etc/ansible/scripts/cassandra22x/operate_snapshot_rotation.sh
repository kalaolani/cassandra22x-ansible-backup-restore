#!/usr/bin/bash
# sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh TARGET

TARGET=$1
SNAPSHOT_UUID=$(uuidgen)
SNAPSHOT_YML="snapshot_$SNAPSHOT_UUID.yml"
LOG=/var/log/ansible/cassandra22x/cron_script_exec.$TARGET.log

echo "$(date): BEGIN Snapshot Rotation Cron Job on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation.yml --extra-vars "target=$TARGET snapshot_uuid=$SNAPSHOT_UUID" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_incremental_local_archive_clear.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_rsync_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_rsync_clear_aged.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_rsync_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_clear_aged_remote_archive.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_clear_aged_remote_archive.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_clear_aged_remote_archive.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): END Snapshot Rotation Cron Job on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG