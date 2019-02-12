#!/usr/bin/bash
# sh /etc/ansible/scripts/cassandra22x/operate_snapshot_adhoc.sh TARGET

TARGET=$1
SNAPSHOT_UUID=$(uuidgen)
SNAPSHOT_YML="snapshot_$SNAPSHOT_UUID.yml"
LOG=/var/log/ansible/cassandra22x/cron_script_exec.log

echo "$(date): BEGIN Snapshot Adhoc Script on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot.yml --extra-vars "target=$TARGET snapshot_uuid=$SNAPSHOT_UUID" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_local_archive.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_local_archive.yml --extra-vars "target=$TARGET snapshot_yml=$SNAPSHOT_YML" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_local_archive.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_incremental_local_archive_clear.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_archive_rsync.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_archive_rsync.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_archive_rsync.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

# echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
# ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_clear_aged.yml --extra-vars "target=$TARGET" |& tee -a $LOG
# echo "$(date): END PLAYBOOK operate_snapshot_rotation_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): END Snapshot Adhoc Script on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG