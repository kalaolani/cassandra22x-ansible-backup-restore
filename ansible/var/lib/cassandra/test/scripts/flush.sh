#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/flush.sh target_cluster

TARGET=$1

echo "$(date): nodetool flush on $TARGET cluster nodes"
ansible $TARGET -a "nodetool flush"