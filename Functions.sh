#!/bin/bash
#writing a shell script to use functions

R='\e[0;31m'
G='\e[0;32m'
N='\e[0m'
SOFTWARE=(nginx mysql)
userid=$(id -u)
if [ $userid -ne 0 ]; then
echo -e "$R User is not having root access to install $N"
exit 1
else
echo -e "$G User have access to install required softwares $N"
fi

FUNC(){
    if [ $1 -ne 0 ]; then
    echo -e "$2 ----> $R FAILURE $N"
    else
    echo -e "$2 ----> $G SUCCESS $N"
    fi
}

for status in "${SOFTWARE[@]}";
do
dnf list installed $status
if [ $? -ne 0 ]; then
echo -e "$G No $status software available $N... Proceed with a clean installation"
dnf install $status -y
else
echo -e "$R $status software available $N... Proceed with a removal and go with installation again"
systemctl stop $status
systemctl disable $status
dnf remove $status
dnf install $status -y
FUNC $? "Installing the $status"
fi
done
