#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started ececuting at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 # Give other then 0 upto 127
else
    echo -e "$G You are running with root access $N" | tee -a $LOG_FILE
fi

# validate function takes input as exit status, what command they tried to install.
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "Installing $2 is... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# 1. check the package alreay installed or not
# 2. If the exit status is equal to "0", then skip
# 3. If the exit status is not equal to "0", then install package
dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install" | tee -a $LOG_FILE
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo -e "MySQL is already installed... $Y SKIPPING $N" | tee -a $LOG_FILE
fi

dnf list installed nginx #&>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install" | tee -a $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e "nginx is already installed... $Y SKIPPING $N" | tee -a $LOG_FILE
fi