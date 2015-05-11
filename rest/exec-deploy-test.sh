#!/bin/bash

# The name (or ID) of the container to execute on
#
CONTAINER=deploy-manager

#
#  The data for the command:
#
data='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "deploytest.sh","'$1'", "'$2'" ]}'

URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

echo "1. Exec URL:  " $URL
echo "2. Exec data: " $data


# get output, append HTTP status code in separate line, discard error message
OUT=$( curl -qSfsw '\n%{http_code}'  -H 'Content-Type:application/json' -X POST $URL --data "$data") 2>/dev/null

# get exit code
RET=$?

echo "3. Out= " $OUT
echo "4. Curl exit code: " $RET


#
# This will split the result msg and code into array
readarray -t resultbody <<<"$OUT"
httpcode=${resultbody[2]}

echo "5. resultbody =" ${resultbody[0]}

echo "6 httpcode=" $httpcode

LEN=${#resultbody} 

echo "7. Len of out =  $LEN"

 ## Subtract the leading/trailing 9 chars - forthese guys:  {"Id":""}

STRLEN=$(( $LEN - 9))

CURRENT_EXEC_ID=${resultbody[0]:7:$STRLEN}
echo "8. substring: " ${resultbody[0]:7:$STRLEN}
#echo "CURRENT_EXEC_ID: " $CURRENT_EXEC_ID
#export CURRENT_EXEC_ID





if [[ $RET -ne 0 ]] ; then
    # Error exit code from curl
    echo "9a.1 Error $RET"
    echo "9a.2 HTTP Error: " $httpcode
else
    # otherwise print last line of output, i.e. HTTP status code
    echo "9b.1 Curl Success, HTTP status is: " $httpcode
    testresp=$( echo  "$OUT" | head -n-1)

    # and print all but the last line, i.e. the regular response
    echo "9b.2  Response is: " $testresp 
 
    if [[ $httpcode -eq 404 ]] ; then
       # 404 – no such container
       echo "Error: 404,  No such conatiner, conatiner is: " $CONTAINER;
    else

        if [[ $httpcode -ne 201 ]]; then
           # if error exit code, print exit code
           echo "Error - non 201 code:  $httpcode"

           # print HTTP error
           echo "HTTP Error: $httpcode"
        else
           #
           # Was ok...
    
           echo "Success, HTTP status is: $httpcode"

           echo "Response is: ${resultbody[0]}" 
        fi
    fi
fi
 
#  The data for the command:
#
data='{"Detach": false, "Tty": false}'

URL='http://172.24.200.10:4243/exec/'"$CURRENT_EXEC_ID"'/start'

echo "Exec URL:  " $URL
echo "Exec data: " $data

STARTRES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$data" -v)
 
echo "Result of start exec: " $STARTRES
 
 


