#!/bin/bash
USER=$1
PASSWORD=$2
KEYSPACE=$3
TABLE=$4
nodetool -u $USER -pw $PASSWORD refresh $KEYSPACE $TABLE