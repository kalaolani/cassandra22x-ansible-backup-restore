#!/bin/bash

### Descriptioin: 
### Author: David Payne
###
### CQGiki documentation: http://cqgiki.denver.cqg/bin/view/Production/LinuxAnsible

SEARCH_ROOT=$1
REFERENCE_FILE=$2
find $SEARCH_ROOT -type f ! -newer $REFERENCE_FILE -delete