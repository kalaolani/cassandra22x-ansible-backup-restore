#!/bin/bash

### Descriptioin: 
### Author: 
### Date: 
### CQGiki documentation: http://cqgiki.denver.cqg/bin/view/Production/LinuxAnsible

USER=$1
PASS=$2
KEYSPACE=$3
TABLE=$4
nodetool -u $USER -pw $PASS refresh $KEYSPACE $TABLE
