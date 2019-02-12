#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/repair.sh target_cluster

TARGET=$1

echo "$(date): operate_rolling_full_partitioner-range_repair_by_node.yml"
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_rolling_full_partitioner-range_repair_by_node.yml --extra-vars "target=$TARGET"