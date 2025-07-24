#!/bin/bash

echo "----- Simple Server Monitoring -----"
echo "Date: $(date)"
echo "------------------------------------"

# CPU Load
echo "CPU Load:"
uptime | awk -F'load average:' '{ print $2 }'

# Memory Usage
echo "Memory Usage:"
free -h

# Disk Usage
echo "Disk Usage:"
df -h /

# Uptime
echo "Server Uptime:"
uptime -p

echo "------------------------------------"
