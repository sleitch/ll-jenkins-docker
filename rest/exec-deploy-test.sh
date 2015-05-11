
#!/bin/bash

#
# The name (or ID) of the container to execute on
#
CONTAINER=deploy-manager

#
#  The data for the command:
#
data='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "deploytest.sh","'$1'", "'$2'" ]}'

URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

echo "Exec URL:  " $URL
echo "Exec data: " $data

RES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$data")

echo "Result=" $RES

LEN=${#RES} 

 ## Subtract the leading/trailing 9 chars - forthese guys:  {"Id":""}

STRLEN=$(( $LEN - 9))

CURRENT_EXEC_ID=${RES:7:$STRLEN}
echo "substring: " ${RES:7:$STRLEN}
#echo "CURRENT_EXEC_ID: " $CURRENT_EXEC_ID
#export CURRENT_EXEC_ID



# get output, append HTTP status code in separate line, discard error message
OUT=$( curl -qSfsw '\n%{http_code}'  -H 'Content-Type:application/json' -X POST $URL --data "$data") 2>/dev/null

# get exit code
RET=$?


echo "**********************RET= $RET"
echo "*** out= $OUT"



if [[ $RET -ne 0 ]] ; then
    # if error exit code, print exit code
    echo "Error $RET"

    # print HTTP error
    echo "HTTP Error: $(echo "$OUT" | tail -n1 )"
else
    # otherwise print last line of output, i.e. HTTP status code
    echo "Success, HTTP status is:"
    echo "$OUT" | tail -n1

    # and print all but the last line, i.e. the regular response
    echo "Response is:"
    echo "$OUT" | head -n-1
fi
if [[ $RET -eq 404 ]] ; then
   # 404 – no such container
   echo "Error: 404,  No such conatiner, conatiner is: " $CONTAINER;
else

	if [[ $RET -ne 201 ]]; then
           # if error exit code, print exit code
           echo "Error - non 201 code:  $RET"

    	   # print HTTP error
           echo "HTTP Error: $(echo "$OUT" | tail -n1 )"
        else
	   #
	   # Was ok...
	   #

  	   # otherwise print last line of output, i.e. HTTP status code
   	    echo "Success, HTTP status is:"
    	   echo "$OUT" | tail -n1

    	   # and print all but the last line, i.e. the regular response
    	   echo "Response is:"
    	   echo "$OUT" | head -n-1
	fi
fi





#
#  The data for the command:
#
data='{"Detach": false, "Tty": false}'

URL='http://172.24.200.10:4243/exec/'"$CURRENT_EXEC_ID"'/start'

echo "Exec URL:  " $URL
echo "Exec data: " $data

 STARTRES=$(curl -H 'Content-Type:application/json' -X POST $URL --data "$data" -v)
 
 echo "Result of start exec: " $STARTRES
 
 


