#!/bin/bash
userid=$(id -u)
echo "print the exit code:: $?"
if [ $userid -eq 0 ]; then
dnf install nginx -y
exit 1
else
echo "Not having a root access to execute. exit code return as:: $?"
fi
