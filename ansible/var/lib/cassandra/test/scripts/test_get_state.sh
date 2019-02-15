#!/usr/bin/bash
#sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) cluster22 cass1.deltakappa.com cass2.deltakappa.com cass3.deltakappa.com
#sh /var/lib/cassandra/test/scripts/test_get_state.sh $(date +%Y%m%d_%H%M%S) cluster220 cass10.deltakappa.com cass20.deltakappa.com cass30.deltakappa.com

LOG_FILE_DATE=$1
TARGET=$2
NODE1=$3
NODE2=$4
NODE3=$5
# add more nodes here
# ...
PATH4LOG="/var/log/ansible/cassandra22x"
SNAPSHOT_LOG_FILE=$PATH4LOG/$LOG_FILE_DATE.$TARGET.1.SNAPSHOT.log
KILLRVIDEO_CNT=$PATH4LOG/$LOG_FILE_DATE.$TARGET.2.KILLRVIDEO_CNT.log
DATAPATH=$PATH4LOG/$LOG_FILE_DATE.$TARGET.3.DATAPATH.log
LOGPATH=$PATH4LOG/$LOG_FILE_DATE.$TARGET.4.LOGPATH.log
LOCALARCHPATH=$PATH4LOG/$LOG_FILE_DATE.$TARGET.5.LOCALARCHPATH.log
REMOTEARCHPATH=$PATH4LOG/$LOG_FILE_DATE.$TARGET.6.REMOTEARCHPATH.log

echo "$(date): start - test_get_state.sh $TARGET"

echo '$(date): execute playbook operate_snapshot_get_all.yml' >> $SNAPSHOT_LOG_FILE
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_get_all.yml --extra-vars "target=$TARGET" >> $SNAPSHOT_LOG_FILE

echo '$(date): execute cql script count_killrvideo.cql' >> $KILLRVIDEO_CNT
cqlsh $NODE1 -f /var/lib/cassandra/test/cql_scripts/killrvideo_count_tables.cql >> $KILLRVIDEO_CNT

echo '$(date): tree {{ cassandra22x_data_path }}' >> $DATAPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_data_path }}" >> $DATAPATH
ansible $NODE2 -m shell -a "tree -at {{ cassandra22x_data_path }}" >> $DATAPATH
ansible $NODE3 -m shell -a "tree -at {{ cassandra22x_data_path }}" >> $DATAPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_log_path }}' >> $LOGPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_log_path }}" >> $LOGPATH
ansible $NODE2 -m shell -a "tree -at {{ cassandra22x_log_path }}" >> $LOGPATH
ansible $NODE3 -m shell -a "tree -at {{ cassandra22x_log_path }}" >> $LOGPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_local_archive_path }}' >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_local_archive_path }}" >> $LOCALARCHPATH
# add more nodes here
# ...

echo '$(date): tree {{ cassandra22x_remote_archive_path }}' >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
ansible $NODE1 -m shell -a "tree -at {{ cassandra22x_remote_archive_path }}" >> $REMOTEARCHPATH
# add more nodes here
# ...

echo "$(date): end - test_get_state.sh $TARGET"