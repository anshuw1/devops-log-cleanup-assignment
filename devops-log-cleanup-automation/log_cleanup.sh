#!/bin/bash

# path where logs are stored
LOG_DIR="/home/ec2-user/demo_logs"

# S3 bucket for backup
S3_BUCKET="s3://logs-backup-anshu"

# email for report
EMAIL="anshuwaghmare1111@gmail.com"

# report file
REPORT="/tmp/log_cleanup_report.txt"

SUCCESS=0
FAIL=0

echo "Log cleanup report $(date)" > $REPORT
echo "--------------------------------" >> $REPORT

# check if log folder exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Log directory not found: $LOG_DIR" | tee -a $REPORT
    exit 1
fi

echo "Looking for old log files in $LOG_DIR" | tee -a $REPORT

# find .log files older than 30 days
FILES=$(find $LOG_DIR -name "*.log" -mtime +30)

if [ -z "$FILES" ]; then
    echo "No old log files found." | tee -a $REPORT
else

for file in $FILES
do
    echo "Processing file: $file" | tee -a $REPORT

    # upload to S3
    aws s3 cp "$file" "$S3_BUCKET/"

    if [ $? -eq 0 ]; then
        echo "Upload successful: $file" | tee -a $REPORT

        # delete file from server
        rm "$file"
        echo "Deleted local file: $file" | tee -a $REPORT

        SUCCESS=$((SUCCESS+1))
    else
        echo "Upload failed: $file" | tee -a $REPORT
        FAIL=$((FAIL+1))
    fi

done

fi

echo "" >> $REPORT
echo "Summary" | tee -a $REPORT
echo "Successful uploads: $SUCCESS" | tee -a $REPORT
echo "Failed uploads: $FAIL" | tee -a $REPORT

# send email report
BODY=$(cat $REPORT)

aws ses send-email \
--from "$EMAIL" \
--destination "ToAddresses=$EMAIL" \
--message "Subject={Data=Log Cleanup Report},Body={Text={Data=\"$BODY\"}}"

echo "Email report sent."

