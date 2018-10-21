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
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_get_all.yml | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_get_all_$(date +%Y%d%m%H%M%s).log
```

We will be using snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.yml for the snapshot_yml for the remaining samples.

### Using the playbooks/cluster22/cassandra22x_snapshot_get_for_yml.yml

This playbook lists the keyspaces of a specific snapshot using etc/roles/cassandra22x_restore/vars/cluster22/node/ in the sample environment.

```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_get_for_yml.yml -e"snapshot_yml=snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.yml" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_get_for_yml_$(date +%Y%d%m%H%M%s).log
```

#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot_get_for_yml.yml playbook

```
TASK [show keyspaces in snapshot snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37]********************************************
ok: [cass1.deltakappa.com -> 127.0.0.1] => {
    "msg": [
        "killrvideo",
        "system_auth",
        "system_distributed",
        "system",
        "system_traces"
    ]
}
ok: [cass2.deltakappa.com -> 127.0.0.1] => {
    "msg": [
        "killrvideo",
        "system_auth",
        "system_distributed",
        "system",
        "system_traces"
    ]
}
ok: [cass3.deltakappa.com -> 127.0.0.1] => {
    "msg": [
        "killrvideo",
        "system_auth",
        "system_distributed",
        "system",
        "system_traces"
    ]
}
```

### Using the playbooks/cluster22/cassandra22x_snapshot_local_archive.yml

This playbook creates a loacl archive of a snapshot using tar or tar.gz per the ansible var cassandra22x_local_archive_path_compression setting in the group_vars/host_vars.

The sample environment is configured to use tar.

```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_local_archive.yml -e "snapshot_yml=snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.yml" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_local_archive_snapshot__$(date +%Y%d%m%H%M%s).log
```

#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot_local_archive.yml playbook

The var cassandra22x_local_archive_path is configured for /var/lib/cassandra/archive.

Examination of each node in the cluster... the local archive contains the archived keyspace snapshots and snapshot log metadata.

```
[root@cass1 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
│   └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── killrvideo
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_auth
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_distributed
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
└── system_traces
    └── snapshots
        └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar

11 directories, 6 files

[root@cass2 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
│   └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── killrvideo
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_auth
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_distributed
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
└── system_traces
    └── snapshots
        └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar

11 directories, 6 files

[root@cass3 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
│   └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── killrvideo
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_auth
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
├── system_distributed
│   └── snapshots
│       └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
└── system_traces
    └── snapshots
        └── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar

11 directories, 6 files
```

### Using the playbooks/cluster22/cassandra22x_snapshot_local_archive_remote_archive_rsync.yml

This playbook uses rsync to sync archved snapshots from the cassandra node to the cassandra node nfs server.

```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_local_archive_remote_archive_rsync.yml | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_local_archive_remote_archive_rsync_$(date +%Y%d%m%H%M%s).log
```

#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot_local_archive_remote_archive_rsync.yml playbook

The var cassandra22x_remote_archive_path is configured for {{ cassandra22x_nfs_client_mount }}/cassandra22x/{{ cassandra22x_environment }}/{{ cassandra22x_cluster_name }}/{{ inventory_hostname }}/var/lib/cassandra/archive.

Examination of each nfs server... the remote archive contains the archived keyspace snapshots, snapshot log metadata, and ansible metadata archive.

```
[root@cass1 ~]# tree /var/nfsshare/
/var/nfsshare/
└── cassandra22x
    └── cluster22
        └── cluster22
            └── cass3.deltakappa.com
                └── var
                    └── lib
                        └── cassandra
                            └── archive
                                ├── ansible_restore_vars
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── archived_logs
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── killrvideo
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_auth
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_distributed
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                └── system_traces
                                    └── snapshots
                                        ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                        ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                        └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar

20 directories, 21 files

[root@cass2 ~]# tree /var/nfsshare/
/var/nfsshare/
└── cassandra22x
    └── cluster22
        └── cluster22
            └── cass1.deltakappa.com
                └── var
                    └── lib
                        └── cassandra
                            └── archive
                                ├── ansible_restore_vars
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── archived_logs
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── killrvideo
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_auth
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_distributed
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                └── system_traces
                                    └── snapshots
                                        ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                        ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                        └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar

20 directories, 21 files

[root@cass3 ~]# tree /var/nfsshare/
/var/nfsshare/
└── cassandra22x
    └── cluster22
        └── cluster22
            └── cass2.deltakappa.com
                └── var
                    └── lib
                        └── cassandra
                            └── archive
                                ├── ansible_restore_vars
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── archived_logs
                                │   ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │   ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │   └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── killrvideo
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_auth
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                ├── system_distributed
                                │   └── snapshots
                                │       ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                │       ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                │       └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar
                                └── system_traces
                                    └── snapshots
                                        ├── snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.tar
                                        ├── snapshot_b4e448bc-cbf9-445a-b32e-f8aa19d2584a.tar
                                        └── snapshot_e0115828-84ea-4a07-bf9b-9b3f94ce781f.tar

20 directories, 21 files
```

### Using the playbooks/cluster22/cassandra22x_snapshot_clear.yml

This playbook clears the snapshot from cassandra, the local archive, the  rsync to sync archved snapshots from the cassandra node to the cassandra node nfs server.

```
ansible-playbook playbooks/cluster22/cassandra22x_snapshot_clear.yml -e "snapshot_yml=snapshot_6c1b675b-1603-4604-a954-d5a4c90e2f37.yml" | tee /var/log/ansible/cassandra22x/cluster22/cassandra22x_snapshot_clear_snapshot__$(date +%Y%d%m%H%M%s).log
```

#### Seeing the results of the playbooks/cluster22/cassandra22x_snapshot_clear.yml playbook

The local archive is now empty.

```
[root@cass1 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
├── killrvideo
│   └── snapshots
├── system
│   └── snapshots
├── system_auth
│   └── snapshots
├── system_distributed
│   └── snapshots
└── system_traces
    └── snapshots

11 directories, 0 files

[root@cass2 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
├── killrvideo
│   └── snapshots
├── system
│   └── snapshots
├── system_auth
│   └── snapshots
├── system_distributed
│   └── snapshots
└── system_traces
    └── snapshots

11 directories, 0 files

[root@cass3 ~]# tree /var/lib/cassandra/archive/
/var/lib/cassandra/archive/
├── archived_logs
├── killrvideo
│   └── snapshots
├── system
│   └── snapshots
├── system_auth
│   └── snapshots
├── system_distributed
│   └── snapshots
└── system_traces
    └── snapshots

11 directories, 0 files
```

## Template
### Using the playbooks/cluster22/.yml
#### Seeing the results of the playbooks/cluster22/.yml playbook
