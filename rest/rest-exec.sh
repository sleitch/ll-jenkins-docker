#!/bin/bash

URL=http://172.24.200.10:4243/containers/8f3578ee8ddc/exec

echo "Exec..."

DATA='{\"AttachStdin\": false, \"AttachStdout\": true, \"AttachStderr\": true,\"Tty\": false, \"Cmd\": [ \"date\" ]}'


curl --data DATA $URL

#curl -X POST -H 'application/json' -d '$DATA' '$URL'


#
#   test_sshd = 8f3578ee8ddc
