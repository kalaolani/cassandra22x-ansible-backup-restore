#!/usr/bin/bash

TARGET=$1

echo "$(date): operate_snapshot.yml"
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_snapshot.yml --extra-vars "target=$TARGET snapshot_uuid=$(uuidgen)"