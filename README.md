# DevOps Log Cleanup Automation

## Overview
Application servers continuously generate logs inside `/var/log`. Over time, these logs accumulate and consume disk space, which can lead to application failures or server instability.

This project implements an automated solution to manage logs by identifying log files older than 30 days, archiving them to Amazon S3, and deleting them locally after successful upload. The script also sends an execution report via Amazon SES.

The solution demonstrates DevOps practices such as automation, cloud storage, monitoring, and scalable deployment.

---

## Architecture

EC2 Instance  
→ Bash Script Execution  
→ Identify old logs  
→ Upload logs to Amazon S3  
→ Delete local files after successful upload  
→ Send execution report via Amazon SES  

For large-scale deployments, the script can be executed across multiple instances using AWS Systems Manager (SSM).

---

## Technologies Used

- Bash Scripting
- Amazon EC2
- Amazon S3
- Amazon SES
- AWS IAM
- AWS Systems Manager (SSM)
- Cron (Linux Scheduler)
- Git & GitHub

---

## Features

- Automatically detects `.log` files older than 30 days
- Uploads archived logs to an S3 bucket
- Deletes local logs only after successful upload
- Generates execution report
- Sends email notification via Amazon SES
- Can be scheduled using cron
- Supports scalable execution across multiple EC2 instances using AWS Systems Manager

---

## Prerequisites

Before running the script, ensure the following:

- AWS account configured
- IAM role attached to EC2 instance with permissions:
  - `s3:PutObject`
  - `ses:SendEmail`
  - `AmazonSSMManagedInstanceCore`
- AWS CLI installed on EC2
- Verified email identity in Amazon SES
- S3 bucket created for log storage

---

## Script Workflow

1. Check if AWS CLI is installed.
2. Validate log directory existence.
3. Check connectivity to the S3 bucket.
4. Identify `.log` files older than 30 days.
5. Upload logs to S3.
6. Delete local logs only after successful upload.
7. Generate execution report.
8. Send report via Amazon SES.

---

## Script Workflow

1. Check if AWS CLI is installed.
2. Validate log directory existence.
3. Check connectivity to the S3 bucket.
4. Identify `.log` files older than 30 days.
5. Upload logs to S3.
6. Delete local logs only after successful upload.
7. Generate execution report.
8. Send report via Amazon SES.

---

## Running the Script

Make the script executable:

```bash
chmod +x log_cleanup.sh

./log_cleanup.sh



