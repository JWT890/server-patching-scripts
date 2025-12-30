#!/bin/bash

function apply_linux_patch() {
    echo "Applying Linux patch"
    if command -v yum >/dev/null 2>&1; then
        sudo yum update -y
    elif command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update -y
    else
        echo "Unsupported package manager. Please update manually or check the system."
    fi
}

function send_email() {
    local subject="$1"
    local body="$2"
    local recipient="$3"
    local sender="$4"
    local smtp_server="$5"

    echo "$body" | mail -s "$subject" "$recipient" -u "$sender" -S smtp="$smtp_server" -S smtp-use-starttls
    
}

echo "$(date) - Starting Linux patch process" >> $LOG_FILE
apply_linux_patch
echo "$(date) - Completed Linux patch process" >> $LOG_FILE