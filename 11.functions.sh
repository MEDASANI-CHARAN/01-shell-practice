#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1 # Give other then 0 upto 127
else
    echo "You are running with root access"
fi

# validate function takes input as exit status, what command they tried to install.
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is... SUCCESS"
    else
        echo "Installing $2 is... FAILURE"
        exit 1
    fi
}

# 1. check the package alreay installed or not
# 2. If the exit status is equal to "0", then skip
# 3. If the exit status is not equal to "0", then install package
dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo "MySQL is already installed... SKIPPING"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "nginx is already installed... SKIPPING"
fi