#!/bin/bash
USERNAME=leisurelink+circleci
PASSWORD=CLW67ZO3AYV414TS1JO9T2W7LZCYW7L14FSYJKH6OKZYYA6XACB5EM6OK58PUOQH
SVRADDR=https://quay.io/v1/
URL=http://172.24.200.10:4243/images/quay.io/leisurelink/authentic-api/push
echo "Pushing..."

AUTH_STRING="{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\", \"email\": \".\", \"serveraddress\": \"$SVRADDR\", \"auth\": \"\"}"
BASE64_AUTH_STRING=`echo $AUTH_STRING | base64`
echo "BASE64_AUTH_STRING="$BASE64_AUTH_STRING

curl -vv -X POST -H "X-Registry-Auth: $BASE64_AUTH_STRING" $URL