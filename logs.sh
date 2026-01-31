#!/bin/bash
#writing a shell script to use functions and logs
R='\e[0;31m'
G='\e[0;32m'
N='\e[0m'
userid=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"
mkdir -p $LOGS_FOLDER

if [ $userid -ne 0 ]; then
echo -e "$R User is not having root access to install $N" | tee -a $LOGS_FILE
exit 1
else
echo -e "$G User have access to install required softwares $N" | tee -a $LOGS_FILE
fi

FUNC(){
    if [ $1 -ne 0 ]; then
    echo -e "$2 ----> $R FAILURE $N " 
    else
    echo -e "$2 ----> $G SUCCESS $N"
    fi
}

for SOFTWARE in "$@";
do
dnf list installed $SOFTWARE &>>$LOGS_FILE
if [ $? -ne 0 ]; then
echo -e "$G No $SOFTWARE software available $N... Proceed with a clean installation" | tee -a $LOGS_FILE
dnf install $SOFTWARE -y  &>>$LOGS_FILE
FUNC $? "Installing $software"
else
echo -e "$R $SOFTWARE software available $N... Proceed with a removal and go with installation again" | tee -a $LOGS_FILE
systemctl stop $SOFTWARE &>>$LOGS_FILE
systemctl disable $SOFTWARE &>>$LOGS_FILE
dnf remove $SOFTWARE &>>$LOGS_FILE
dnf install $SOFTWARE -y &>>$LOGS_FILE
FUNC $? "re-installing $SOFTWARE"
fi
done
