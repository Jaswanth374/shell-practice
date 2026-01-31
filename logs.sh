#!/bin/bash
#writing a shell script to use functions
set -e
R='\e[0;31m'
G='\e[0;32m'
N='\e[0m'
userid=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $userid -ne 0 ]; then
echo -e "$R User is not having root access to install $N"
exit 1
else
echo -e "$G User have access to install required softwares $N"
fi
mkdir -p $LOGS_FOLDER

FUNC(){
    if [ $1 -ne 0 ]; then
    echo -e "$2 ----> $R FAILURE $N " 
    else
    echo -e "$2 ----> $G SUCCESS $N"
    fi
}

for SOFTWARE in "$@";
do
dnf list installed $SOFTWARE
if [ $? -ne 0 ]; then
echo -e "$G No $SOFTWARE software available $N... Proceed with a clean installation"
dnf install $SOFTWARE -y
FUNC $? "Installing $software"
else
echo -e "$R $SOFTWARE software available $N... Proceed with a removal and go with installation again"
systemctl stop $SOFTWARE
systemctl disable $SOFTWARE
dnf remove $SOFTWARE
dnf install $SOFTWARE -y
FUNC $? "re-installing $SOFTWARE"
fi
done
