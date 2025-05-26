#!/bin/bash

# Powered by: k14d1u5
# Date: 23/05/2025
# Description: Script to allow to check periodically the content of a specific directory

while true; do
    clear
    ls -la /opt/backups/files/dashboard/uploads/
    echo
    echo "Press ENTER to exit or wai 1 second to continue..."

    read -t 1 -p "" input
    if [[ $? -eq 0 ]]; then
        # User pressed ENTER
        break
    fi
done
