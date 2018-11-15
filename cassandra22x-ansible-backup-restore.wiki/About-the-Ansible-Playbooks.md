# Snapshot Playbooks
## Playbook to create a snapshot.

```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot.yml --extra-vars "target=target=ansible_inventory_hosts snapshot_uuid=$(uuidgen)"
```

* Replace target=ansible_inventory_hosts with the ansible inventory group.
* The extra variable snapshot_uuid=$(uuidgen) allows for a global snapshot name.

Example: 
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot.yml --extra-vars "target=cluster22 snapshot_uuid=$(uuidgen)"
```

This creates a cluster global snapshot for the ansible inventory group cluster22 using the name pattern snapshot_uuid, i. e. snapshot_af77b009-9116-48e8-96be-edaccaa362b7.

## Playbooks to view snapshot metadata required to run other playbooks.
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_get_metadata.yml --extra-vars "target=target=ansible_inventory_hosts"
```
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_get_all.yml --extra-vars "target=target=ansible_inventory_hosts"
```
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_get_for_yml.yml --extra-vars "target=target=ansible_inventory_hosts snapshot_yml=snapshot_yml"
```

## Playbooks to clear snapshots.
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_clear.yml --extra-vars "target=target=ansible_inventory_hosts snapshot_yml=snapshot_yml"
```
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot_clear_all_but_latest.yml --extra-vars "target=target=ansible_inventory_hosts"
```

# Snapshot Archive Playbooks

## Playbook to rsynce the local archive to the remote archive
operate_archive_rsync.yml

# Restore Automation Playbooks

## Playbook to restore a cassandra snapshot on the same cluster (nodes)
operate_restore_local_snapshot_keyspace.yml
## Playbook to restore a cassandra snapshot to a new schema on the same cluster (nodes)
operate_restore_local_snapshot_new_schema.yml
## Playbook to restore a local archived cassandra snapshot to a new schema on the same cluster (nodes)
operate_restore_local_archive_snapshot_new_schema.yml 
note: ansible yamls must be available
## Playbook to restore a remote archived cassandra snapshot to a new schema on the same cluster (nodes)
operate_restore_remote_archive_snapshot_new_schema.yml
note: ansible yamls must be available

## Playbooks to copy a token ring and keyspaces from a src cluster to a new dest cluster.
1. Restore the token ring
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_restore_src_dest_cluster_snapshot_copy_ring.yml --extra-vars "target=ansible_inventory_hosts snapshot_yml=snapshot_yml"
```
2. Restore keyspaces
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_restore_src_dest_cluster_snapshot_copy_ring_for_keyspace.yml --extra-vars "target=ansible_inventory_hosts snapshot_keyspace_yml=snapshot_keyspace_yml"
```
3. Clean up after restoring the last keyspace
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/role_test_restore_src_dest_cluster_snapshot_clean_up.yml --extra-vars "target=ansible_inventory_hosts snapshot_yml=snapshot_yml src_cluster_node_map_dict=true|false" 
```

# Repair Automation Playbooks
## Playbook to run a rolling full partitioner-range repair.
```
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_rolling_full_partitioner-range_repair_by_node.yml --extra-vars "target=target=ansible_inventory_hosts"
```
* Replace target=ansible_inventory_hosts with the ansible inventory group.

## Playbook to run a rolling full partitioner-range repair for a keyspace.
operate_rolling_full_partitioner-range_repair_by_node_for_keyspace.yml

# Cassandra Service Automation Playbooks
## Playbook to run a rolling restart of all target nodes.
operate_rolling_restart.yml
## Playbook to start all target nodes.
operate_start_cluster.yml
## Playbook to stop all target nodes.
operate_stop_cluster.yml
## Playbook to restart all target nodes.
operate_restart.yml