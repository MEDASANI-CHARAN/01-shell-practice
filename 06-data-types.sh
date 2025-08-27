#!/bin/bash

TIMESTAMP=$(date)
echo "Script executed at: $TIMESTAMP"

# we keep the command in $() and will take output as variable

# this is comment
NUMBER1=100
NUMBER2=200

SUM=$(($NUMBER1+$NUMBER2))

echo "SUM of $NUMBER1 and $NUMBER2 is: $SUM"