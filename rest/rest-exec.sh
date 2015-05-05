#!/bin/bash
USERNAME=leisurelink+circleci
PASSWORD=CLW67ZO3AYV414TS1JO9T2W7LZCYW7L14FSYJKH6OKZYYA6XACB5EM6OK58PUOQH
SVRADDR=https://quay.io/v1/

URL=http://172.24.200.10:4243/images/quay.io/leisurelink/authentic-api/push

echo "Pushing..."
#!/bin/bash

DATA="{\"AttachStdin\": false, \"AttachStdout\": true, \"AttachStderr\": true,\"Tty\": false, \"Cmd\": [ \"date\" ]}"


curl -X POST -H "application/json" -d $DATA $URL


#
#   test_sshd = 8f3578ee8ddc
