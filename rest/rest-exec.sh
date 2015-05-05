#!/bin/bash

URL=http://172.24.200.10:4243/containers/8f3578ee8ddc/exec

echo "Exec..."

DATA='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "date" ]}'



#
#   test_sshd = 8f3578ee8ddc


 curl -H 'Content-Type:application/json' -X POST $URL --data $DATA -vv
 
 ## WORKS
 #
 #curl -H 'Content-Type:application/json' -X POST 'http://172.24.200.10:4243/containers/8f3578ee8ddc/exec' --data '{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "date" ]}' -vv
 