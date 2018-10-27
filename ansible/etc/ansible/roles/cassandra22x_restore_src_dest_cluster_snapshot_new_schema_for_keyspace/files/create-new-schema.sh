#!/bin/bash

### Descriptioin: create new schema script - cass_restore_src_ring_to_dest_schema_data role
### Author: David Payne
### 
### CQGiki documentation: http://cqgiki.denver.cqg/bin/view/Production/LinuxAnsible

SERVER=$1
USER=$2
PASS=$3
NEWSCHEMA=$4
/usr/bin/cqlsh $SERVER --username=$USER --password=$PASS --file=$NEWSCHEMA --connect-timeout=30 --request-timeout=30