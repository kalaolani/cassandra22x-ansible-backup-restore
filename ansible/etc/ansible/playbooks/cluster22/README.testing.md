ansible-playbook playbooks/cluster22/cassandra22x_snapshot.yml -e "snapshot_uuid=$(uuidgen)"
creates ... snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75

ansible-playbook playbooks/cluster22/cassandra22x_snapshot_local_archive.yml -e"snapshot_yml=snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.yml"
populates the local_archive for off node archiving

cassandra22x_snapshot_local_archive_remote_archive_rsync.yml
rsyncs the local_archive to the remote_archive

At this point, 
We have a local snapshots on each node ...

...
└── videos_by_tag-41e58fc0d01e11e8af9161a24d399e62
    ├── backups
    ├── lb-1-big-CompressionInfo.db
    ├── lb-1-big-Data.db
    ├── lb-1-big-Digest.adler32
    ├── lb-1-big-Filter.db
    ├── lb-1-big-Index.db
    ├── lb-1-big-Statistics.db
    ├── lb-1-big-Summary.db
    ├── lb-1-big-TOC.txt
    ├── lb-2-big-CompressionInfo.db
    ├── lb-2-big-Data.db
    ├── lb-2-big-Digest.adler32
    ├── lb-2-big-Filter.db
    ├── lb-2-big-Index.db
    ├── lb-2-big-Statistics.db
    ├── lb-2-big-Summary.db
    ├── lb-2-big-TOC.txt
    └── snapshots
        └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75
            ├── lb-1-big-CompressionInfo.db
            ├── lb-1-big-Data.db
            ├── lb-1-big-Digest.adler32
            ├── lb-1-big-Filter.db
            ├── lb-1-big-Index.db
            ├── lb-1-big-Statistics.db
            ├── lb-1-big-Summary.db
            ├── lb-1-big-TOC.txt
            ├── lb-2-big-CompressionInfo.db
            ├── lb-2-big-Data.db
            ├── lb-2-big-Digest.adler32
            ├── lb-2-big-Filter.db
            ├── lb-2-big-Index.db
            ├── lb-2-big-Statistics.db
            ├── lb-2-big-Summary.db
            ├── lb-2-big-TOC.txt
            └── manifest.json

We have a locally stored archived snapshots for each node ...

/var/lib/cassandra/archive/killrvideo
└── snapshots
    └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar

/etc/ansible/roles/cassandra22x_restore/vars/
└── cluster22
    ├── cass1.deltakappa.com
    │   ├── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
    ... for each node on the ansible system
            
We have a remotely stored archived snapshots for each node ...
(this includes cassandra data, cassandra log (ansible metadata), and ansible restore_vars (metadata)

/mnt/nfs/cass2.deltakappa.com/var/nfsshare/cassandra22x/cluster22/cluster22/cass1.deltakappa.com/
└── var
    └── lib
        └── cassandra
            └── archive
                ├── ansible_restore_vars
                │   └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                ├── archived_logs
                │   └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                ├── killrvideo
                │   └── snapshots
                │       └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                ├── system
                │   └── snapshots
                │       └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                ├── system_auth
                │   └── snapshots
                │       └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                ├── system_distributed
                │   └── snapshots
                │       └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
                └── system_traces
                    └── snapshots
                        └── snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75.tar
end note

cassandra@cqlsh> source 'truncate_all_tables_in_killrvideo.cql';
consistency all;
source 'count_all_tables_in_killrvideo.cql';
all 0 rows












































