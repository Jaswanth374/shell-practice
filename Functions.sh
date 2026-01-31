#!/bin/bash
#writing a shell script to use functions

R='\e[0;31m'
G='\e[0;32m'
N='\e[0m'
userid=$(id -u)
if [ $userid -ne 0 ]; then
echo "${R} User is not having root access to install ${N}
exit 1
else
echo "$G User have access to install required softwares $N"
fi

FUNC(){
    if [ $1 -ne 0 ]; then
    echo "$2 ----> $R FAILURE $N"
    else
    echo "$2 ----> $G SUCCESS $N"
    fi
}

dnf install nginx -y
FUNC $? "Installing the nginx"
dnf install mysql -y
FUNC $? "Installing the mysql"