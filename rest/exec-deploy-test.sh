#!/bin/bash

# The name (or ID) of the container to execute on
#
CONTAINER=deploy-manager

#
#  The data for the command:
#
data='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "deploytest.sh","'$1'", "'$2'" ]}'

URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

# get response and HTTP status code 
OUT=$( curl -qSfsw '\n%{http_code}'  -H 'Content-Type:application/json' -X POST $URL --data "$data") 2>/dev/null

# get exit code of curl
RET=$?

echo "Exec URL:  " $URL
echo "Exec data: " $data
echo "Out= " $OUT
#echo "Curl exit code: " $RET

if [[ $RET -ne 0 ]] ; then
    # Error exit code from curl
    echo "Curl Error, exit code: $RET"
else
    #
    # This will split the result msg and code into array
    readarray -t resultbody <<<"$OUT"
    httpcode=${resultbody[2]}

    echo "Curl Success, HTTP status is: " $httpcode

    echo "Response is: " ${resultbody[0]}
 
    if [[ $httpcode -eq 404 ]] ; then
       # 404 no such container
       echo "Error: 404,  No such container: " $CONTAINER
    else

        if [[ $httpcode -ne 201 ]]; then
           # if error exit code, print exit code
           echo "HTTP Error Code (non 201):"  $httpcode
        else
           #
           # Was ok...

           LEN=${#resultbody} 
			
			## Subtract the leading/trailing 9 chars - forthese guys:  {"Id":""}
			
			STRLEN=$(( $LEN - 9))
			
			CURRENT_EXEC_ID=${resultbody[0]:7:$STRLEN}
			
			echo "Successful HTTP status is: $httpcode"		
			#echo "resultbody =" ${resultbody[0]}
			#echo "httpcode=" $httpcode
			#echo "Len of out =  $LEN"
			echo "Start EXEC ID: " $CURRENT_EXEC_ID
			
			
			startExec();
        fi
    fi
fi
 

 
 
 function startExec{ 
    #  The data for the command:
    #
    data='{"Detach": false, "Tty": false}'

    URL='http://172.24.200.10:4243/exec/'"$CURRENT_EXEC_ID"'/start'

    echo "Exec URL:  " $URL
    echo "Exec data: " $data

    STARTRES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$data" -v)
 
    echo "Result of start exec: " $STARTRES
   
}  
                


