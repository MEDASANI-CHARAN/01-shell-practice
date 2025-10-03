#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python" "nginx" "httpd")

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

for package in ${PACKAGES[@]}
do
    dnf list installed mysql &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed... going to install" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package is already installed... $Y SKIPPING $N" | tee -a $LOG_FILE
    fi
done