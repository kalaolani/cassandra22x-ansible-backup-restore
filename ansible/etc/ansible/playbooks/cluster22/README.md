# cassandra22x-ansible-backup-restore ansible playbooks 
Notes 
- all of the sample ansible and ansible-playbook commands assume pwd = /etc/ansible
- see var/log/ansible/cassandra22x/cluster22/ for sample log files for each node of the sample environment
### Using the playbooks/cluster22/cassandra22x_snapshot.yml playbook
This playbook creates snapshots.
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot.yml -e "snapshot_uuid=$(uuidgen)" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_$(date +%Y%d%m%H%M%s).log
```
#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot.yml playbook
```
ansible cluster22 -a"nodetool listsnapshots" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_nodetool_listsnapshots_$(date +%Y%d%m%H%M%s).log
ansible cluster22 -m shell -a"ls {{ cassandra22x_data_path }}/killrvideo/*/snapshots"  | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_killrvideo_snapshot_ls__$(date +%Y%d%m%H%M%s).log
ansible cluster22 -m shell -a"ls {{ cassandra22x_data_path }}/killrvideo/*/snapshots"/*  | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_killrvideo_snapshot_contents_ls__$(date +%Y%d%m%H%M%s).log
```
### Using the playbooks/cluster22/cassandra22x_snapshot_get_all.yml
This playbook lists all ansible managed snapshots sorted by mtime of the snapshot_uuid.yml files in etc/roles/cassandra22x_restore/vars/cluster22/node/.
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_get_all.yml
```
### Using the playbooks/cluster22/cassandra22x_snapshot_get_for_yml.yml
This playbook lists all ansible managed snapshots sorted by mtime of the snapshot_uuid.yml files in etc/roles/cassandra22x_restore/vars/cluster22/node/.
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_get_for_yml.yml -e"snapshot_yml=snapshot_yml.yml"
```
### Using the playbooks/cluster22/cassandra22x_snapshot_local_archive.yml
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_local_archive.yml -e "snapshot_yml=snapshot_953485c7-275c-4e97-95b4-849613929621.yml" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_local_archive_snapshot_953485c7-275c-4e97-95b4-84961392962_$(date +%Y%d%m%H%M%s).log
```
#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot_local_archive.yml playbook
Using Ansible to see it all...
```
[root@ansible ansible]# ansible cluster22 -m shell -a "ls {{ cassandra22x_remote_archive_path }}/archived_logs"

cass1.deltakappa.com | CHANGED | rc=0 >>
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

cass2.deltakappa.com | CHANGED | rc=0 >>
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

cass3.deltakappa.com | CHANGED | rc=0 >>
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

[root@ansible ansible]# ansible cluster22 -m shell -a "ls {{ cassandra22x_remote_archive_path }}/*/snapshots"

cass3.deltakappa.com | CHANGED | rc=0 >>
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/killrvideo/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_auth/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_distributed/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_traces/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

cass1.deltakappa.com | CHANGED | rc=0 >>
/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/var/lib/cassandra/archive/killrvideo/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/var/lib/cassandra/archive/system_auth/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/var/lib/cassandra/archive/system_distributed/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/var/lib/cassandra/archive/system/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/var/lib/cassandra/archive/system_traces/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

cass2.deltakappa.com | CHANGED | rc=0 >>
/mnt/nfs/cass3.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass2.deltakappa.com/var/lib/cassandra/archive/killrvideo/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass3.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass2.deltakappa.com/var/lib/cassandra/archive/system_auth/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass3.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass2.deltakappa.com/var/lib/cassandra/archive/system_distributed/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass3.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass2.deltakappa.com/var/lib/cassandra/archive/system/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
/mnt/nfs/cass3.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass2.deltakappa.com/var/lib/cassandra/archive/system_traces/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
```

Walking an nfs server from the client (cass1 is cass3's remote file store)...
```
[root@cass3 ~]# ls /mnt/nfs/
cass1.deltakappa.com
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/
var
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/
nfsshare
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/
cassandra22x
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/
cluster22
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/
cluster22
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/
cass3.deltakappa.com
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/
var
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/
lib
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/
cassandra
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/
archive
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/
archived_logs  killrvideo  system  system_auth  system_distributed  system_traces
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/*
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/archived_logs:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/killrvideo:
snapshots

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system:
snapshots

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_auth:
snapshots

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_distributed:
snapshots

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_traces:
snapshots
[root@cass3 ~]# ls /mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/*/snapshots
/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/killrvideo/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_auth/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_distributed/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar

/mnt/nfs/cass1.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass3.deltakappa.com/var/lib/cassandra/archive/system_traces/snapshots:
snapshot_953485c7-275c-4e97-95b4-849613929621.tar
[root@cass3 ~]#
```

### Using the playbooks/cluster22/cassandra22x_snapshot_local_archive_rsync.yml

```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_local_archive_rsync.yml | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_local_archive_rsync_$(date +%Y%d%m%H%M%s).log
```

### Using the playbooks/cluster22/cassandra22x_snapshot_clear.yml
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_clear.yml -e "snapshot_yml=snapshot_953485c7-275c-4e97-95b4-849613929621.yml" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_clear_snapshot_953485c7-275c-4e97-95b4-84961392962_$(date +%Y%d%m%H%M%s).log
```

### Using the playbooks/cluster22/.yml
#### Seeing the results of the playbooks/cluster22/.yml playbook
