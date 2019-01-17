#!/usr/bin/bash

TARGET=$1

echo "$(date): nodetool clearsnapshot"
ansible $TARGET -m shell -a "nodetool clearsnapshot"
echo "$(date): remove cassandra22x_remote_archive_path"
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_remote_archive_path }}/*"
echo "$(date): remove cassandra22x_local_archive_path"
ansible $TARGET -m shell -a "rm -fR {{ cassandra22x_local_archive_path }}/*"
echo "$(date): remove cassandra22x_log_path }}/snapshot*.*"
ansible $TARGET -m shell -a "rm -f {{ cassandra22x_log_path }}/snapshot*.*"
echo "$(date): remove /etc/ansible/roles/cassandra22x/cassandra22x_restore/vars/$TARGET"
find /etc/ansible/roles/cassandra22x_restore/vars -type d -name $TARGET -exec rm -fR {} +