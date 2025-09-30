#!/bin/bash

echo "All variables: $@"
echo "Number of varibles passed: $#"
echo "Name of the script: $0"
echo "Current working directoty: $PWD"
echo "Home directory of current user: $HOME"
echo "Which user is running the script: $USER"
echo "Host name: $HOSTNAME"
echo "Process ID of current shell script: $$"
sleep 10 &
echo "Process ID of last background command: $!"