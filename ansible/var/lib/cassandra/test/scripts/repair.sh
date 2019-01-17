#!/usr/bin/bash

TARGET=$1

echo "$(date): operate_rolling_full_partitioner-range_repair_by_node.yml"
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_rolling_full_partitioner-range_repair_by_node.yml --extra-vars "target=$TARGET"