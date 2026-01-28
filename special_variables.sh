#!/bin/bash

#This script used to provide the special variables used in shell script

echo "All arguments passed to the script:: $@"
echo "Number of variables passed to the script"" $#"
echo "script Name:: $0"
echo "Present work dir:: $PWD"
echo "User details:: $USER"
echo "user home directory:: $HOME"
echo "PID of the script:: $$"
sleep 10 &
echo "background process PID:: $!"
echo "All arguments passed to the script:: $*"
