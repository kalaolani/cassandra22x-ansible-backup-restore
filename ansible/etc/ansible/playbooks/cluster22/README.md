# cassandra22x-ansible-backup-restore ansible playbooks 
## README

note all of the sample ansible and ansible-playbook commands assume pwd = /etc/ansible

### Using the playbooks/cluster22/cassandra22x_snapshot.yml playbook
This playbook creates snapshots.
```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot.yml -e "snapshot_uuid=$(uuidgen)" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_$(date +%Y%d%m%H%M%s).log
```
See var/log/ansible/cassandra22x/cluster22/ for samples

#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot.yml playbook
```
ansible cluster22 -a"nodetool listsnapshots" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_nodetool_listsnapshots_$(date +%Y%d%m%H%M%s).log
ansible cluster22 -m shell -a"ls {{ cassandra22x_data_path }}/killrvideo/*/snapshots"  | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_killrvideo_snapshot_ls__$(date +%Y%d%m%H%M%s).log
ansible cluster22 -m shell -a"ls {{ cassandra22x_data_path }}/killrvideo/*/snapshots"/*  | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_killrvideo_snapshot_contents_ls__$(date +%Y%d%m%H%M%s).log
```
See var/log/ansible/cassandra22x/cluster22/ for sample log files.

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