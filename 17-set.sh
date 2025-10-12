#!/bin/bash

set -e
failre(){
    echo "Failed at: $1 $2"
}
trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR

echo "Hi, Good Morning"
echo "Hello, am learning DEvOps"
echooo "Hello, this will be error"
echo "Hello, How are you"