#!/bin/bash

#
# The name (or ID) of the container to execute on
#


#
# Pass this in from cmd arg
#
#EXECID=4b161f9da73d71b41dbf86f287b94f232a270fc02ecf5ca1c1f07a1a52e2436b


echo "Arg 1 (is exec ID):  " $1

#
#  The data for the command:
#
DATA='{"Detach": false, "Tty": false}'


URL='http://172.24.200.10:4243/exec/'"$1"'/start'


echo "Exec URL:  " $URL
echo "Exec data: " $DATA


 curl -H 'Content-Type:application/json' -X POST $URL --data "$DATA" -v

