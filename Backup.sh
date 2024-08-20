#!/bin/bash
#    How It Works:
#      SOURCE_DIRS: List of directories you want to back up.
#      BACKUP_DIR: Where the backup file will be stored.
#      LOG_FILE: Logs all the actions taken by the script.
#      EMAIL: Your email for notifications.
#      The script compresses the directories into a .tar.gz file and stores it in the backup directory with a timestamped filename.
#      Logs success or failure and sends you an email notification.
#    How to Use:
#      Replace "/etc" "/var/www" "/home/user" with the directories you want to back up.
#      Set BACKUP_DIR, LOG_FILE, and EMAIL to your preferences.
#      Make sure you have mail configured on your system for email notifications.
#      Schedule the script to run at intervals using cron.

# Configurable this stuff
SOURCE_DIRS=("/etc" "/var/www" "/home/user")
BACKUP_DIR="/backup"
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
EMAIL="youremail@example.com"

# Function to log messages
log_message() {
    echo "$TIMESTAMP - $1" >> $LOG_FILE
}

# Function to send email
send_email() {
    SUBJECT=$1
    BODY=$2
    echo "$BODY" | mail -s "$SUBJECT" $EMAIL
}

# Start the backup process
log_message "Backup started."
if tar -czf $BACKUP_FILE ${SOURCE_DIRS[@]}; then
    log_message "Backup completed successfully."
    send_email "Backup Successful" "Your backup has been created successfully: $BACKUP_FILE"
else
    log_message "Backup failed."
    send_email "Backup Failed" "The backup process failed. Check the log file for details: $LOG_FILE"
fi
