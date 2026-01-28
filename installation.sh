#!/bin/bash
userid=$(id -u)
if [ $userid -e 0 ]; then
echo "print the exit code:: $?"
dnf install nginx
else
echo "Not having a root access to execute. exit code return as:: $?"
fi
