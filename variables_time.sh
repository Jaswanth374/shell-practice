#!/bin/bash

TIME=$(date +%s)
echo "script executed at:: $TIME"
sleep 10
ENDTIME=$(date +%s)
echo "script executed at:: $ENDTIME"
Total_Time=$(($ENDTIME - $TIME))
echo "Total time to execute the script:: $Total_Time"