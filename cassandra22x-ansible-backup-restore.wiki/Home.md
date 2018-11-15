# cassandra22x ansible backup restore

Welcome to the cassandra22x-ansible-backup-restore wiki!

What the heck is this and what is it about?

New to Linux, Ansible, Cassandra, etc.? This might be for you, if you are not able to get your hands on DSE.

To avoid all of this hassle... Do give Datastax, a commercial derivative of Cassandra, a try. It seems to support backup/restore out of the box.

Don't feel like a =:-). You know what this means if you are an old MS employee from a long time ago... in a galaxy not so far away. Double Space ate my drive... oh no... should've used Stacker. ¯\_(ツ)_/¯ yeah... I'm that old. And... fear not... You'll end up loving the Linux world as much as I do now. Don't think I'll ever install Windows again for personal use.

### Git Patterns

- The git repo is organized by the ansible host file system under ansible ... ansible/etc/ansible ... where ansible is the host and /etc/ansible is the target path on the ansible host.
- The git repo is organized by the cassandra noe file system under cassandra ... cassandra/ ... where / is the root of the cassandra node and the cassandra config and data directories are the default /etc/cassandra/conf and /var/lib/cassandra/data.   

### Requirements & Notes

Some of the parts of this solution are not yet optimized. This is literally the results of the  first run through by a newbie to Linux, Python, Ansible, Cassandra, and FOSS in general using one Datastax as a specification document: https://docs.datastax.com/en/archived/cassandra/2.1/cassandra/operations/ops_backup_restore_c.html
Where working from these documents took the most focus...
https://docs.datastax.com/en/archived/cassandra/2.1/cassandra/operations/ops_snapshot_restore_new_cluster.html
https://docs.datastax.com/en/archived/cassandra/2.1/cassandra/operations/ops_backup_snapshot_restore_t.html#ops_backup_snapshot_restore_t
