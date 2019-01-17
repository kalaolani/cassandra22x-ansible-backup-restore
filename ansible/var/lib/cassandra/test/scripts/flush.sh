#!/usr/bin/bash

TARGET=$1

echo "$(date): nodetool flush"
ansible $TARGET -m shell -a "nodetool flush"