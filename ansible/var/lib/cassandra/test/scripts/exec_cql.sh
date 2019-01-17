#!/usr/bin/bash

CQL_TARGET=$1
CQL_SCRIPT=$2

cqlsh $CQL_TARGET -f $CQL_SCRIPT