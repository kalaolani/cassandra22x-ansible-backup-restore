#!/usr/bin/bash
# sh /etc/ansible/scripts/cassandra22x/operate_snapshot_rotation.sh TARGET

TARGET=$1
SNAPSHOT_UUID=$(uuidgen)
SNAPSHOT_YML="snapshot_$SNAPSHOT_UUID.yml"
LOG_DATE=$(date +%Y%m%d_%H%M%S)
LOG=/var/log/ansible/cassandra22x/$LOG_DATE.cron_script_exec.$TARGET.log

echo "$(date): BEGIN Snapshot Rotation Cron Job on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation.yml --extra-vars "target=$TARGET snapshot_uuid=$SNAPSHOT_UUID" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

if grep --quiet failed=[1-9] $LOG; then
	echo "$(date): PLAYBOOK ERROR DETECTED for operate_snapshot_rotation.yml" |& tee -a $LOG
	# todo: send email alert
	exit 0
fi

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_incremental_local_archive_clear.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_incremental_local_archive_clear.yml on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG

if grep --quiet failed=[1-9] $LOG; then
	echo "$(date): PLAYBOOK ERROR DETECTED for operate_snapshot_rotation_incremental_local_archive_clear.yml" |& tee -a $LOG
	# todo: send email alert
	exit 0
fi

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_rsync_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_rsync_clear_aged.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_rsync_clear_aged.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

if grep --quiet failed=[1-9] $LOG; then
	echo "$(date): PLAYBOOK ERROR DETECTED for operate_snapshot_rotation_rsync_clear_aged.yml" |& tee -a $LOG
	# todo: send email alert
	exit 0
fi

echo "$(date): BEGIN PLAYBOOK operate_snapshot_rotation_clear_aged_remote_archive.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_rotation_clear_aged_remote_archive.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_snapshot_rotation_clear_aged_remote_archive.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

if grep --quiet failed=[1-9] $LOG; then
	echo "$(date): PLAYBOOK ERROR DETECTED for operate_snapshot_rotation_clear_aged_remote_archive.yml" |& tee -a $LOG
	# todo: send email alert
	exit 0
fi

echo "$(date): BEGIN PLAYBOOK operate_clear_aged_logs.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_clear_aged_logs.yml --extra-vars "target=$TARGET" |& tee -a $LOG
echo "$(date): END PLAYBOOK operate_clear_aged_logs.yml for $TARGET triggered by snapshot creation $SNAPSHOT_UUID" |& tee -a $LOG

if grep --quiet failed=[1-9] $LOG; then
	echo "$(date): PLAYBOOK ERROR DETECTED for operate_clear_aged_logs.yml" |& tee -a $LOG
	# todo: send email alert
	exit 0
fi

echo "$(date): END Snapshot Rotation Cron Job on $TARGET using $SNAPSHOT_UUID" |& tee -a $LOG