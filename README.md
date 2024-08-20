# Automated Backup Scripts

This repository contains two simple scripts for automating backups on Linux/Mac and Windows systems. Each script compresses specified directories into a backup file, logs the process, and sends an email notification on success or failure.

## Scripts Included

- **Linux/Mac Backup Script**: `backup_script.sh`
- **Windows Backup Script**: `backup_script.ps1`

## How It Works

### Linux/Mac (`backup_script.sh`)

- **SOURCE_DIRS**: List of directories to back up.
- **BACKUP_DIR**: Location where the backup file will be stored.
- **LOG_FILE**: File where backup actions are logged.
- **EMAIL**: Email address for notifications.

The script compresses the directories into a `.tar.gz` file, logs the process, and sends an email notification on success or failure.

### Windows (`backup_script.ps1`)

- **$SOURCE_DIRS**: Array of directories to back up.
- **$BACKUP_DIR**: Location where the backup file will be stored.
- **$LOG_FILE**: File where backup actions are logged.
- **$EMAIL**: Email address for notifications.
- **$SMTP_SERVER**: SMTP server for sending email notifications.

The script compresses the directories into a `.zip` file, logs the process, and sends an email notification on success or failure.

## Usage

### Linux/Mac

1. Replace the directories in `SOURCE_DIRS` with the directories you want to back up.
2. Set `BACKUP_DIR`, `LOG_FILE`, and `EMAIL` to your preferences.
3. Ensure your system is configured to send emails (e.g., with `mail`).
4. Make the script executable:
   ```bash
   chmod +x backup_script.sh
5. Run the script:
   ```bash
   ./backup_script.sh
6. Schedule the script using cron for automated backups.


### Windows

1. Replace the paths in `$SOURCE_DIRS` with the directories you want to back up.
2. Set `$BACKUP_DIR`, `$LOG_FILE`, `$EMAIL`, and `$SMTP_SERVER` to your preferences.
3. Run the script manually or set it up in Task Scheduler for automated backups:
   ```powershell
   \backup_script.ps1
