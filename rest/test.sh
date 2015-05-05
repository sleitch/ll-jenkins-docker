URL=http://172.24.200.10:4243/images/quay.io/leisurelink/authentic-api/push


DATA="{\"AttachStdin\": false, \"AttachStdout\": true, \"AttachStderr\": true,\"Tty\": false, \"Cmd\": [ \"date\" ]}"

 POST /containers/e90e34656806/exec HTTP/1.1
    Content-Type: application/json

    {
     "AttachStdin": false,
     "AttachStdout": true,
     "AttachStderr": true,
     "Tty": false,
     "Cmd": [
                 "date"
         ],
    }
    
    
 curl -vv -X POST 'http://172.24.200.10:4243/containers/8f3578ee8ddc/exec -d 