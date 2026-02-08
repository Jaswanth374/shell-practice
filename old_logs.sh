#!/bin/bash

# -------- Variables --------
LOG_PATH="/app/log"
ARCHIVE_BASE="/app/log/archive"
DAYS=14

JOB_LOG_DIR="/var/log/old_log_job"
JOB_LOG="$JOB_LOG_DIR/archival.log"

DATE=$(date +%F)
ARCHIVE_DIR="$ARCHIVE_BASE/$DATE"
ARCHIVE_FILE="$ARCHIVE_DIR/logs_$DATE.tar.gz"

R="\e[31m"; G="\e[32m"; Y="\e[33m"; N="\e[0m"

# -------- Setup --------
mkdir -p "$JOB_LOG_DIR" "$ARCHIVE_DIR"

# Root check
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$R Please run as root $N" | tee -a "$JOB_LOG"
    exit 1
fi

echo "----- Archival job started at $(date) -----" >> "$JOB_LOG"

# -------- Find old files --------
oldfiles=$(find "$LOG_PATH" -type f -name "*.log" -mtime +$DAYS)

if [ -z "$oldfiles" ]; then
    echo -e "$Y No log files older than $DAYS days $N" | tee -a "$JOB_LOG"
    exit 0
fi

echo "Files to archive:" >> "$JOB_LOG"
echo "$oldfiles" >> "$JOB_LOG"

# -------- Archive --------
tar -czf "$ARCHIVE_FILE" $oldfiles

if [ $? -ne 0 ]; then
    echo -e "$R Archival failed $N" | tee -a "$JOB_LOG"
    exit 1
fi

# -------- Delete original files --------
rm -f $oldfiles

if [ $? -eq 0 ]; then
    echo -e "$G Archival and deletion successful $N" | tee -a "$JOB_LOG"
else
    echo -e "$R Deletion failed $N" | tee -a "$JOB_LOG"
    exit 1
fi

echo -e "----- Job completed at $(date) -----" >> "$JOB_LOG"
