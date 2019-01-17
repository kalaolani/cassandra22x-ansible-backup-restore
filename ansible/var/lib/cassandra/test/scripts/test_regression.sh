#!/usr/bin/bash

# parameters
TEST_LOG=$1
SCRIPT_PATH=$2
TARGET=$3

echo "$(date): stability test cluster rolling repair" | tee -a $TEST_LOG
sh $SCRIPT_PATH/repair.sh $TARGET | tee -a $TEST_LOG
echo "$(date): sleep 10 seconds" | tee -a $TEST_LOG
sleep 10 | tee -a $TEST_LOG
echo "$(date): get state after cluster rolling repair test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $TARGET | tee -a $TEST_LOG
echo "$(date): stability test cluster rolling restart" | tee -a $TEST_LOG
sh $SCRIPT_PATH/restart.sh $TARGET | tee -a $TEST_LOG
echo "$(date): sleep 10 seconds" | tee -a $TEST_LOG
sleep 10 | tee -a $TEST_LOG
echo "$(date): get state after cluster rolling restart test" | tee -a $TEST_LOG
sh $SCRIPT_PATH/test_get_state.sh $TARGET | tee -a $TEST_LOG