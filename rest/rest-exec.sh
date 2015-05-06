#!/bin/bash

#
# The name (or ID) of the container to execute on
#
CONTAINER=test_sshd

#
#  The data for the command:
#
DATA='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "hello.sh","testme" ],"test":"test"}'


URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

echo "Exec URL:  " $URL
echo "Exec data: " $DATA


RES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$DATA")

echo "Result=" $RES

LEN=${#RES} 

 ## Subtract the leading/trailing 9 chars - forthese guys:  {"Id":""}

STRLEN=$(( $LEN - 9))

CURRENT_EXEC_ID=${RES:7:$STRLEN}
echo "substring: " ${RES:7:$STRLEN}
echo "CURRENT_EXEC_ID: " $CURRENT_EXEC_ID
export CURRENT_EXEC_ID
