#!/usr/bin/bash

TARGET=$1

echo "$(date): operate_rolling_restart.yml"
ansible-playbook /etc/ansible/playbooks/cassandra22x/operate_rolling_restart.yml --extra-vars "target=$TARGET"