#!/usr/bin/bash

### Descriptioin: nodetool-snapshot.sh bash script for the snapshot task of the cass_snapshot role
### Author: David Payne
### Date: 10-24-2017
### CQGiki documentation: http://cqgiki.denver.cqg/bin/view/Production/LinuxAnsible

USER=$1
PASS=$2
SNAPSHOTNAME=$3
KEYSPACE=$4
OUTFILE=$5
nodetool --username $USER --password $PASS snapshot --tag $SNAPSHOTNAME $KEYSPACE > $OUTFILE
