#   How It Works:
#     $SOURCE_DIRS: List of directories you want to back up.
#     $BACKUP_DIR: Where the backup file will be stored.
#     $LOG_FILE: Logs all the actions taken by the script.
#     $EMAIL: Your email for notifications.
#     The script compresses the directories into a .zip file and stores it in the backup directory with a timestamped filename.
#     Logs success or failure and sends you an email notification.
#   How to Use:
#     Replace "C:\Path\To\Dir1", "C:\Path\To\Dir2" with the directories you want to back up.
#     Set $BACKUP_DIR, $LOG_FILE, and $EMAIL to your preferences.
#     Ensure you have the SMTP server configured for email notifications.
#     Schedule the script to run at intervals using Task Scheduler.

# Configurable stuff
$SOURCE_DIRS = @("C:\Path\To\Dir1", "C:\Path\To\Dir2")
$BACKUP_DIR = "C:\backup"
$LOG_FILE = "C:\logs\backup.log"
$TIMESTAMP = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$BACKUP_FILE = "$BACKUP_DIR\backup_$TIMESTAMP.zip"
$EMAIL = "youremail@example.com"
$SMTP_SERVER = "smtp.yourserver.com"

# Function to log messages
function log_message {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $LOG_FILE
}

# Function to send email
function send_email {
    param (
        [string]$subject,
        [string]$body
    )
    $mailMessage = New-Object system.net.mail.mailmessage
    $mailMessage.From = "backup@yourdomain.com"
    $mailMessage.To.Add($EMAIL)
    $mailMessage.Subject = $subject
    $mailMessage.Body = $body
    $smtpClient = New-Object system.net.mail.smtpclient($SMTP_SERVER)
    $smtpClient.Send($mailMessage)
}

# Start the backup process
log_message "Backup started."
try {
    Compress-Archive -Path $SOURCE_DIRS -DestinationPath $BACKUP_FILE
    log_message "Backup completed successfully."
    send_email -subject "Backup Successful" -body "Your backup has been created successfully: $BACKUP_FILE"
} catch {
    log_message "Backup failed: $_"
    send_email -subject "Backup Failed" -body "The backup process failed. Check the log file for details: $LOG_FILE"
}
