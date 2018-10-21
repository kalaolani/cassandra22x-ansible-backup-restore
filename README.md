# cassandra22x-ansible-backup-restore
See the Wiki for details.

Recently added ... cassandra22x_operate_rolling_full_partitioner-range_repair_by_node.yml
Need repairs to test restores.

Restore is coming soon.

Ad hoc Environment Notes...

auto_snapshot is enabled by default & disabling auto_snapshot
```
root@ansible ansible]# ansible cluster22 -m shell -a" grep auto_snapshot {{ cassandra22x_yaml }}"
cass2.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

cass1.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

cass3.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

[root@ansible ansible]# ansible cluster22 -m shell -a"sed -i 's/auto_snapshot\: true/auto_snapshot\: false/g' {{ cassandra22x_yaml }}"
 [WARNING]: Consider using the replace, lineinfile or template module rather than running sed.  If you need to use command because replace, lineinfile or template is insufficient you can add warn=False to this command task or set command_warnings=False in ansible.cfg
to get rid of this message.

cass1.deltakappa.com | CHANGED | rc=0 >>


cass2.deltakappa.com | CHANGED | rc=0 >>


cass3.deltakappa.com | CHANGED | rc=0 >>


[root@ansible ansible]# ansible cluster22 -m shell -a" grep auto_snapshot {{ cassandra22x_yaml }}"
cass1.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

cass2.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

cass3.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

ansible-playbook playbooks/cluster22/cassandra22x_operate_rolling_restart.yml
```
