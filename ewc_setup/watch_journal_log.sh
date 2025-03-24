#!/bin/bash
# Bash script that checks the journalctl logs of the retrieval service and restarts it 
# in case no logs are founds. 
# Run with a cronjon with the following:
# 0,15,30,45 * * * * /usr/bin/bash /home/eric/eprofile_dl_oper/ewc_setup/watch_journal_log.sh >> /home/eric/journal_watchdog.txt
# Define the service to restart (change this to your desired service)
SERVICE_NAME="retrieval.service"

# Check the journalctl logs for the last 10 minutes
journalctl_output=$(journalctl --since="10 min ago" -u $SERVICE_NAME)

# Check if "No entries" is in the output
if echo "$journalctl_output" | grep -q "No entries"; then
    restart_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "No entries found in journalctl logs in the last 10 min. Restarting $SERVICE_NAME at: $restart_time"
    sudo systemctl restart retrieval.service
    if [ $? -eq 0 ]; then
        echo "$SERVICE_NAME restarted successfully."
    else
        echo "Failed to restart $SERVICE_NAME"
    fi
fi
