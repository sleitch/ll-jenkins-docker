#!/bin/bash


############################################################################
#
#   Creates the exec instance ID for later use by start command.
#
############################################################################
createExecID(){ 
   
    CURRENT_EXEC_ID=""
   
    # this is json object for the exec create command..
    #
    data='{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "deploytest.sh","'$1'", "'$2'" ]}'

    URL='http://172.24.200.10:4243/containers/'"$CONTAINER"'/exec'

    # get response and HTTP status code 
    OUT=$( curl -qSfsw '\n%{http_code}'  -H 'Content-Type:application/json' -X POST $URL --data "$data") 2>/dev/null

    # get exit code of curl
    RET=$?
    echo "Created EXEC command 
    echo "Exec data: " $data
    echo "Out= " $OUT
    #echo "Curl exit code: " $RET
    
    if [[ $RET -ne 0 ]] ; then
        echo "Curl Error, exit code: $RET"
    else
        #
        # This will split the result msg and code into array
        readarray -t resultbody <<<"$OUT"
        httpcode=${resultbody[2]}
    
        echo "Curl Success, HTTP status is: " $httpcode
        #echo "Response is: " ${resultbody[0]}
     
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
                export CURRENT_EXEC_ID
                echo "Successful HTTP status is: $httpcode"     
                echo "Start EXEC ID: " $CURRENT_EXEC_ID
            fi
        fi
    fi
}  

############################################################################
#
#   This will execute the start command against the CURRENT_EXEC_ID 
#
############################################################################

startExec(){ 
    #  The data for the command:
    #
    data='{"Detach": false, "Tty": false}'

    URL='http://172.24.200.10:4243/exec/'"$CURRENT_EXEC_ID"'/start'

    echo "Exec URL:  " $URL
    echo "Exec data: " $data

    STARTRES=$( curl -qSfsw '\n%{http_code}'  -H 'Content-Type:application/json' -X POST $URL --data "$data") 2>/dev/null
    # get exit code of curl
    STARTRET=$?
     
    echo "Result of start exec: " $STARTRES
      
    if [[ $STARTRET -ne 0 ]] ; then
        echo "Curl Error, exit code: $STARTRET"
        exit $STARTRET
    else
        # get the http status code from end of STARTRES 
        startcode=$(echo "$STARTRES" | tail -n1)

        echo "startcode $startcode"
	if [[ $startcode -eq 201 ]] ; then
           echo "No such exec ID: $CURRENT_EXEC_ID"
        else
           if [[ $startcode -eq 404 ]] ; then           
              echo "No such exec ID: $CURRENT_EXEC_ID"
           fi
        fi 
    fi
}  


#
# The name (or ID) of the container to execute on
#
CONTAINER=deploy-manager

############
##
##   First check if we have an existing EXEC ID to use:
##

if [ -z "$CURRENT_EXEC_ID" ]; then
    echo "No env var called: CURRENT_EXEC_ID, creating an exec..."
    
    createExecID $1 $2;
    echo "exec ID after create: " $CURRENT_EXEC_ID
    
    startExec
    
    
else
    echo "Found CURRENT_EXEC_ID: " $CURRENT_EXEC_ID
    
    startExec

    if [[ $startcode -eq 404 ]]; then

        #
        # try creating new exec ID
        createExecID $1 $2;
        startExec
    fi 

    if [[ $startcode -ne 201 ]]; then
        echo "Failed to start exec, exit code: $startcode, Exec ID: $CURRENT_EXEC_ID"
        exit $startcode
    fi
   
fi
