#!/bin/bash
# File writing the necessary cronjobs
base_dir="$HOME"

# Define the schedules and the commands to run
cron_schedule_script="0,15,30,45 * * * *"
script_path="$base_dir/ewc_setup/watch_journal_log.sh"
log_file="$base_dir/journal_watchdog.txt"

cron_schedule_restart="0 0 * * *"
restart_command="/sbin/shutdown -r"

# Write the cron jobs to a temporary file
echo "$cron_schedule_script $script_path >> $log_file 2>&1" > mycron
echo "$cron_schedule_restart $restart_command" >> mycron

# Install the new cron jobs from the temporary file -> needs to be root for restart !
# sudo crontab mycron
# Instead of installing the cron directly, output indication on how to do it:
echo "cron can now be installed with sudo crontab mycron"
