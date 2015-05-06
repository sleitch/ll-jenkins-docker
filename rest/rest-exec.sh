#!/bin/bash

#
# The name (or ID) of the container to execute on
#
CONTAINER=test_sshd

#
#  The data for the command:
#
DATA='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "hello.sh" ],"testargs":"value"}'


URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

echo "Exec URL:  " $URL
echo "Exec data: " $DATA


 curl -H 'Content-Type:application/json' -X POST $URL --data "$DATA" -v

 ## WORKS
 #
 #curl -H 'Content-Type:application/json' -X POST 'http://172.24.200.10:4243/containers/8f3578ee8ddc/exec' --data '{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "date" ]}' -vv

