#!/bin/bash

NUMBER=$1

if (( $NUMBER -lt 10 )) # -gt => greater than, -lt => less than, -eq => equal, -ne => not equal
then 
    echo "Given number $NUMBER is less than 10"
else
    echo "Given number $NUMBER is greater than 10"
fi 
