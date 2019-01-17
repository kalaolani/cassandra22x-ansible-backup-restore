#!/usr/bin/bash

LOG_FILE_DATE=$1
TARGET=$2
NODE1=$3
NODE2=$4
NODE3=$5
# add more nodes here
# ...

SNAPSHOT_LOG_FILE=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.1.SNAPSHOT.log
KILLRVIDEO_CNT=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.2.KILLRVIDEO_CNT.log
DATAPATH=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.3.DATAPATH.log
LOGPATH=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.4.LOGPATH.log
LOCALARCHPATH=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.5.LOCALARCHPATH.log
REMOTEARCHPATH=/var/log/cassandra/test/$LOG_FILE_DATE.$TARGET.6.REMOTEARCHPATH.log

echo '$(date): execute playbook operate_snapshot_get_all.yml' >> $SNAPSHOT_LOG_FILE
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_get_all.yml --extra-vars "target=$TARGET" >> $SNAPSHOT_LOG_FILE

echo '$(date): execute cql script count_killrvideo.cql' >> $KILLRVIDEO_CNT
cqlsh $NODE1 -f /var/lib/cassandra/test/cql_scripts/killrvideo_count_tables.cql >> $KILLRVIDEO_CNT

echo '$(date): tree {{ cassandra22x_data_path }}' >> $DATAPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_data_path }}" >> $DATAPATH
ansible $NODE2 -m shell -a "tree -a {{ cassandra22x_data_path }}" >> $DATAPATH
ansible $NODE3 -m shell -a "tree -a {{ cassandra22x_data_path }}" >> $DATAPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_log_path }}' >> $LOGPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_log_path }}" >> $LOGPATH
ansible $NODE2 -m shell -a "tree -a {{ cassandra22x_log_path }}" >> $LOGPATH
ansible $NODE3 -m shell -a "tree -a {{ cassandra22x_log_path }}" >> $LOGPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_local_archive_path }}' >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_remote_archive_path }}' >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -a {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
# add more nodes here
# ...