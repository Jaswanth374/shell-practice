#!/bin/bash
userid=$(id -u)
echo "print the user id:: $userid"
if [ $userid -eq 0 ]; then
echo "print the exit code:: $?"
dnf install nginx -y
exit 1
else
echo "Not having a root access to execute. exit code return as:: $?"
fi
