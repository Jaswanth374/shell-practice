#!/bin/bash
#writing a shell script to use functions

userid=$(id -u)
if [ $userid -ne 0 ]; then
echo "User is not having root access to install"
else
echo "User have access to install required softwares"
fi

FUNC(){
    if [ $1 -ne 0 ]; then
    echo "$2 ----> SUCCESS"
    else
    echo "$2 ----> FAILURE"
    fi
}

dnf install nginx -y
FUNC $? "Installing the nginx"
dnf install mysql -y
FUNC $? "Installing the mysql"