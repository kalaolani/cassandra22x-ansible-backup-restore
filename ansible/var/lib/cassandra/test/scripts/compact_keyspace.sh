#!/usr/bin/bash
# sh /var/lib/cassandra/test/scripts/compact_keyspace.sh target_cluster target_keyspace

TARGET=$1
KEYSPACE=$2

echo "$(date): nodetool compact on $TARGET cluster nodes for $KEYSPACE"
ansible $TARGET -a "nodetool compact $KEYSPACE"