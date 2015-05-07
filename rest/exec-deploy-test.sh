#!/bin/bash

#
# The name (or ID) of the container to execute on
#
CONTAINER=deploy-manager

#
#  The data for the command:
#
DATA='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "deploytest.sh","'$1'", "'$2'" ]}'


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
#echo "CURRENT_EXEC_ID: " $CURRENT_EXEC_ID
#export CURRENT_EXEC_ID


#
#  The data for the command:
#
DATA='{"Detach": false, "Tty": false}'

URL='http://172.24.200.10:4243/exec/'"$CURRENT_EXEC_ID"'/start'

echo "Exec URL:  " $URL
echo "Exec data: " $DATA

 STARTRES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$DATA" -v)
 
 echo "Result of start exec: " $STARTRES
 
 


